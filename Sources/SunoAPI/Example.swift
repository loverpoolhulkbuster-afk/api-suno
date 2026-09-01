import Foundation

/// Ejemplo de uso del cliente SunoAPI
public struct SunoAPIExample {
    public static func runExample() async {
        let apiKey = "sk_live_YOUR_API_KEY" // Reemplaza con tu key
        let client = SunoAPIClient(apiKey: apiKey)
        
        do {
            // 1. Verificar información del usuario
            print("\n📋 Obteniendo información del usuario...")
            let userInfo = try await client.getUserInfo()
            if let user = userInfo.user {
                print("✅ Usuario: \(user.email ?? "Unknown")")
                print("📊 Plan: \(user.plan)")
                print("🎵 Créditos: \(user.credits ?? 0)")
            }
            
            // 2. Generar una canción
            print("\n🎵 Generando canción...")
            let response = try await client.generateSong(
                prompt: "An upbeat electronic pop song with synthesizers and catchy melody, female vocals, 120 BPM, energetic vibes"
            )
            
            if let firstSong = response.data?.first {
                print("✅ Canción generada exitosamente!")
                print("ID: \(firstSong.id)")
                print("Prompt: \(firstSong.prompt)")
                print("Estado: \(firstSong.status)")
                
                // 3. Verificar estado periódicamente
                print("\n⏳ Esperando a que la canción se genere...")
                var completed = false
                var attempts = 0
                
                while !completed && attempts < 30 {
                    try await Task.sleep(nanoseconds: 2_000_000_000) // 2 segundos
                    attempts += 1
                    
                    let status = try await client.getTaskStatus(taskId: firstSong.id)
                    if let updatedSong = status.data?.first {
                        print("Intento \(attempts): Estado = \(updatedSong.status)")
                        
                        if updatedSong.status == "completed" {
                            print("\n✅ ¡Canción lista!")
                            print("Título: \(updatedSong.title ?? "N/A")")
                            print("Audio URL: \(updatedSong.audioUrl ?? "N/A")")
                            print("Duración: \(updatedSong.duration ?? 0)s")
                            if let lyric = updatedSong.lyric {
                                print("Letra:\n\(lyric)")
                            }
                            completed = true
                        } else if updatedSong.status == "failed" {
                            print("\n❌ La generación falló")
                            completed = true
                        }
                    }
                }
                
                if !completed {
                    print("⏱️ Timeout - sigue verificando con el ID: \(firstSong.id)")
                }
            } else if let error = response.error {
                print("❌ Error: \(error)")
            }
            
        } catch let error as SunoAPIError {
            print("❌ Error SunoAPI: \(error.errorDescription ?? error.localizedDescription)")
        } catch {
            print("❌ Error desconocido: \(error)")
        }
    }
}
