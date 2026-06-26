# Contributing

Thanks for helping improve the Youverify Document Capture iOS SDK. This repository is a public
distribution package for a closed-source binary SDK. It contains the Swift
Package manifest, documentation, examples, governance files, and release
automation. SDK source code is maintained separately.

## Development workflow

1. Create a branch from `master`.
2. Keep public package names, product names, module names, and minimum iOS
   versions stable unless a breaking release is explicitly approved.
3. Update documentation when integration behavior changes.
4. Open a pull request with a Conventional Commit title, such as
   `docs: clarify SwiftPM installation` or `release: publish 0.2.18`.
5. Wait for PR Validation to pass before merge.

## Local validation

Run these checks before opening a PR:

```bash
swift package dump-package
swift package resolve
bash scripts/validate-binary-target.sh
```

The binary validation script requires `swift`, `jq`, `curl`, and `unzip`.

## Releasing a new SDK binary

Releases are version-bump driven:

1. Create a branch named `release/x.y.z`.
2. Upload the new `.xcframework.zip` to the Youverify CDN.
3. Update `let version` in [Package.swift](Package.swift).
4. Compute the artifact checksum:

   ```bash
   swift package compute-checksum <artifact>.xcframework.zip
   ```

5. Update `let checksum` in [Package.swift](Package.swift).
6. Open a PR and merge it after CI passes.
7. The Release workflow creates tag `vX.Y.Z`, publishes a GitHub Release, and
   syncs changelog notes.

Documentation-only changes do not create releases because the manifest version
does not change and the release tag already exists.

## Dependency policy

These SDKs are binary-first packages. Do not add runtime dependencies unless the
binary actually requires them. For dependency-carrier targets, keep package
versions aligned with the binary build manifest and validate with an example app.

## SwiftLint policy

SwiftLint is intentionally not enabled in this distribution repository. The
first-party Swift surface here is limited to package metadata, dependency
carrier shims, and source-only examples. If first-party source grows
substantially, add SwiftLint in the same PR that introduces lintable source.

## Security

Do not include API keys, merchant secrets, access tokens, identity documents, or
personal data in issues, pull requests, examples, logs, or screenshots. Report
vulnerabilities according to [SECURITY.md](SECURITY.md).

## Repository URL

The canonical repository URL is:

```text
https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk
```
