import AppTrackingTransparency
import GoogleMobileAds
import SwiftUI
import UIKit

enum AdMobConfig {
    static let appID = "ca-app-pub-9404799280370656~4792796326"
    static let bottomBannerID = "ca-app-pub-9404799280370656/2090925992"
}

@MainActor
final class AdMobStartup: ObservableObject {
    static let shared = AdMobStartup()

    @Published private(set) var isReady = false
    private var didRequestTracking = false
    private var isStarting = false

    private init() {}

    var canShowAds: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    func requestTrackingAndStart() {
        guard canShowAds else { return }
        guard !isReady, !isStarting, !didRequestTracking else { return }
        didRequestTracking = true
        isStarting = true

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            requestAuthorizationThenStart()
        }
    }

    private func requestAuthorizationThenStart() {
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
