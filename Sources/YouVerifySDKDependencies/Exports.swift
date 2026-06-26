// YouVerifySDKDependencies
//
// Intentionally small. This target carries no SDK logic; its sole purpose is to
// pull the external frameworks that the closed-source YouVerify_SDK.xcframework
// links dynamically into the consuming app's link graph.

import Foundation

/// Marker namespace so the module is non-empty and the linker retains the
/// declared dependencies. Not part of the public SDK API.
enum YouVerifySDKDependencies {}
