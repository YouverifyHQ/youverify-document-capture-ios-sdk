# Security Policy

## Supported versions

Security fixes are provided for the latest released version of the SDK. We
recommend integrating the most recent release.

| Version | Supported |
| --- | --- |
| 0.2.x | Yes |

## Reporting a vulnerability

Do not open a public GitHub issue for security vulnerabilities.

Report vulnerabilities privately through GitHub Security Advisories for this
repository, or email developer@youverify.co. Include:

- A description of the vulnerability and its potential impact.
- Steps to reproduce or a proof of concept.
- Affected SDK version, Xcode version, iOS version, and device model.

The Youverify team will acknowledge the report and provide a remediation plan or
timeline after triage.

## Distribution integrity

This package is distributed as a precompiled `.xcframework` hosted on the
Youverify CDN. Swift Package Manager verifies the artifact against the checksum
declared in [Package.swift](Package.swift) during package resolution.

CI re-downloads the hosted artifact and verifies the checksum on every pull
request and before every release tag is created.
