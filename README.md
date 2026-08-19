# api-suno
Cliente Swift para la API de Suno
swift package --allow-writing-to-package-directory generate-api git add .
git commit -m "Configure Suno API Swift Package with CreateAPI plugin"
git push origin main# Xcode
.DS_Store
.xcodeproj/
.xcworkspace/
xcuserdata/
*.xcarchive
DerivedData/

# Swift Package Manager
.build/
.swiftpm/
*.xcconfig
Package.resolved

# IDE
.vscode/
*.swiftpm

# Generated files (optional)
# Sources/SunoAPI/Generated/module: SunoAPI
mergeSources: true
generateDocumentation: true
optionalNulls: trueimport Foundation
import PackagePlugin

@main
struct GenerateAPIPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let workingDirectory = context.package.directory
            .appending("Sources")
            .appending("SunoAPI")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: workingDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "schema.json",
            "--config", ".create-api.yml",
            "--output", "Generated"
        ]

        print("🎵 Generando cliente para la API de Suno...")
        try process.run()
        process.waitUntilExit()

        if process.terminationStatus == 0 {
            print("✅ ¡Cliente API generado exitosamente!")
            print("📁 Archivos en: Sources/SunoAPI/Generated/")
        } else {
            print("❌ Error durante la generación")
            throw NSError(domain: "GenerateAPIPlugin", code: 1, userInfo: nil)
        }
    }
}// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "SunoAPI",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "SunoAPI", targets: ["SunoAPI"])
    ],
    targets: [
        .target(
            name: "SunoAPI",
            dependencies: [],
            exclude: ["schema.json", ".create-api.yml"]
        ),
        .binaryTarget(
            name: "create-api",
            url: "https://github.com/CreateAPI/CreateAPI/releases/download/0.0.5/create-api.artifactbundle.zip",
            checksum: "89c75ec3b2938d08b961b94e70e6dd6fa0ff52a90037304d41718cd5fb58bd24"
        ),
        .plugin(
            name: "GenerateAPI",
            capability: .command(
                intent: .custom(
                    verb: "generate-api",
                    description: "Genera el cliente Swift desde el esquema OpenAPI de Suno"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Para guardar el código Swift generado")
                ]
            ),
            dependencies: [
                .target(name: "create-api")
            ]
        )
    ]
)mkdir -p Plugins/GenerateAPI
mkdir -p Sources/SunoAPI
mkdir -p .github/workflowsgit clone https://github.com/loverpoolhulkbuster-afk/api-suno.git
cd api-suno# api-suno
Cliente Swift para la API de Suno
import Foundation
import PackagePlugin

@main
struct GenerateAPIPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let workingDirectory = context.package.directory
            .appending("Sources")
            .appending("SunoAPI")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: workingDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "schema.json",
            "--config", ".create-api.yml",
            "--output", "Generated"
        ]

        print("🎵 Generando cliente para la API de Suno...")
        try process.run()
        process.waitUntilExit()

        if process.terminationStatus == 0 {
            print("✅ ¡Cliente API generado exitosamente!")
            print("📁 Archivos en: Sources/SunoAPI/Generated/")
        } else {
            print("❌ Error durante la generación")
            throw NSError(domain: "GenerateAPIPlugin", code: 1, userInfo: nil)
        }
    }
}import Foundation
import PackagePlugin

@main
struct GenerateAPIPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let workingDirectory = context.package.directory
            .appending("Sources")
            .appending("SunoAPI")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: workingDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "schema.json",
            "--config", ".create-api.yml",
            "--output", "Generated"
        ]

        print("🎵 Generando cliente para la API de Suno...")
        try process.run()
        process.waitUntilExit()

        if process.terminationStatus == 0 {
            print("✅ ¡Cliente API generado exitosamente!")
            print("📁 Archivos en: Sources/SunoAPI/Generated/")
        } else {
            print("❌ Error durante la generación")
            throw NSError(domain: "GenerateAPIPlugin", code: 1, userInfo: nil)
        }
    }
}import Foundation
import PackagePlugin

@main
struct GenerateAPIPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let workingDirectory = context.package.directory
            .appending("Sources")
            .appending("SunoAPI")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: workingDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "schema.json",
            "--config", ".create-api.yml",
            "--output", "Generated"
        ]

        print("🎵 Generando cliente para la API de Suno...")
        try process.run()
        process.waitUntilExit()

        if process.terminationStatus == 0 {
            print("✅ ¡Cliente API generado exitosamente!")
            print("📁 Archivos en: Sources/SunoAPI/Generated/")
        } else {
            print("❌ Error durante la generación")
            throw NSError(domain: "GenerateAPIPlugin", code: 1, userInfo: nil)
        }
    }
}// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "SunoAPI",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "SunoAPI", targets: ["SunoAPI"])
    ],
    targets: [
        .target(
            name: "SunoAPI",
            dependencies: [],
            exclude: ["schema.json", ".create-api.yml"]
        ),
        .binaryTarget(
            name: "create-api",
            url: "https://github.com/CreateAPI/CreateAPI/releases/download/0.0.5/create-api.artifactbundle.zip",
            checksum: "89c75ec3b2938d08b961b94e70e6dd6fa0ff52a90037304d41718cd5fb58bd24"
        ),
        .plugin(
            name: "GenerateAPI",
            capability: .command(
                intent: .custom(
                    verb: "generate-api",
                    description: "Genera el cliente Swift desde el esquema OpenAPI de Suno"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Para guardar el código Swift generado")
                ]
            ),
            dependencies: [
                .target(name: "create-api")

                
            ]
        )
    ]
)mkdir -p Plugins/GenerateAPI
mkdir -p Sources/SunoAPI
mkdir -p .github/workflowsgit clone https://github.com/loverpoolhulkbuster-afk/api-suno.git
cd api-suno Cliente Swift para la API de Sunoapi-suno

**.gitignore**
---

**Para crear el repositorio, necesito que me digas:**

1. ¿Tu usuario de GitHub? (ej: `loverpoolhulkbuster-afk`)
2. ¿Nombre del repositorio? (ej: `MyAPI`, `APIClient`, etc.)
3. ¿Es público o privado?
4. ¿URL de la API real que quieres usar? (o usamos el ejemplo de `/users`)

Con esa información, crearé todo automáticamente 🚀api-suno/
├── .gitignore
├── README.md
├── Package.swift
├── Plugins/
│   └── GenerateAPI/
│       └── Plugin.swift
└── Sources/
    └── SunoAPI/
        ├── .create-api.yml
        ├── schema.json          (Suno OpenAPI spec)
        └── README.md// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "SunoAPI",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "SunoAPI", targets: ["SunoAPI"])
    ],
    targets: [
        .target(
            name: "SunoAPI",
            dependencies: [],
            exclude: ["schema.json", ".create-api.yml"]
        ),
        .binaryTarget(
            name: "create-api",
            url: "https://github.com/CreateAPI/CreateAPI/releases/download/0.0.5/create-api.artifactbundle.zip",
            checksum: "89c75ec3b2938d08b961b94e70e6dd6fa0ff52a90037304d41718cd5fb58bd24"
        ),
        .plugin(
            name: "GenerateAPI",
            capability: .command(
                intent: .custom(
                    verb: "generate-api",
                    description: "Genera el cliente Swift desde el esquema OpenAPI de Suno"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "Para guardar el código Swift generado")
                ]
            ),
            dependencies: [
                .target(name: "create-api")
            ]
        )
    ]
)import Foundation
import PackagePlugin

@main
struct GenerateAPIPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        let createAPI = try context.tool(named: "create-api")
        let workingDirectory = context.package.directory
            .appending("Sources")
            .appending("SunoAPI")

        let process = Process()
        process.currentDirectoryURL = URL(fileURLWithPath: workingDirectory.string)
        process.executableURL = URL(fileURLWithPath: createAPI.path.string)
        process.arguments = [
            "generate",
            "schema.json",
            "--config", ".create-api.yml",
            "--output", "Generated"
        ]

        print("🎵 Generando cliente para la API de Suno...")
        try process.run()
        process.waitUntilExit()

        if process.terminationStatus == 0 {
            print("✅ ¡Cliente API generado exitosamente!")
            print("📁 Archivos en: Sources/SunoAPI/Generated/")
        } else {
            print("❌ Error durante la generación")
            throw NSError(domain: "GenerateAPIPlugin", code: 1, userInfo: nil)
        }
    }
}# Configuración de CreateAPI para Suno
module: SunoAPI
mergeSources: true
generateDocumentation: true
optionalNulls: true{
  "openapi": "3.0.0",
  "info": {
    "title": "Suno API",
    "version": "1.0.0",
    "description": "API para generar música con IA usando Suno",
    "contact": {
      "name": "Suno",
      "url": "https://www.suno.ai"
    }
  },
  "servers": [
    {
      "url": "https://api.sunoapi.org",
      "description": "Servidor de Producción"
    }
  ],
  "security": [
    {
      "BearerAuth": []
    }
  ],
  "components": {
    "securitySchemes": {
      "BearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "API Key de Suno"
      }
    },
    "schemas": {
      "GenerateSongRequest": {
        "type": "object",
        "properties": {
          "prompt": {
            "type": "string",
            "description": "Descripción de la canción a generar",
            "example": "Una melodía de guitarra acústica suave con voces suave, estilo folk"
          },
          "customMode": {
            "type": "boolean",
            "default": false,
            "description": "Usar modo personalizado"
          },
          "instrumental": {
            "type": "boolean",
            "default": false,
            "description": "Generar solo instrumental"
          },
          "model": {
            "type": "string",
            "enum": ["V4_5ALL", "V4", "V3"],
            "default": "V4_5ALL",
            "description": "Modelo de IA a utilizar"
          },
          "callBackUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL de callback para notificaciones"
          }
        },
        "required": ["prompt"]
      },
      "GenerateLyricsRequest": {
        "type": "object",
        "properties": {
          "theme": {
            "type": "string",
            "description": "Tema de las letras",
            "example": "Amor y desamor"
          },
          "style": {
            "type": "string",
            "description": "Estilo musical",
            "example": "Rock, Pop, Reggae"
          },
          "mood": {
            "type": "string",
            "description": "Estado de ánimo",
            "example": "Triste, Alegre, Melancólico"
          }
        },
        "required": ["theme"]
      },
      "TaskResponse": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "ID único de la tarea",
            "example": "task_123456"
          },
          "status": {
            "type": "string",
            "enum": ["completed", "processing", "failed"],
            "description": "Estado actual de la tarea"
          },
          "audioUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL del audio generado"
          },
          "title": {
            "type": "string",
            "description": "Título de la canción"
          },
          "imageUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL de la imagen de portada"
          },
          "lyric": {
            "type": "string",
            "description": "Letras de la canción"
          }
        }
      },
      "PersonaRequest": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Nombre de la persona/voz"
          },
          "description": {
            "type": "string",
            "description": "Descripción de características vocales"
          }
        },
        "required": ["name"]
      }
    }
  },
  "paths": {
    "/api/v1/suno/create": {
      "post": {
        "summary": "Generar una canción",
        "tags": ["Music Generation"],
        "operationId": "generateSong",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/GenerateSongRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Canción generada exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TaskResponse"
                }
              }
            }
          },
          "400": {
            "description": "Solicitud inválida"
          },
          "401": {
            "description": "No autorizado"
          }
        }
      }
    },
    "/api/v1/suno/lyrics": {
      "post": {
        "summary": "Generar letras",
        "tags": ["Lyrics"],
        "operationId": "generateLyrics",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/GenerateLyricsRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Letras generadas exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "properties": {
                    "lyrics": {
                      "type": "string"
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/suno/task/{id}": {
      "get": {
        "summary": "Obtener estado de la tarea",
        "tags": ["Task Management"],
        "operationId": "getTaskStatus",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            },
            "description": "ID de la tarea"
          }
        ],
        "responses": {
          "200": {
            "description": "Estado de la tarea",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TaskResponse"
                }
              }
            }
          },
          "404": {
            "description": "Tarea no encontrada"
          }
        }
      }
    },
    "/api/v1/suno/upload-extend": {
      "post": {
        "summary": "Extender una canción existente",
        "tags": ["Audio Transform"],
        "operationId": "extendSong",
        "requestBody": {
          "required": true,
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "audioFile": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Canción extendida"
          }
        }
      }
    },
    "/api/v1/suno/persona": {
      "post": {
        "summary": "Crear una persona/voz de IA",
        "tags": ["Personas"],
        "operationId": "createPersona",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PersonaRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Persona creada"
          }
        }
      }
    }
  }
}{
  "openapi": "3.0.0",
  "info": {
    "title": "Suno API",
    "version": "1.0.0",
    "description": "API para generar música con IA usando Suno",
    "contact": {
      "name": "Suno",
      "url": "https://www.suno.ai"
    }
  },
  "servers": [
    {
      "url": "https://api.sunoapi.org",
      "description": "Servidor de Producción"
    }
  ],
  "security": [
    {
      "BearerAuth": []
    }
  ],
  "components": {
    "securitySchemes": {
      "BearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "API Key de Suno"
      }
    },
    "schemas": {
      "GenerateSongRequest": {
        "type": "object",
        "properties": {
          "prompt": {
            "type": "string",
            "description": "Descripción de la canción a generar",
            "example": "Una melodía de guitarra acústica suave con voces suave, estilo folk"
          },
          "customMode": {
            "type": "boolean",
            "default": false,
            "description": "Usar modo personalizado"
          },
          "instrumental": {
            "type": "boolean",
            "default": false,
            "description": "Generar solo instrumental"
          },
          "model": {
            "type": "string",
            "enum": ["V4_5ALL", "V4", "V3"],
            "default": "V4_5ALL",
            "description": "Modelo de IA a utilizar"
          },
          "callBackUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL de callback para notificaciones"
          }
        },
        "required": ["prompt"]
      },
      "GenerateLyricsRequest": {
        "type": "object",
        "properties": {
          "theme": {
            "type": "string",
            "description": "Tema de las letras",
            "example": "Amor y desamor"
          },
          "style": {
            "type": "string",
            "description": "Estilo musical",
            "example": "Rock, Pop, Reggae"
          },
          "mood": {
            "type": "string",
            "description": "Estado de ánimo",
            "example": "Triste, Alegre, Melancólico"
          }
        },
        "required": ["theme"]
      },
      "TaskResponse": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "ID único de la tarea",
            "example": "task_123456"
          },
          "status": {
            "type": "string",
            "enum": ["completed", "processing", "failed"],
            "description": "Estado actual de la tarea"
          },
          "audioUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL del audio generado"
          },
          "title": {
            "type": "string",
            "description": "Título de la canción"
          },
          "imageUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL de la imagen de portada"
          },
          "lyric": {
            "type": "string",
            "description": "Letras de la canción"
          }
        }
      },
      "PersonaRequest": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Nombre de la persona/voz"
          },
          "description": {
            "type": "string",
            "description": "Descripción de características vocales"
          }
        },
        "required": ["name"]
      }
    }
  },
  "paths": {
    "/api/v1/suno/create": {
      "post": {
        "summary": "Generar una canción",
        "tags": ["Music Generation"],
        "operationId": "generateSong",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/GenerateSongRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Canción generada exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TaskResponse"
                }
              }
            }
          },
          "400": {
            "description": "Solicitud inválida"
          },
          "401": {
            "description": "No autorizado"
          }
        }
      }
    },
    "/api/v1/suno/lyrics": {
      "post": {
        "summary": "Generar letras",
        "tags": ["Lyrics"],
        "operationId": "generateLyrics",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/GenerateLyricsRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Letras generadas exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "properties": {
                    "lyrics": {
                      "type": "string"
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/suno/task/{id}": {
      "get": {
        "summary": "Obtener estado de la tarea",
        "tags": ["Task Management"],
        "operationId": "getTaskStatus",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            },
            "description": "ID de la tarea"
          }
        ],
        "responses": {
          "200": {
            "description": "Estado de la tarea",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TaskResponse"
                }
              }
            }
          },
          "404": {
            "description": "Tarea no encontrada"
          }
        }
      }
    },
    "/api/v1/suno/upload-extend": {
      "post": {
        "summary": "Extender una canción existente",
        "tags": ["Audio Transform"],
        "operationId": "extendSong",
        "requestBody": {
          "required": true,
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "audioFile": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Canción extendida"
          }
        }
      }
    },
    "/api/v1/suno/persona": {
      "post": {
        "summary": "Crear una persona/voz de IA",
        "tags": ["Personas"],
        "operationId": "createPersona",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PersonaRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Persona creada"
          }
        }# SunoAPI - Cliente Swift para Suno

[![Swift](https://img.shields.io/badge/Swift-5.6%2B-orange)]()
[![Platform](https://img.shields.io/badge/Platform-iOS%2013%2B%20%7C%20macOS%2010.15%2B-blue)]()
[![License](https://img.shields.io/badge/License-MIT-green)]()

Un cliente Swift generado automáticamente desde el esquema OpenAPI de Suno usando [CreateAPI](https://github.com/suno-ai/CreateAPI) y Swift Package Manager.

## 🎵 Características

- ✅ Generar canciones con IA
- ✅ Generar letras automáticamente
- ✅ Verificar estado de tareas
- ✅ Extender canciones existentes
- ✅ Crear personajes/voces de IA
- ✅ Procesamiento de audio (stem separation, audio-to-MIDI, etc.)
- ✅ Completamente tipado en Swift

## 📋 Requisitos

- Swift 5.6+ (Xcode 13.4+)
- macOS 10.15+ (el artifact bundle actualmente solo soporta macOS)

## 🚀 Instalación

### Via SPM (Swift Package Manager)

Agrega a tu `Package.swift`:

```swift
.package(url: "https://github.com/loverpoolhulkbuster-afk/api-suno.git", branch: "main")
      }
    }
  }# Configuración de CreateAPI para Suno
module: SunoAPI
mergeSources: true
generateDocumentation: true
optionalNulls: true{
  "openapi": "3.0.0",
  "info": {
    "title": "Suno API",
    "version": "1.0.0",
    "description": "API para generar música con IA usando Suno",
    "contact": {
      "name": "Suno",
      "url": "https://www.suno.ai"
    }
  },
  "servers": [
    {
      "url": "https://api.sunoapi.org",
      "description": "Servidor de Producción"
    }
  ],
  "security": [
    {
      "BearerAuth": []
    }
  ],
  "components": {
    "securitySchemes": {
      "BearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "API Key de Suno"
      }
    },
    "schemas": {
      "GenerateSongRequest": {
        "type": "object",
        "properties": {
          "prompt": {
            "type": "string",
            "description": "Descripción de la canción a generar",
            "example": "Una melodía de guitarra acústica suave con voces suave, estilo folk"
          },
          "customMode": {
            "type": "boolean",
            "default": false,
            "description": "Usar modo personalizado"
          },
          "instrumental": {
            "type": "boolean",
            "default": false,
            "description": "Generar solo instrumental"
          },
          "model": {
            "type": "string",
            "enum": ["V4_5ALL", "V4", "V3"],
            "default": "V4_5ALL",
            "description": "Modelo de IA a utilizar"
          },
          "callBackUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL de callback para notificaciones"
          }
        },
        "required": ["prompt"]
      },
      "GenerateLyricsRequest": {
        "type": "object",
        "properties": {
          "theme": {
            "type": "string",
            "description": "Tema de las letras",
            "example": "Amor y desamor"
          },
          "style": {
            "type": "string",
            "description": "Estilo musical",
            "example": "Rock, Pop, Reggae"
          },
          "mood": {
            "type": "string",
            "description": "Estado de ánimo",
            "example": "Triste, Alegre, Melancólico"
          }
        },
        "required": ["theme"]
      },
      "TaskResponse": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "ID único de la tarea",
            "example": "task_123456"
          },
          "status": {
            "type": "string",
            "enum": ["completed", "processing", "failed"],
            "description": "Estado actual de la tarea"
          },
          "audioUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL del audio generado"
          },
          "title": {
            "type": "string",
            "description": "Título de la canción"
          },
          "imageUrl": {
            "type": "string",
            "format": "uri",
            "description": "URL de la imagen de portada"
          },
          "lyric": {
            "type": "string",
            "description": "Letras de la canción"
          }
        }
      },
      "PersonaRequest": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Nombre de la persona/voz"
          },
          "description": {
            "type": "string",
            "description": "Descripción de características vocales"
          }
        },
        "required": ["name"]
      }
    }
  },
  "paths": {
    "/api/v1/suno/create": {
      "post": {
        "summary": "Generar una canción",
        "tags": ["Music Generation"],
        "operationId": "generateSong",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/GenerateSongRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Canción generada exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TaskResponse"
                }
              }
            }
          },
          "400": {
            "description": "Solicitud inválida"
          },
          "401": {
            "description": "No autorizado"
          }
        }
      }
    },
    "/api/v1/suno/lyrics": {
      "post": {
        "summary": "Generar letras",
        "tags": ["Lyrics"],
        "operationId": "generateLyrics",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/GenerateLyricsRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Letras generadas exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "properties": {
                    "lyrics": {
                      "type": "string"
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    "/api/v1/suno/task/{id}": {
      "get": {
        "summary": "Obtener estado de la tarea",
        "tags": ["Task Management"],
        "operationId": "getTaskStatus",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            },
            "description": "ID de la tarea"
          }
        ],
        "responses": {
          "200": {
            "description": "Estado de la tarea",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TaskResponse"
                }
              }
            }
          },
          "404": {
            "description": "Tarea no encontrada"
          }
        }
      }
    },
    "/api/v1/suno/upload-extend": {
      "post": {
        "summary": "Extender una canción existente",
        "tags": ["Audio Transform"],
        "operationId": "extendSong",
        "requestBody": {
          "required": true,
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "audioFile": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Canción extendida"
          }
        }
      }
    },
    "/api/v1/suno/persona": {
      "post": {
        "summary": "Crear una persona/voz de IA",
        "tags": ["Personas"],
        "operationId": "createPersona",
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/PersonaRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Persona creada"
          }
        }
      }
    }
  }
}# SunoAPI - Cliente Swift para Suno

[![Swift](https://img.shields.io/badge/Swift-5.6%2B-orange)]()
[![Platform](https://img.shields.io/badge/Platform-iOS%2013%2B%20%7C%20macOS%2010.15%2B-blue)]()
[![License](https://img.shields.io/badge/License-MIT-green)]()

Un cliente Swift generado automáticamente desde el esquema OpenAPI de Suno usando [CreateAPI](https://github.com/suno-ai/CreateAPI) y Swift Package Manager.

## 🎵 Características

- ✅ Generar canciones con IA
- ✅ Generar letras automáticamente
- ✅ Verificar estado de tareas
- ✅ Extender canciones existentes
- ✅ Crear personajes/voces de IA
- ✅ Procesamiento de audio (stem separation, audio-to-MIDI, etc.)
- ✅ Completamente tipado en Swift

## 📋 Requisitos

- Swift 5.6+ (Xcode 13.4+)
- macOS 10.15+ (el artifact bundle actualmente solo soporta macOS)

## 🚀 Instalación

### Via SPM (Swift Package Manager)

Agrega a tu `Package.swift`:
# SunoAPI - Cliente Swift para Suno

[![Swift](https://img.shields.io/badge/Swift-5.6%2B-orange)]()
[![Platform](https://img.shields.io/badge/Platform-iOS%2013%2B%20%7C%20macOS%2010.15%2B-blue)]()
[![License](https://img.shields.io/badge/License-MIT-green)]()

Un cliente Swift generado automáticamente desde el esquema OpenAPI de Suno usando [CreateAPI](https://github.com/suno-ai/CreateAPI) y Swift Package Manager.

## 🎵 Características

- ✅ Generar canciones con IA
- ✅ Generar letras automáticamente
- ✅ Verificar estado de tareas
- ✅ Extender canciones existentes
- ✅ Crear personajes/voces de IA
- ✅ Procesamiento de audio (stem separation, audio-to-MIDI, etc.)
- ✅ Completamente tipado en Swift

## 📋 Requisitos

- Swift 5.6+ (Xcode 13.4+)
- macOS 10.15+ (el artifact bundle actualmente solo soporta macOS)

## 🚀 Instalación

### Via SPM (Swift Package Manager)

Agrega a tu `Package.swift`:

```swift
.package(url: "https://github.com/loverpoolhulkbuster-afk/api-suno.git", branch: "main")# SunoAPI - Cliente Swift para Suno

[![Swift](https://img.shields.io/badge/Swift-5.6%2B-orange)]()
[![Platform](https://img.shields.io/badge/Platform-iOS%2013%2B%20%7C%20macOS%2010.15%2B-blue)]()
[![License](https://img.shields.io/badge/License-MIT-green)]()

Un cliente Swift generado automáticamente desde el esquema OpenAPI de Suno usando [CreateAPI](https://github.com/suno-ai/CreateAPI) y Swift Package Manager.

## 🎵 Características

- ✅ Generar canciones con IA
- ✅ Generar letras automáticamente
- ✅ Verificar estado de tareas
- ✅ Extender canciones existentes
- ✅ Crear personajes/voces de IA
- ✅ Procesamiento de audio (stem separation, audio-to-MIDI, etc.)
- ✅ Completamente tipado en Swift

## 📋 Requisitos

- Swift 5.6+ (Xcode 13.4+)
- macOS 10.15+ (el artifact bundle actualmente solo soporta macOS)

## 🚀 Instalación

### Via SPM (Swift Package Manager)

Agrega a tu `Package.swift`:

```swift
.package(url: "https://github.com/loverpoolhulkbuster-afk/api-suno.git", branch: "main")swift package --allow-writing-to-package-directory generate-apiimport SunoAPI

// Generar una canción
let request = GenerateSongRequest(
    prompt: "Una melodía de guitarra acústica suave, estilo folk",
    model: "V4_5ALL"
)

// Generar letras
let lyricsRequest = GenerateLyricsRequest(
    theme: "Amor",
    style: "Pop",
    mood: "Alegre"
)

// Obtener estado de la tarea
// let taskStatus = try await client.getTaskStatus(id: "task_id")api-suno/
├── Package.swift                 # Configuración del package
├── README.md                     # Este archivo
├── .gitignore
├── Plugins/
│   └── GenerateAPI/
│       └── Plugin.swift          # Plugin de generación
└── Sources/
    └── SunoAPI/
        ├── schema.json           # Esquema OpenAPI de Suno
        ├── .create-api.yml       # Configuración del generador
        └── Generated/            # Código generado (se crea automáticamente)
            ├── Paths.swift
            └── Entities.swiftapi-suno/
├── Package.swift                 # Configuración del package
├── README.md                     # Este archivo
├── .gitignore
├── Plugins/
│   └── GenerateAPI/
│       └── Plugin.swift          # Plugin de generación
└── Sources/
    └── SunoAPI/
        ├── schema.json           # Esquema OpenAPI de Suno
        ├── .create-api.yml       # Configuración del generador
        └── Generated/            # Código generado (se crea automáticamente)
            ├── Paths.swift
            └── Entities.swift
```swift
.package(url: "https://github.com/loverpoolhulkbuster-afk/api-suno.git", branch: "main")
}
