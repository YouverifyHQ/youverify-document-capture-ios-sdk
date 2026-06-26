# Repository Standards

This repository follows the Youverify iOS SDK distribution standard.

## Required files

- `Package.swift`
- `README.md`
- `CHANGELOG.md`
- `LICENSE`
- `SECURITY.md`
- `CONTRIBUTING.md`
- `RELEASE.md`
- `.editorconfig`
- `.gitattributes`
- `.gitignore`
- `.markdownlint-cli2.jsonc`
- `.spi.yml`
- `.github/CODEOWNERS`
- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/ISSUE_TEMPLATE/*`
- `.github/dependabot.yml`
- `.github/release.yml`
- `.github/workflows/pr-validation.yml`
- `.github/workflows/release.yml`
- `scripts/validate-binary-target.sh`

## Repository identity

- Organization: `YouverifyHQ`
- Repository: `youverify-document-capture-ios-sdk`
- Default branch: `master`
- Tag format: `vX.Y.Z`
- Minimum iOS version: iOS 15
- Swift tools version: 5.9

## Required checks

Branch protection should require:

- `Validate Swift package`
- `Validate binary target`
- `Version and checksum guard`
- `Docs lint and links`
- `Conventional PR title`

## Release principle

Only a `Package.swift` version bump can create a new release. Documentation,
governance, examples, and CI-only changes must merge without creating tags.
