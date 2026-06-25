<!--
Thanks for contributing! This is a distribution repo (no SDK source code).
PR titles SHOULD follow Conventional Commits, e.g. "docs: ...", "deps: ...".
-->

## Summary

<!-- What does this PR change and why? -->

## Type of change

- [ ] 📝 Documentation
- [ ] 📦 Package.swift / dependency wiring
- [ ] ⬆️ New SDK binary (URL + checksum bump)
- [ ] 🤖 CI/CD or governance
- [ ] 🐞 Bug report triage / issue follow-up

## Checklist

- [ ] PR title follows [Conventional Commits](https://www.conventionalcommits.org/)
- [ ] `swift package dump-package` and `swift package resolve` pass locally
- [ ] No CocoaPods references introduced (this SDK is SPM-only)
- [ ] Docs/README updated if behaviour or integration changed
- [ ] If bumping the binary: updated **both** `binaryURL` and `binaryChecksum`
      in `Package.swift` (`swift package compute-checksum <zip>`)

## Related issues

<!-- e.g. Closes #123 -->
