# DocumentCaptureSample

A minimal SwiftUI app demonstrating `import YouVerify_SDK` and a document-capture
flow via `YVView`.

To keep maintenance low, this sample is shipped as **source files only** — no
committed `.xcodeproj`. Create the project in a few clicks:

## Setup

1. In Xcode: **File → New → Project… → iOS → App**.
   - Product name: `DocumentCaptureSample`
   - Interface: **SwiftUI**, Language: **Swift**
   - Save it inside this folder (so it picks up the provided sources, or add
     `DocumentCaptureSampleApp.swift` and `ContentView.swift` to the target).
2. Add the package: **File → Add Package Dependencies…** →
   `https://github.com/YouverifyHQ/youverify-document-capture-ios-sdk.git`
   → add the **`YouVerify_SDK`** product to the app target.
3. In **Info** add `NSCameraUsageDescription`:
   > YouVerify would like to use your camera for better ID capturing and recognition
4. Replace `<MERCHANT_ID>` in `ContentView.swift` with your merchant ID.
5. Run on a **physical device** (the current binary has no `arm64` simulator
   slice — see the repo README Troubleshooting).

## Files

| File | Purpose |
| --- | --- |
| `DocumentCaptureSample/DocumentCaptureSampleApp.swift` | App entry point |
| `DocumentCaptureSample/ContentView.swift` | Minimal capture flow with `YVView` |
