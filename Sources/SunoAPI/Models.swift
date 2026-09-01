import Foundation

// MARK: - Error Handling

/// Errores de la API de Suno
public enum SunoAPIError: Error, LocalizedError {
    case invalidAPIKey
    case networkError
    case serverError(String)
    case decodingError
    case invalidPrompt
    case rateLimited
    
    public var errorDescription: String? {
        switch self {
        case .invalidAPIKey:
            return "❌ API Key inválida o expirada. Verifica en suno.ai"
        case .networkError:
            return "❌ Error de conexión. Verifica tu conexión a internet"
        case .serverError(let message):
            return "❌ Error del servidor: \(message)"
        case .decodingError:
            return "❌ Error al procesar la respuesta"
        case .invalidPrompt:
            return "❌ El prompt debe tener al menos 10 caracteres"
        case .rateLimited:
            return "⏳ Límite de requests alcanzado. Espera 60 segundos"
        }
    }
}

// MARK: - Response Models

/// Respuesta al generar una canción
public struct GenerateSongResponse: Codable {
    public let data: [SongTask]?
    public let error: String?
}

/// Tarea de generación de canción
public struct SongTask: Codable {
    public let id: String
    public let prompt: String
    public let status: String
    public let audioUrl: String?
    public let imageUrl: String?
    public let title: String?
    public let lyric: String?
    public let duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, prompt, status, title, lyric, duration
        case audioUrl = "audio_url"
        case imageUrl = "image_url"
    }
}

/// Respuesta del estado de tarea
public struct TaskStatusResponse: Codable {
    public let data: [SongTask]?
    public let error: String?
}

/// Respuesta con información del usuario
public struct UserInfoResponse: Codable {
    public let user: UserInfo?
    public let error: String?
}

/// Información del usuario
public struct UserInfo: Codable {
    public let id: String
    public let email: String?
    public let plan: String
    public let credits: Int?
    public let monthlyCredits: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, email, plan, credits
        case monthlyCredits = "monthly_credits"
    }
}

/// Respuesta de error
public struct ErrorResponse: Codable {
    public let error: String
}
