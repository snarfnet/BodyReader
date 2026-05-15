import SwiftUI

@main
struct BodyReaderApp: App {
    @StateObject private var adMobStartup = AdMobStartup.shared
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(adMobStartup)
                .preferredColorScheme(.dark)
                .onChange(of: scenePhase) {
                    guard scenePhase == .active else { return }
                    Task { @MainActor in
                        try? await Task.sleep(nanoseconds: 800_000_000)
                        adMobStartup.requestTrackingAndStart()
                    }
                }
        }
    }
}
