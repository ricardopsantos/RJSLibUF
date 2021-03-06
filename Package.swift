// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swiftlint:disable all

import PackageDescription

let swiftPackageManagerName = "rjps-lib-uf"

func dependencyWith(name: String) -> Target.Dependency {
    Target.Dependency(stringLiteral: name)
}

func libraryWith(name: String) -> PackageDescription.Product {
    func targetWith(name: String, resources: [String]=[]) -> Target {
        return Target.target(name: name, path: "./\(name)")
    }
    let target = targetWith(name: name)
    return .library(name: name, targets: [target.name])
}

let spmBaseTargetName = "RJSLibUFBase"
let spmBaseDependency = dependencyWith(name: spmBaseTargetName)

let spmBaseVIPTargetName = "RJSLibUFBaseVIP"
let spmBaseVIPDependency = dependencyWith(name: spmBaseTargetName)

let spmThemesTargetName = "RJSLibUFAppThemes"
let spmThemesDependency = dependencyWith(name: spmThemesTargetName)

let spmNetworkingTargetName = "RJSLibUFNetworking"
let spmNetworkingDependency = dependencyWith(name: spmNetworkingTargetName)

let spmStorageTargetName = "RJSLibUFStorage"
let spmStorageDependency = dependencyWith(name: spmStorageTargetName)

let spmDesignablesTargetName = "RJSLibUFDesignables"
let spmDesignablesDependency = dependencyWith(name: spmDesignablesTargetName)

let testTargetDependencies = [spmThemesDependency, spmNetworkingDependency, spmStorageDependency, spmBaseVIPDependency, spmDesignablesDependency]
let plistFile = "Info.plist"

let swiftSettings:[SwiftSetting] = [
    // Enable better optimizations when building in Release configuration. Despite the use of
    // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
    // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
    .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
]

let package = Package(
    name: swiftPackageManagerName,
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        libraryWith(name: spmBaseTargetName),
        libraryWith(name: spmBaseVIPTargetName),
        libraryWith(name: spmNetworkingTargetName),
        libraryWith(name: spmThemesTargetName),
        libraryWith(name: spmStorageTargetName),
        libraryWith(name: spmDesignablesTargetName)
    ],
    targets: [
        .target(name: spmBaseTargetName, exclude: [plistFile]),
        .target(name: spmThemesTargetName, dependencies: [spmBaseDependency], exclude: [plistFile]),
        .target(name: spmNetworkingTargetName, dependencies: [spmBaseDependency], exclude: [plistFile]),
        .target(name: spmBaseVIPTargetName, dependencies: [spmBaseDependency, spmDesignablesDependency], exclude: [plistFile]),
        .target(name: spmDesignablesTargetName, dependencies: [spmBaseDependency, spmThemesDependency], exclude: [plistFile]),
        .target(name: spmStorageTargetName, dependencies: [spmBaseDependency], exclude: [plistFile], resources: [.process("RJPSLibDataModel.xcdatamodel")]),
        .testTarget(name: "RJSLibUFTests", dependencies: testTargetDependencies),
    ]
)
