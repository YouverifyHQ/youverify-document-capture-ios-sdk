<div align="center">

# Youverify Document Capture iOS SDK

**Identity onboarding & document capture for iOS, distributed via Swift Package Manager.**

[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Platform](https://img.shields.io/badge/platform-iOS%2015.5%2B-blue.svg)](#requirements)
[![Release](https://img.shields.io/github/v/release/YouverifyHQ/youverify-document-capture-ios-sdk?sort=semver)](https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk/releases)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)

</div>

---

## Overview

`YouVerify_SDK` lets you onboard users and confirm identities by reading the data
embedded in their identity documents. It scans a wide range of IDs — driver's
licences, national ID cards, passports, residence permits and more — across 90+
countries, with on-device document detection and capture.

The SDK is delivered as a pre-built, closed-source **binary XCFramework**. This
repository contains the Swift Package Manager manifest, documentation, releases
and issue tracking only — **no source code**.

- **UIKit and SwiftUI** integrations
- **On-device** document detection (Google ML Kit, embedded)
- **Swift Package Manager** distribution with checksum-verified binaries

## Requirements

| Requirement            | Value                                  |
| ---------------------- | -------------------------------------- |
| iOS deployment target  | **15.5+**                              |
| Xcode                  | 15.0+                                  |
| Swift tools            | 5.9+                                   |
| Distribution           | Swift Package Manager (binary XCFramework) |
| Device architecture    | `arm64` (physical devices)             |


## Installation

### Xcode — Add Package

1. In Xcode, open **File → Add Package Dependencies…**
2. Enter the package URL:

   ```
   https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk.git
   ```

3. Choose the **Dependency Rule** — *Up to Next Major Version* from the latest
   release is recommended.
4. Add the **`YouVerify_SDK`** library product to your app target.

### Package.swift

```swift
dependencies: [
    .package(
        url: "https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk.git",
        from: "0.2.18"
    )
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "YouVerify_SDK", package: "youverify-document-capture-ios-sdk")
        ]
    )
]
```

### Camera permission

The SDK uses the camera. Add `NSCameraUsageDescription` to your app's
`Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>YouVerify would like to use your camera for better ID capturing and recognition</string>
```

## UIKit Integration

Import the SDK in any view controller:

```swift
import YouVerify_SDK
```

Create a `YV` instance with your merchant ID and a result callback:

```swift
let yv = YV(merchant_id: "<MERCHANT_ID>", callBack: { [weak self] dict in
    guard let dict else {
        print("Capture cancelled or returned no data")
        return
    }
    self?.handleResult(dict)
})

yv.startYV(from: self)
```

### Customising appearance

Pass an `Appearance` object to customise buttons, text and the displayed user
name. All fields have sensible defaults, so you can set only what you need:

```swift
let appearance = Appearance(
    actionText: "Verify Identity",
    bTnTextColor: .white,
    userName: "User"
)

let yv = YV(
    merchant_id: "<MERCHANT_ID>",
    appearance2: appearance,
    callBack: { [weak self] dict in
        guard let dict else { return }
        self?.handleResult(dict)
    }
)

yv.startYV(from: self)
```

## SwiftUI Integration

Present `YVView` (e.g. in a `fullScreenCover`). It reports the capture result
through its completion handler:

```swift
import SwiftUI
import YouVerify_SDK

struct ContentView: View {
    @State private var isShowingYouVerify = false
    @State private var result: [String: Any] = [:]

    var body: some View {
        VStack(spacing: 16) {
            Button("Verify Identity") {
                isShowingYouVerify = true
            }

            Text(result.description)
        }
        .fullScreenCover(isPresented: $isShowingYouVerify) {
            YVView(
                merchantId: "<MERCHANT_ID>",
                appearance: Appearance(
                    actionText: "Verify Identity",
                    bTnTextColor: .white,
                    userName: "User"
                )
            ) { response in
                isShowingYouVerify = false
                if let response { result = response }
            }
            .ignoresSafeArea()
        }
    }
}
```

A runnable sample lives in [`Examples/DocumentCaptureSample`](Examples/DocumentCaptureSample).

## Supported Countries & Documents

<details>
<summary><strong>Show all supported countries (90+)</strong></summary>

| Country | Documents |
| --- | --- |
| Albania | Driver Card, ID Card, Professional DL, Passport |
| Algeria | Driving Licence, ID Card, Passport |
| Argentina | Alien ID, Driving Licence, ID Card, Passport |
| Armenia | ID Card |
| Australia | Passport, ID Card, Driving Licence, Proof Of Age Card |
| Azerbaijan | ID Card, Passport |
| Bangladesh | Driving Licence, ID Card, Passport |
| Belgium | Driving Licence, ID Card, Minors ID, Passport, Residence Permit, Resident ID |
| Bosnia And Herzegovina | Driving Licence, ID Card, Passport |
| Botswana | ID Card |
| Brazil | Driving Licence, Passport |
| Bulgaria | Driving Licence, ID Card, Passport |
| Canada | Passport, ID Card, Citizenship Certificate, Residence Permit, Tribal ID, Weapon Permit, Driving Licence, Public Services Card |
| Colombia | Alien ID, Driving Licence, ID Card, Minors ID, Passport |
| Croatia | Driving Licence, ID Card, Residence Permit, Passport |
| Cyprus | Driving Licence, ID Card, Residence Permit |
| Czechia | Driving Licence, ID Card, Residence Permit, Passport |
| Dominican Republic | Driving Licence, ID Card |
| Ecuador | Driving Licence, ID Card |
| Estonia | Driving Licence, ID Card, Residence Permit, Passport |
| Finland | Alien ID, Driving Licence, ID Card, Residence Permit, Passport |
| France | Driving Licence, ID Card, Residence Permit, Passport |
| Georgia | Driving Licence, ID Card, Passport |
| Germany | Driving Licence, ID Card, Residence Permit, Passport |
| Ghana | Driving Licence, ID Card, Passport |
| Greece | Driving Licence, ID Card, Residence Permit, Passport |
| Guatemala | Consular ID, Driving Licence, ID Card, Passport |
| Hong Kong | ID Card, Passport |
| Iran | Passport |
| Ireland | Driving Licence, Passport Card, Public Services Card, Passport |
| Israel | Driving Licence, ID Card, Passport |
| Italy | Driving Licence, ID Card, Residence Permit, Passport |
| Ivory Coast | Driving Licence, ID Card |
| Jamaica | Driving Licence |
| Japan | Driving Licence, Passport |
| Jordan | Driving Licence, ID Card, Passport |
| Kazakhstan | ID Card |
| Kenya | ID Card, Passport |
| Kuwait | Driving Licence, ID Card, Resident ID |
| Kyrgyzstan | ID Card |
| Latvia | Alien ID, Driving Licence, ID Card, Residence Permit, Passport |
| Libya | Passport |
| Lithuania | Driving Licence, ID Card, Passport |
| Luxembourg | Driving Licence, ID Card, Residence Permit |
| Malaysia | Driving Licence, MyKAS, MyKad, MyKid, MyPR, MyPolis, MyTentera, Refugee ID, Passport, i-Kad |
| Maldives | ID Card |
| Malta | Driving Licence, ID Card, Residence Permit |
| Mexico | Consular ID, Passport, Professional DL, Residence Permit, Voter ID, Driving Licence |
| Moldova | ID Card, Passport |
| Montenegro | Driving Licence, ID Card, Passport |
| Morocco | Driving Licence, ID Card, Passport |
| Nepal | Passport |
| Netherlands | Driving Licence, ID Card, Residence Permit, Passport |
| New Zealand | Driving Licence, Passport |
| Nicaragua | ID Card |
| Nigeria | Driving Licence, ID Card, Passport, Voter ID |
| North Macedonia | Driving Licence, ID Card, Passport |
| Norway | Driving Licence, Residence Permit, Passport |
| Pakistan | Consular ID, ID Card, Passport, Driving Licence |
| Philippines | Driving Licence, Multipurpose ID, Passport, Professional ID, Social Security Card, Tax ID, Voter ID |
| Poland | Driving Licence, ID Card, Residence Permit, Passport |
| Portugal | Driving Licence, ID Card, Residence Permit, Passport |
| Puerto Rico | Driving Licence, Voter ID |
| Romania | Driving Licence, ID Card, Passport |
| Russia | Driving Licence, Passport |
| Rwanda | ID Card |
| Senegal | ID Card |
| Serbia | Driving Licence, ID Card, Passport |
| Singapore | Driving Licence, Employment Pass, Fin Card, ID Card, Resident ID, Passport, S Pass, Work Permit |
| Slovakia | Driving Licence, ID Card, Residence Permit, Passport |
| Slovenia | Driving Licence, ID Card, Residence Permit, Passport |
| South Africa | Driving Licence, ID Card, Passport |
| South Korea | Driving Licence, ID Card, Passport |
| Syria | Passport |
| Thailand | Alien ID, Driving Licence, ID Card, Passport |
| Uganda | Driving Licence, ID Card |
| United Arab Emirates | Driving Licence, ID Card, Resident ID |
| United Kingdom | Driving Licence, Passport, Residence Permit |
| United States of America | Border Crossing Card, Global Entry Card, Green Card, Military ID, Nexus Card, Passport, Social Security Card, Veteran ID, Work Permit, Driving Licence, ID Card, Weapon Permit |
| Uruguay | ID Card |
| Zimbabwe | Passport |

</details>

## Troubleshooting

| Symptom | Cause & Fix |
| --- | --- |
| **Build fails in Simulator on Apple Silicon** (`building for 'iOS-simulator', but linking ... built for 'iOS'` / missing `arm64`) | The binary ships an `x86_64`-only simulator slice. Test on a **physical device**, or open Xcode/Simulator under **Rosetta**. A native `arm64` simulator slice is tracked — see [open issues](https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk/issues). |
| **`No such module 'YouVerify_SDK'`** | Confirm the `YouVerify_SDK` library product is added to your target. Then **File → Packages → Reset Package Caches** and rebuild. |
| **Linker errors referencing GoogleUtilities / GTMSessionFetcher / Promises / nanopb / Alamofire** | These are required transitive frameworks. Let SPM resolve the full graph (don't pin sub-dependencies manually). Run **File → Packages → Resolve Package Versions**. |
| **Checksum mismatch on resolve** | You may be on a stale cache. Reset package caches and re-resolve; if it persists, [open an issue](https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk/issues). |
| **Camera screen is black / immediately dismisses** | Ensure `NSCameraUsageDescription` is present and the user granted camera access. |

## Release Notes

See [CHANGELOG.md](CHANGELOG.md). Releases are automated with
[Release Please](https://github.com/googleapis/release-please) and published to
[GitHub Releases](https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk/releases).

## Support

- **Documentation:** https://doc.youverify.co/
- **Issues / bugs:** [GitHub Issues](https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk/issues)

## License

Released under the MIT License. See [LICENSE](LICENSE).
