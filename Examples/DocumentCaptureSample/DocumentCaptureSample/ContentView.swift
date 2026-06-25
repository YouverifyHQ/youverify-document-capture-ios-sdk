import SwiftUI
import YouVerify_SDK

/// Minimal document-capture flow using the SwiftUI entry point (`YVView`).
///
/// Replace `<MERCHANT_ID>` with your merchant ID. Remember to add
/// `NSCameraUsageDescription` to the app's Info.plist.
struct ContentView: View {
    @State private var isShowingYouVerify = false
    @State private var result: [String: Any] = [:]

    private let merchantID = "<MERCHANT_ID>"

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "person.text.rectangle")
                    .font(.system(size: 56))
                    .foregroundStyle(.tint)

                Text("YouVerify Document Capture")
                    .font(.title2.weight(.semibold))

                Button("Verify Identity") {
                    isShowingYouVerify = true
                }
                .buttonStyle(.borderedProminent)

                if !result.isEmpty {
                    GroupBox("Last result") {
                        ScrollView {
                            Text(result.description)
                                .font(.footnote.monospaced())
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxHeight: 200)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
            .navigationTitle("Sample")
        }
        .fullScreenCover(isPresented: $isShowingYouVerify) {
            YVView(
                merchantId: merchantID,
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

#Preview {
    ContentView()
}
