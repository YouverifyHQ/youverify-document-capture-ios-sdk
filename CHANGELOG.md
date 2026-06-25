# Changelog

All notable changes to the **YouVerify Document Capture iOS SDK** are documented
in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and entries are generated automatically by
[Release Please](https://github.com/googleapis/release-please) from
[Conventional Commits](https://www.conventionalcommits.org/).

<!-- release-please-do-not-touch -->

## [0.2.18] - 2024-01-01

### Added

- Initial Swift Package Manager distribution of the YouVerify Document Capture
  iOS SDK (binary XCFramework, iOS 15.5+).
- UIKit (`YV`) and SwiftUI (`YVView`) integration entry points.
- On-device document detection across 90+ countries.

### Changed

- **Migrated distribution from CocoaPods to Swift Package Manager.** The
  `YouVerify_SDK` pod is superseded by this package.

[0.2.18]: https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk/releases/tag/v0.2.18
