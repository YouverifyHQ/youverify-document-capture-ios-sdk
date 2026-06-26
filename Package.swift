// swift-tools-version: 5.9
//
//  Package.swift
//  YouVerify_SDK - Document Capture iOS SDK
//
//  Closed-source SDK distributed as a pre-built binary XCFramework.
//  This repository contains no SDK source code: only the SPM manifest,
//  documentation, governance, examples, and release automation.
//
//  Architecture: Binary Target + Dependency-Carrier Target + External Dependencies
//  ------------------------------------------------------------------------------
//  A binaryTarget cannot declare dependencies of its own. The shipped
//  YouVerify_SDK.xcframework links a number of third-party frameworks
//  dynamically but does not bundle them. The sibling target
//  YouVerifySDKDependencies carries those external SPM packages and is included
//  in the library product so consuming apps link the binary and its dependencies.
//
//  Maintainer notes - verify on every release:
//  1. Confirm simulator slices with the source-build team before publishing.
//  2. The Google support stack below must ABI-match the MLKit version embedded
//     in the binary. Runtime linkage must be smoke-tested in Examples.
//  3. Long-term: ship a self-contained XCFramework so this dependency-carrier
//     target can be removed.

import PackageDescription

let version = "0.2.18"
let binaryURL = "https://cdn.youverify.co/ios-sdks/YouVerify_SDK-\(version).xcframework.zip"
let checksum = "220a3c991065339b8a222a4f5f8965a199d974e501d8101a929b370c38739fbd"

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
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.2"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.1"),
        .package(url: "https://github.com/SURYAKANTSHARMA/CountryPicker.git", from: "2.0.0"),
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", from: "2.4.3"),
        .package(url: "https://github.com/google/GoogleUtilities.git", exact: "7.12.0"),
        .package(url: "https://github.com/google/GoogleDataTransport.git", from: "9.4.0"),
        .package(url: "https://github.com/google/gtm-session-fetcher.git", from: "3.1.1"),
        .package(url: "https://github.com/google/promises.git", from: "2.4.0"),
        .package(url: "https://github.com/firebase/nanopb.git", "2.30909.0" ..< "2.30911.0"),
        .package(url: "https://github.com/google/google-toolbox-for-mac.git", from: "6.0.0")
    ],
    targets: [
        .binaryTarget(
            name: "YouVerify_SDK",
            url: binaryURL,
            checksum: checksum
        ),
        .target(
            name: "YouVerifySDKDependencies",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
                .product(name: "CountryPicker", package: "CountryPicker"),
                .product(name: "ZipArchive", package: "ZipArchive"),
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
                .product(name: "GoogleToolboxForMac", package: "google-toolbox-for-mac")
            ],
            path: "Sources/YouVerifySDKDependencies"
        )
    ]
)
