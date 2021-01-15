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

let spmALayoutsTargetName = "RJSLibUFALayouts"
let spmALayoutsDependency = dependencyWith(name: spmALayoutsTargetName)

let spmThemesTargetName = "RJSLibUFAppThemes"
let spmThemesDependency = dependencyWith(name: spmThemesTargetName)

let spmNetworkingTargetName = "RJSLibUFNetworking"
let spmNetworkingDependency = dependencyWith(name: spmNetworkingTargetName)

let spmStorageTargetName = "RJSLibUFStorage"
let spmTStorageDependency = dependencyWith(name: spmStorageTargetName)

let testTargetDependencies = [spmALayoutsDependency, spmThemesDependency, spmNetworkingDependency, spmTStorageDependency]
let plistFile = "Info.plist"

let swiftSettings:[SwiftSetting] = [
    // Enable better optimizations when building in Release configuration. Despite the use of
    // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
    // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
    .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
]

let package = Package(
    name: swiftPackageManagerName,
    platforms: [.iOS(.v10), .macOS(.v10_15)],
    products: [
        libraryWith(name: spmBaseTargetName),
        libraryWith(name: spmALayoutsTargetName),
        libraryWith(name: spmThemesTargetName),
        libraryWith(name: spmNetworkingTargetName),
        libraryWith(name: spmStorageTargetName)
    ],
    targets: [
        .target(name: spmBaseTargetName, exclude: [plistFile]),
        .target(name: spmALayoutsTargetName, exclude: [plistFile]),
        .target(name: spmThemesTargetName, exclude: [plistFile]),
        .target(name: spmNetworkingTargetName, dependencies: [spmBaseDependency], exclude: [plistFile]),
        .target(name: spmStorageTargetName, dependencies: [spmBaseDependency], exclude: [plistFile], resources: [.process("RJPSLibDataModel.xcdatamodel")]),
        .testTarget(name: "RJSLibUFTests", dependencies: testTargetDependencies),
    ]
)
