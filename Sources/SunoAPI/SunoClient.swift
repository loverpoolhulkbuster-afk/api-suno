import Foundation

/// Cliente para la API de Suno
public class SunoAPIClient {
    private let apiKey: String
    private let baseURL = "https://api.sunoapi.org"
    
    /// Inicializa el cliente con tu API Key
    /// - Parameter apiKey: Tu API Key de Suno (formato: sk_live_...)
    public init(apiKey: String) {
        self.apiKey = apiKey
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
        guard prompt.count >= 10 else {
            throw SunoAPIError.invalidPrompt
        }
        
        let endpoint = "/api/v1/suno/create"
        let url = URL(string: baseURL + endpoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 60
        
        let payload: [String: Any] = [
            "prompt": prompt,
            "model": model,
            "make_instrumental": makeInstrumental,
            "wait_audio": false
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw SunoAPIError.networkError
        }
        
        if httpResponse.statusCode != 200 {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw SunoAPIError.serverError(errorResponse.error)
            }
            throw SunoAPIError.serverError("Error HTTP \(httpResponse.statusCode)")
        }
        
        let decodedResponse = try JSONDecoder().decode(GenerateSongResponse.self, from: data)
        return decodedResponse
    }
    
    // MARK: - Get Task Status
    
    /// Obtiene el estado de una tarea
    /// - Parameter taskId: ID de la tarea
    /// - Returns: Estado actual de la tarea
    public func getTaskStatus(taskId: String) async throws -> TaskStatusResponse {
        let endpoint = "/api/v1/suno/task/\(taskId)"
        let url = URL(string: baseURL + endpoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw SunoAPIError.networkError
        }
        
        if httpResponse.statusCode != 200 {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw SunoAPIError.serverError(errorResponse.error)
            }
            throw SunoAPIError.serverError("Error HTTP \(httpResponse.statusCode)")
        }
        
        let decodedResponse = try JSONDecoder().decode(TaskStatusResponse.self, from: data)
        return decodedResponse
    }
    
    // MARK: - Get User Info
    
    /// Obtiene información del usuario y su plan
    /// - Returns: Información del usuario
    public func getUserInfo() async throws -> UserInfoResponse {
        let endpoint = "/api/v1/suno/user"
        let url = URL(string: baseURL + endpoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw SunoAPIError.networkError
        }
        
        if httpResponse.statusCode != 200 {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw SunoAPIError.serverError(errorResponse.error)
            }
            throw SunoAPIError.serverError("Error HTTP \(httpResponse.statusCode)")
        }
        
        let decodedResponse = try JSONDecoder().decode(UserInfoResponse.self, from: data)
        return decodedResponse
    }
}
