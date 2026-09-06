import Foundation

/// Control de acceso y autenticación para el cliente Suno
public class AccessControl {
    
    // MARK: - Properties
    
    private var apiKeys: [String: APIKeyInfo] = [:]
    private let fileManager = FileManager.default
    private var keysFilePath: URL?
    private var lastAccessLog: [String: Date] = [:]
    private let accessQueue = DispatchQueue(label: "com.suno.accesscontrol", attributes: .concurrent)
    
    // MARK: - Models
    
    /// Información sobre una API Key
    public struct APIKeyInfo: Codable {
        public let id: String
        public let key: String
        public let createdAt: Date
        public var lastUsedAt: Date?
        public var isActive: Bool
        public var rateLimitRequests: Int
        public var rateLimitWindow: TimeInterval // segundos
        public var requestCount: Int = 0
        public var windowStartTime: Date?
        
        public init(
            id: String,
            key: String,
            isActive: Bool = true,
            rateLimitRequests: Int = 100,
            rateLimitWindow: TimeInterval = 3600
        ) {
            self.id = id
            self.key = key
            self.createdAt = Date()
            self.isActive = isActive
            self.rateLimitRequests = rateLimitRequests
            self.rateLimitWindow = rateLimitWindow
        }
    }
    
    /// Sesión de usuario
    public struct SessionInfo {
        public let sessionId: String
        public let apiKeyId: String
        public let createdAt: Date
        public var expiresAt: Date
        public var isValid: Bool {
            return Date() < expiresAt
        }
        
        public init(apiKeyId: String, sessionDuration: TimeInterval = 3600) {
            self.sessionId = UUID().uuidString
            self.apiKeyId = apiKeyId
            self.createdAt = Date()
            self.expiresAt = Date(timeIntervalSinceNow: sessionDuration)
        }
    }
    
    /// Permiso de acceso
    public enum Permission: String, Codable {
        case generate = "generate:song"
        case status = "get:status"
        case userInfo = "get:userinfo"
        case all = "all"
    }
    
    // MARK: - Initialization
    
    public init(keysFilePath: URL? = nil) {
        self.keysFilePath = keysFilePath ?? Self.defaultKeysPath()
        loadStoredKeys()
    }
    
    // MARK: - Key Management
    
    /// Registra una nueva API Key
    public func registerAPIKey(
        _ key: String,
        id: String = UUID().uuidString,
        isActive: Bool = true,
        rateLimitRequests: Int = 100,
        rateLimitWindow: TimeInterval = 3600
    ) throws -> APIKeyInfo {
        guard validateKeyFormat(key) else {
            throw SunoAPIError.invalidAPIKey
        }
        
        guard apiKeys[id] == nil else {
            throw SunoAPIError.serverError("API Key ID ya existe")
        }
        
        let keyInfo = APIKeyInfo(
            id: id,
            key: key,
            isActive: isActive,
            rateLimitRequests: rateLimitRequests,
            rateLimitWindow: rateLimitWindow
        )
        
        accessQueue.async(flags: .barrier) {
            self.apiKeys[id] = keyInfo
        }
        
        try saveKeys()
        return keyInfo
    }
    
    /// Obtiene información de una API Key
    public func getAPIKey(_ id: String) -> APIKeyInfo? {
        var result: APIKeyInfo?
        accessQueue.sync {
            result = apiKeys[id]
        }
        return result
    }
    
    /// Desactiva una API Key
    public func deactivateAPIKey(_ id: String) throws {
        var keyInfo = try getAPIKeyOrThrow(id)
        keyInfo.isActive = false
        
        accessQueue.async(flags: .barrier) {
            self.apiKeys[id] = keyInfo
        }
        
        try saveKeys()
    }
    
    /// Elimina una API Key
    public func deleteAPIKey(_ id: String) throws {
        accessQueue.async(flags: .barrier) {
            self.apiKeys.removeValue(forKey: id)
        }
        
        try saveKeys()
    }
    
    /// Lista todas las API Keys (sin mostrar la clave completa)
    public func listAPIKeys() -> [APIKeyInfo] {
        var result: [APIKeyInfo] = []
        accessQueue.sync {
            result = Array(apiKeys.values)
        }
        return result
    }
    
    // MARK: - Authentication
    
    /// Autentica usando una API Key
    public func authenticateWithKey(_ key: String) throws -> SessionInfo {
        guard validateKeyFormat(key) else {
            throw SunoAPIError.invalidAPIKey
        }
        
        var foundKeyInfo: APIKeyInfo?
        accessQueue.sync {
            foundKeyInfo = apiKeys.values.first { $0.key == key && $0.isActive }
        }
        
        guard let keyInfo = foundKeyInfo else {
            throw SunoAPIError.unauthorizedError
        }
        
        // Actualizar último acceso
        accessQueue.async(flags: .barrier) {
            if var key = self.apiKeys[keyInfo.id] {
                key.lastUsedAt = Date()
                self.apiKeys[keyInfo.id] = key
            }
        }
        
        let session = SessionInfo(apiKeyId: keyInfo.id)
        return session
    }
    
    /// Valida una sesión
    public func validateSession(_ sessionId: String) throws {
        // En una implementación real, aquí se validaría la sesión
        guard !sessionId.isEmpty else {
            throw SunoAPIError.unauthorizedError
        }
    }
    
    // MARK: - Rate Limiting
    
    /// Verifica el rate limit para una API Key
    public func checkRateLimit(_ apiKeyId: String) throws -> Bool {
        guard var keyInfo = getAPIKey(apiKeyId) else {
            throw SunoAPIError.invalidAPIKey
        }
        
        let now = Date()
        
        // Inicializar ventana de tiempo si es necesario
        if keyInfo.windowStartTime == nil {
            keyInfo.windowStartTime = now
            keyInfo.requestCount = 0
        }
        
        // Resetear si pasó la ventana de tiempo
        if let windowStart = keyInfo.windowStartTime,
           now.timeIntervalSince(windowStart) > keyInfo.rateLimitWindow {
            keyInfo.windowStartTime = now
            keyInfo.requestCount = 0
        }
        
        // Incrementar contador
        keyInfo.requestCount += 1
        
        // Actualizar
        accessQueue.async(flags: .barrier) {
            self.apiKeys[apiKeyId] = keyInfo
        }
        
        // Verificar límite
        if keyInfo.requestCount > keyInfo.rateLimitRequests {
            throw SunoAPIError.rateLimitExceeded
        }
        
        return true
    }
    
    /// Obtiene estadísticas de uso
    public func getRateLimitStats(_ apiKeyId: String) -> (requests: Int, limit: Int, windowRemaining: TimeInterval)? {
        guard let keyInfo = getAPIKey(apiKeyId) else {
            return nil
        }
        
        guard let windowStart = keyInfo.windowStartTime else {
            return (0, keyInfo.rateLimitRequests, keyInfo.rateLimitWindow)
        }
        
        let now = Date()
        let elapsed = now.timeIntervalSince(windowStart)
        let remaining = max(0, keyInfo.rateLimitWindow - elapsed)
        
        return (keyInfo.requestCount, keyInfo.rateLimitRequests, remaining)
    }
    
    // MARK: - Access Logging
    
    /// Registra un acceso
    public func logAccess(_ apiKeyId: String, endpoint: String) {
        let key = "\(apiKeyId):\(endpoint)"
        accessQueue.async(flags: .barrier) {
            self.lastAccessLog[key] = Date()
        }
    }
    
    /// Obtiene el último acceso
    public func getLastAccess(_ apiKeyId: String, endpoint: String) -> Date? {
        let key = "\(apiKeyId):\(endpoint)"
        var result: Date?
        accessQueue.sync {
            result = lastAccessLog[key]
        }
        return result
    }
    
    // MARK: - Persistence
    
    /// Guarda las claves en disco
    private func saveKeys() throws {
        guard let filePath = keysFilePath else { return }
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(Array(apiKeys.values))
        
        // Crear directorio si no existe
        try fileManager.createDirectory(at: filePath.deletingLastPathComponent(),
                                       withIntermediateDirectories: true)
        
        try data.write(to: filePath)
    }
    
    /// Carga las claves desde disco
    private func loadStoredKeys() {
        guard let filePath = keysFilePath,
              fileManager.fileExists(atPath: filePath.path) else { return }
        
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let keysArray = try decoder.decode([APIKeyInfo].self, from: data)
            
            accessQueue.async(flags: .barrier) {
                for keyInfo in keysArray {
                    self.apiKeys[keyInfo.id] = keyInfo
                }
            }
        } catch {
            print("Error loading API keys: \(error)")
        }
    }
    
    /// Ruta por defecto para almacenar las claves
    private static func defaultKeysPath() -> URL {
        let appSupport = FileManager.default.urls(for: .applicationSupportDirectory,
                                                   in: .userDomainMask)[0]
        return appSupport.appendingPathComponent("suno_api_keys.json")
    }
    
    // MARK: - Validation
    
    /// Valida el formato de una API Key
    private func validateKeyFormat(_ key: String) -> Bool {
        return key.hasPrefix("sk_") && key.count >= 20
    }
    
    /// Helper para obtener API Key o lanzar error
    private func getAPIKeyOrThrow(_ id: String) throws -> APIKeyInfo {
        guard let keyInfo = getAPIKey(id) else {
            throw SunoAPIError.invalidAPIKey
        }
        return keyInfo
    }
}

// MARK: - Extended SunoAPIError
extension SunoAPIError {
    static let invalidAPIKey = SunoAPIError.serverError("API Key inválida o mal formada")
    static let unauthorizedError = SunoAPIError.serverError("No autorizado")
    static let rateLimitExceeded = SunoAPIError.serverError("Rate limit excedido")
    static let invalidTaskId = SunoAPIError.serverError("Task ID inválido")
    static let invalidURL = SunoAPIError.serverError("URL inválida")
}
