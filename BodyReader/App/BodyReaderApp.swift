import SwiftUI

@main
struct BodyReaderApp: App {
    @StateObject private var adMobStartup = AdMobStartup.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(adMobStartup)
                .preferredColorScheme(.dark)
        }
    }
}
