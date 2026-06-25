// swift-tools-version: 5.9
//
//  Package.swift
//  YouVerify_SDK — Document Capture iOS SDK
//
//  Closed-source SDK distributed as a pre-built binary XCFramework.
//  This repository contains NO source code — only the SPM manifest,
//  documentation, governance, and release automation.
//
//  Architecture: Binary Target + Dependency-Carrier Target + External Dependencies
//  ------------------------------------------------------------------------------
//  A `binaryTarget` cannot declare dependencies of its own. The shipped
//  `YouVerify_SDK.xcframework` links a number of third-party frameworks
//  dynamically (via @rpath) but does NOT bundle them. We therefore expose a
//  small sibling target (`YouVerifySDKDependencies`) that carries those
//  external SPM packages, and include BOTH targets in the product so the
//  consuming app links the binary AND its required dependencies.
//
//  Consumers still write `import YouVerify_SDK` — that resolves to the module
//  baked into the XCFramework, regardless of the carrier target's name.
//
//  ⚠️  MAINTAINER NOTES — verify on every release (see MIGRATION.md):
//      1. Simulator slice is x86_64-only. The SDK will NOT run in the iOS
//         Simulator on Apple Silicon until an arm64 simulator slice is added.
//      2. The Google support stack below must ABI-match the MLKit version that
//         is statically embedded in the binary. CI (`swift package resolve`)
//         validates resolution; runtime linkage must be smoke-tested in Examples.
//      3. Long-term: ship a self-contained / statically-merged XCFramework so
//         this external-dependency block can be removed entirely.

import PackageDescription

// MARK: - Release coordinates (updated by Release Please on every release)

let sdkVersion = "0.2.19" // x-release-please-version
let binaryURL  = "https://cdn.youverify.co/ios-sdks/YouVerify_SDK-0.2.19.xcframework.zip" // x-release-please-version
// NOTE: `binaryChecksum` is NOT auto-bumped — update it during release prep with
// `swift package compute-checksum <zip>` (the release workflow validates it on PRs).
let binaryChecksum = "220a3c991065339b8a222a4f5f8965a199d974e501d8101a929b370c38739fbd"

let package = Package(
    name: "YouVerify_SDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "YouVerify_SDK",
            targets: ["YouVerify_SDK", "YouVerifySDKDependencies"]
        )
    ],
    dependencies: [
        // SDK's own dependencies — first-party SPM support, high confidence.
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.2"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.1"),
        .package(url: "https://github.com/SurfStudioInc/SKCountryPicker.git", from: "2.0.0"),
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", from: "2.4.3"),

        // Google ML Kit support stack — required at link time because MLKit is
        // statically embedded in the binary. Version floors below are a starting
        // point and MUST be confirmed against the SDK build manifest; CI will
        // fail fast on any unresolved product/version.
        .package(url: "https://github.com/google/GoogleUtilities.git", from: "7.12.0"),
        .package(url: "https://github.com/google/GoogleDataTransport.git", from: "9.4.0"),
        .package(url: "https://github.com/google/gtm-session-fetcher.git", from: "3.1.1"),
        .package(url: "https://github.com/google/promises.git", from: "2.4.0"),
        .package(url: "https://github.com/firebase/nanopb.git", "2.30909.0" ..< "2.30911.0"),
        .package(url: "https://github.com/google/GoogleToolboxForMac.git", from: "4.2.1")
    ],
    targets: [
        // The pre-built, closed-source SDK binary.
        .binaryTarget(
            name: "YouVerify_SDK",
            url: binaryURL,
            checksum: binaryChecksum
        ),

        // Dependency carrier. Holds no SDK logic — it exists only to pull the
        // external frameworks the binary expects at link/runtime into the
        // consuming app's link graph.
        .target(
            name: "YouVerifySDKDependencies",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
                .product(name: "SKCountryPicker", package: "SKCountryPicker"),
                .product(name: "ZipArchive", package: "ZipArchive"),

                // Google support stack (product names verified via `swift package resolve` in CI).
                .product(name: "GoogleUtilities-Environment", package: "GoogleUtilities"),
                .product(name: "GoogleUtilities-Logger", package: "GoogleUtilities"),
                .product(name: "GoogleUtilities-Network", package: "GoogleUtilities"),
                .product(name: "GoogleUtilities-NSData", package: "GoogleUtilities"),
                .product(name: "GoogleUtilities-Reachability", package: "GoogleUtilities"),
                .product(name: "GoogleUtilities-UserDefaults", package: "GoogleUtilities"),
                .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
                .product(name: "GTMSessionFetcherCore", package: "gtm-session-fetcher"),
                .product(name: "FBLPromises", package: "promises"),
                .product(name: "nanopb", package: "nanopb"),
                .product(name: "GoogleToolboxForMac", package: "GoogleToolboxForMac")
            ],
            path: "Sources/YouVerifySDKDependencies"
        )
    ]
)
