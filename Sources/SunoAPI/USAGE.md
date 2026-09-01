# SunoAPI - Cliente Swift para la API de Suno

## Configuración Rápida

### 1. Instancia el Cliente

```swift
import SunoAPI

let client = SunoAPIClient(apiKey: "sk_live_YOUR_API_KEY")
```

### 2. Verifica tu Plan

```swift
do {
    let userInfo = try await client.getUserInfo()
    if let user = userInfo.user {
        print("Plan: \(user.plan)")
        print("Créditos: \(user.credits ?? 0)")
    }
} catch {
    print("Error: \(error.localizedDescription)")
}
```

### 3. Genera una Canción

```swift
do {
    let response = try await client.generateSong(
        prompt: "An upbeat pop song with synthesizers and catchy melody"
    )
    
    if let firstSong = response.data?.first {
        print("Canción generada: \(firstSong.id)")
        print("Estado: \(firstSong.status)")
    }
} catch let error as SunoAPIError {
    print("Error: \(error.errorDescription ?? error.localizedDescription)")
}
```

### 4. Verifica el Estado

```swift
let status = try await client.getTaskStatus(taskId: "task_id")
if let song = status.data?.first {
    print("Estado: \(song.status)")
    if song.status == "completed" {
        print("Audio: \(song.audioUrl ?? "N/A")")
    }
}
```

## Prompts Efectivos

### ✅ Buenos Prompts
- "An upbeat electronic pop song with synthesizers, female vocals, 120 BPM"
- "A sad indie rock ballad with acoustic guitar and emotional vocals"
- "Calming ambient music with piano and strings for meditation"
- "A Spanish flamenco guitar instrumental with traditional style"

### ❌ Prompts Pobres
- "a song" (muy corto)
- "generate music now!!!" (caracteres especiales)
- "" (vacío)
- Más de 400 caracteres (demasiado largo)

## Manejo de Errores

```swift
do {
    let response = try await client.generateSong(prompt: "Your prompt")
} catch SunoAPIError.invalidAPIKey {
    print("Regenera tu API Key en suno.ai")
} catch SunoAPIError.rateLimited {
    print("Espera 60 segundos antes de intentar de nuevo")
} catch SunoAPIError.serverError(let msg) {
    print("Error del servidor: \(msg)")
} catch {
    print("Error desconocido: \(error)")
}
```

## Estados de Tarea

| Estado | Significado |
|--------|-------------|
| `submitted` | Enviada a procesar |
| `processing` | En proceso |
| `completed` | ✅ Lista para descargar |
| `failed` | ❌ Error durante generación |

## Limits

- **Plan Free**: No disponible
- **Plan Pro**: 100 canciones/mes
- **Plan Max**: 500 canciones/mes

## Documentación

- [Suno API Docs](https://docs.sunoapi.org)
- [Swift Package Manager](https://www.swift.org/package-manager/)
