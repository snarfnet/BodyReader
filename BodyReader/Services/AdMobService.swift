import SwiftUI

enum AdMobConfig {
    static let appID = ""
    static let bottomBannerID = ""
}

@MainActor
final class AdMobStartup: ObservableObject {
    static let shared = AdMobStartup()

    @Published private(set) var isReady = false

    func requestTrackingAndStart() {
        isReady = false
    }
}
