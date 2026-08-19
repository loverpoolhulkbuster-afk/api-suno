# 🚀 Guía de Configuración - SunoAPI

Esta guía te ayudará a configurar y usar el cliente Swift de Suno.

## 1. Clonar el Repositorio

```bash
git clone https://github.com/loverpoolhulkbuster-afk/api-suno.git
cd api-suno
```

## 2. Generar el Cliente API

```bash
swift package --allow-writing-to-package-directory generate-api
```

Este comando ejecutará el plugin de CreateAPI que:
- Lee el esquema OpenAPI desde `Sources/SunoAPI/schema.json`
- Usa la configuración en `Sources/SunoAPI/.create-api.yml`
- Genera archivos Swift en `Sources/SunoAPI/Generated/`

### Resultado esperado:

```
🎵 Generando cliente para la API de Suno...
✅ ¡Cliente API generado exitosamente!
📁 Archivos en: Sources/SunoAPI/Generated/
```

## 3. Verificar la Generación

```bash
ls -la Sources/SunoAPI/Generated/
```

Deberías ver:
- `Paths.swift` - Endpoints y rutas
- `Entities.swift` - Modelos de datos

## 4. Integrar en tu Proyecto

### Opción A: Como Dependencia en Package.swift

```swift
.package(url: "https://github.com/loverpoolhulkbuster-afk/api-suno.git", branch: "main")
```

### Opción B: En Xcode

1. File → Add Packages
2. Pega: `https://github.com/loverpoolhulkbuster-afk/api-suno.git`
3. Selecciona `main`
4. Add to Project

## 5. Obtener API Key de Suno

1. Ve a [suno.ai](https://www.suno.ai)
2. Crea una cuenta o inicia sesión
3. Ve a settings/API keys
4. Genera una nueva API key
5. Guárdala de forma segura

## 6. Usar en tu Código

```swift
import SunoAPI

// Configurar autenticación
let apiKey = "tu-api-key-aqui"

// Crear request
let songRequest = GenerateSongRequest(
    prompt: "Un pop rock uptempo con synths años 80"
)

// Hacer llamada (cuando el cliente esté totalmente generado)
// let response = try await client.generateSong(songRequest)
```

## 7. Solucionar Problemas

### Error: "Plugin 'GenerateAPI' not found"

```bash
# Limpiar cache y reintentar
rm -rf .build
swift package --allow-writing-to-package-directory generate-api
```

### Error: "create-api tool not found"

El archivo binario podría no haberse descargado. Intenta:

```bash
swift package clean
swift package reset
swift package --allow-writing-to-package-directory generate-api
```

### Los archivos generados no aparecen

Verifica que exista `Sources/SunoAPI/schema.json`:

```bash
cat Sources/SunoAPI/schema.json | head -20
```

## 8. Actualizar la API

Si Suno lanza una nueva versión de la API:

1. Descarga el nuevo esquema OpenAPI
2. Reemplaza `Sources/SunoAPI/schema.json`
3. Ejecuta: `swift package --allow-writing-to-package-directory generate-api`
4. Haz commit: `git add -A && git commit -m "Update Suno API schema"`
5. Push: `git push origin main`

## 9. Estructura de Archivos

```
api-suno/
├── Package.swift
├── README.md
├── SETUP.md (este archivo)
├── .gitignore
├── Plugins/
│   └── GenerateAPI/
│       └── Plugin.swift
├── Sources/
│   └── SunoAPI/
│       ├── .create-api.yml
│       ├── schema.json
│       ├── README.md
│       └── Generated/
│           ├── Paths.swift
│           └── Entities.swift
└── Tests/
    └── SunoAPITests/
        └── SunoAPITests.swift
```

## 10. Próximos Pasos

- [ ] Generar el cliente con `swift package generate-api`
- [ ] Revisar los archivos generados en `Sources/SunoAPI/Generated/`
- [ ] Crear ejemplos de uso
- [ ] Implementar tests
- [ ] Publicar a GitHub Releases

## 📚 Recursos Útiles

- [Documentación de Suno API](https://docs.sunoapi.org)
- [CreateAPI GitHub](https://github.com/suno-ai/CreateAPI)
- [Swift Package Manager](https://www.swift.org/package-manager/)
- [OpenAPI Specification](https://spec.openapis.org/)

---

¿Necesitas ayuda? Abre un issue en el repositorio.
