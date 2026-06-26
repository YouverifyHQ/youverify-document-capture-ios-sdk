# Release Process

This repository uses a version-bump-driven release process. The single release
intent is the `let version` value in [Package.swift](Package.swift).

## Release checklist

1. Create a branch named `release/x.y.z`.
2. Build the SDK binary in the private source repository.
3. Package the artifact as an `.xcframework.zip`.
4. Upload the artifact to the Youverify CDN using this repository's artifact
   pattern:

   ```text
   YouVerify_SDK-{version}.xcframework.zip
   ```

5. Update `let version` in [Package.swift](Package.swift).
6. Compute the checksum:

   ```bash
   swift package compute-checksum YouVerify_SDK-0.2.18.xcframework.zip
   ```

7. Update `let checksum` in [Package.swift](Package.swift).
8. Run local validation:

   ```bash
   swift package dump-package
   swift package resolve
   bash scripts/validate-binary-target.sh
   ```

9. Open a pull request into `master`.
10. Merge after PR Validation is green and code owners approve.

## What automation does

After merge to `master`, `.github/workflows/release.yml`:

- derives the semantic version from the evaluated package manifest;
- skips safely if tag `vX.Y.Z` already exists;
- validates the hosted binary URL, checksum, and XCFramework structure;
- creates and pushes tag `vX.Y.Z`;
- creates a GitHub Release with generated notes;
- syncs `CHANGELOG.md` from the generated release notes when branch protection
  allows the bot push.

## Documentation-only changes

Documentation-only PRs do not update `let version`, so the release workflow sees
that the current tag already exists and exits without creating a release.

## Required repository settings

- Default branch: `master`.
- Branch protection: require PR Validation, require code-owner review, require
  branches to be up to date before merge.
- Actions permissions: allow GitHub Actions to create tags and releases using
  `GITHUB_TOKEN`.
- Secrets: no custom secrets are required for the default release flow.
