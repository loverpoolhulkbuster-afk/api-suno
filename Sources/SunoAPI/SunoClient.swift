import Foundation

/// Cliente para la API de Suno con manejo robusto de errores y reintentos
public class SunoAPIClient {
    private let apiKey: String
    private let baseURL = "https://api.sunoapi.org"
    
    // MARK: - Configuration
    private let maxRetries = 3
    private let retryDelay: TimeInterval = 1.0
    private let maxTimeoutInterval: TimeInterval = 120
    private var sessionConfig: URLSessionConfiguration
    
    /// Inicializa el cliente con tu API Key
    /// - Parameter apiKey: Tu API Key de Suno (formato: sk_live_...)
    public init(apiKey: String) {
        self.apiKey = apiKey
        
        // Configurar sesión robusta
        self.sessionConfig = URLSessionConfiguration.default
        self.sessionConfig.timeoutIntervalForRequest = 30
        self.sessionConfig.timeoutIntervalForResource = 300
        self.sessionConfig.waitsForConnectivity = true
        self.sessionConfig.shouldUseExtendedBackgroundIdleMode = true
        self.sessionConfig.requestCachePolicy = .useProtocolCachePolicy
    }
    
    // MARK: - Helper Methods
    
    private lazy var session: URLSession = {
        URLSession(configuration: sessionConfig)
    }()
    
    /// Valida que el API Key sea válido
    private func validateAPIKey() throws {
        guard !apiKey.isEmpty else {
            throw SunoAPIError.invalidAPIKey
        }
        guard apiKey.hasPrefix("sk_") else {
            throw SunoAPIError.invalidAPIKey
        }
    }
    
    /// Realiza una solicitud HTTP con reintentos automáticos
    private func performRequest<T: Decodable>(
        url: URL,
        method: String = "GET",
        body: Data? = nil,
        decodeTo: T.Type,
        retryCount: Int = 0
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = maxTimeoutInterval
        
        if let body = body {
            request.httpBody = body
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw SunoAPIError.networkError
            }
            
            // Manejar códigos de estado específicos
            switch httpResponse.statusCode {
            case 200...299:
                // Éxito
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
                
            case 401, 403:
                // Problemas de autenticación
                throw SunoAPIError.unauthorizedError
                
            case 429:
                // Rate limiting - reintentar con backoff
                if retryCount < maxRetries {
                    let delay = retryDelay * pow(2.0, Double(retryCount))
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                    return try await performRequest(
                        url: url,
                        method: method,
                        body: body,
                        decodeTo: decodeTo,
                        retryCount: retryCount + 1
                    )
                }
                throw SunoAPIError.rateLimitExceeded
                
            case 500...599:
                // Error del servidor - reintentar
                if retryCount < maxRetries {
                    let delay = retryDelay * pow(2.0, Double(retryCount))
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                    return try await performRequest(
                        url: url,
                        method: method,
                        body: body,
                        decodeTo: decodeTo,
                        retryCount: retryCount + 1
                    )
                }
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    throw SunoAPIError.serverError(errorResponse.error)
                }
                throw SunoAPIError.serverError("Error HTTP \(httpResponse.statusCode)")
                
            default:
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    throw SunoAPIError.serverError(errorResponse.error)
                }
                throw SunoAPIError.serverError("Error HTTP \(httpResponse.statusCode)")
            }
            
        } catch let error as SunoAPIError {
            throw error
        } catch let error as URLError {
            // Reintentar en errores de red transitorios
            if retryCount < maxRetries && isTransientError(error) {
                let delay = retryDelay * pow(2.0, Double(retryCount))
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                return try await performRequest(
                    url: url,
                    method: method,
                    body: body,
                    decodeTo: decodeTo,
                    retryCount: retryCount + 1
                )
            }
            throw SunoAPIError.networkError
        } catch {
            throw SunoAPIError.decodingError
        }
    }
    
    /// Determina si un error de URLError es transitorio y puede reintentar
    private func isTransientError(_ error: URLError) -> Bool {
        switch error.code {
        case .timedOut, .networkConnectionLost, .notConnectedToInternet,
             .cannotConnectToHost, .cannotFindHost, .dnsLookupFailed:
            return true
        default:
            return false
        }
    }
    
    // MARK: - Generate Song
    
    /// Genera una nueva canción
    /// - Parameters:
    ///   - prompt: Descripción de la canción (mínimo 10 caracteres)
    ///   - model: Modelo a usar (V4_5ALL, V4, V3)
    ///   - makeInstrumental: Si es solo instrumental
    /// - Returns: Respuesta con datos de la tarea
    public func generateSong(
        prompt: String,
        model: String = "V4_5ALL",
        makeInstrumental: Bool = false
    ) async throws -> GenerateSongResponse {
        try validateAPIKey()
        
        guard prompt.count >= 10 else {
            throw SunoAPIError.invalidPrompt
        }
        
        let endpoint = "/api/v1/suno/create"
        guard let url = URL(string: baseURL + endpoint) else {
            throw SunoAPIError.invalidURL
        }
        
        let payload: [String: Any] = [
            "prompt": prompt,
            "model": model,
            "make_instrumental": makeInstrumental,
            "wait_audio": false
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: payload)
        
        return try await performRequest(
            url: url,
            method: "POST",
            body: jsonData,
            decodeTo: GenerateSongResponse.self
        )
    }
    
    // MARK: - Get Task Status
    
    /// Obtiene el estado de una tarea
    /// - Parameter taskId: ID de la tarea
    /// - Returns: Estado actual de la tarea
    public func getTaskStatus(taskId: String) async throws -> TaskStatusResponse {
        try validateAPIKey()
        
        guard !taskId.isEmpty else {
            throw SunoAPIError.invalidTaskId
        }
        
        let endpoint = "/api/v1/suno/task/\(taskId)"
        guard let url = URL(string: baseURL + endpoint) else {
            throw SunoAPIError.invalidURL
        }
        
        return try await performRequest(
            url: url,
            method: "GET",
            decodeTo: TaskStatusResponse.self
        )
    }
    
    // MARK: - Get User Info
    
    /// Obtiene información del usuario y su plan
    /// - Returns: Información del usuario
    public func getUserInfo() async throws -> UserInfoResponse {
        try validateAPIKey()
        
        let endpoint = "/api/v1/suno/user"
        guard let url = URL(string: baseURL + endpoint) else {
            throw SunoAPIError.invalidURL
        }
        
        return try await performRequest(
            url: url,
            method: "GET",
            decodeTo: UserInfoResponse.self
        )
    }
    
    // MARK: - Health Check
    
    /// Verifica la conectividad con la API
    public func healthCheck() async throws -> Bool {
        try validateAPIKey()
        
        do {
            _ = try await getUserInfo()
            return true
        } catch {
            return false
        }
    }
}
