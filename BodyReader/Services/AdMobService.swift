import AppTrackingTransparency
import GoogleMobileAds
import SwiftUI

enum AdMobConfig {
    static let appID = "ca-app-pub-9404799280370656~4792796326"
    static let bottomBannerID = "ca-app-pub-9404799280370656/2090925992"
}

@MainActor
final class AdMobStartup: ObservableObject {
    static let shared = AdMobStartup()

    @Published private(set) var isReady = false
    private var isStarting = false

    func requestTrackingAndStart() {
        guard !isReady, !isStarting else { return }
        isStarting = true

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] _ in
                Task { @MainActor in
                    self?.startMobileAds()
                }
            }
        } else {
            startMobileAds()
        }
    }

    private func startMobileAds() {
        MobileAds.shared.start { [weak self] _ in
            Task { @MainActor in
                self?.isReady = true
                self?.isStarting = false
            }
        }
    }
}
