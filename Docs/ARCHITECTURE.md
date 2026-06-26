# Architecture

## Package role

Document capture SDK distributed as a binary XCFramework with a dependency-carrier target. The public API is inside the prebuilt binary framework.
This repository is responsible for package metadata, distribution integrity,
documentation, examples, and release automation.

## Public stability

Do not rename the package product `YouVerify_SDK`, binary target
`YouVerify_SDK`, or module imported by consumers unless a breaking release is
explicitly approved.

## Binary target

The binary target points at a hosted `.xcframework.zip` on the Youverify CDN.
Swift Package Manager verifies the downloaded artifact against the checksum
declared in [Package.swift](../Package.swift).

## Dependency carrier target

The `YouVerifySDKDependencies` target contains no product code. It exists only
to bring the external frameworks required by the binary into the consumer's
link graph. Keep that target small and treat dependency changes as release
engineering changes.

## Release source of truth

The version in [Package.swift](../Package.swift) is the single release source of
truth. The CDN URL is derived from that version, and the checksum must be
updated in the same PR as a binary version bump.
