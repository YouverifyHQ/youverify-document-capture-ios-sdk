// YouVerifySDKDependencies
//
// Intentionally (almost) empty. This target carries no SDK logic — its sole
// purpose is to pull the external frameworks that the closed-source
// `YouVerify_SDK.xcframework` links dynamically (@rpath) into the consuming
// app's link graph. See Package.swift for the rationale.
//
// Do not add product code here. Consumers integrate the SDK via
// `import YouVerify_SDK`, which resolves to the binary framework's module.

import Foundation

/// Marker namespace so the module is non-empty and the linker retains the
/// declared dependencies. Not part of the public SDK API.
enum YouVerifySDKDependencies {
    /// The SDK version this dependency set was wired for.
    static let wiredForSDKVersion = "0.2.18"
}
