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
