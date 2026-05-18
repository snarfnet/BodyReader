import GoogleMobileAds
import SwiftUI
import UIKit

struct BannerAdView: UIViewRepresentable {
    let adUnitID: String
    let adSize: AdSize

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .clear

        let banner = BannerView(adSize: adSize)
        banner.adUnitID = adUnitID
        banner.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(banner)

        NSLayoutConstraint.activate([
            banner.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            banner.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        context.coordinator.bannerView = banner
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let banner = context.coordinator.bannerView else { return }
        guard !context.coordinator.didLoad else { return }
        guard let rootViewController = UIApplication.shared.adRootViewController else { return }

        banner.rootViewController = rootViewController
        banner.load(Request())
        context.coordinator.didLoad = true
    }

    final class Coordinator {
        var bannerView: BannerView?
        var didLoad = false
    }
}

struct BottomAdBannerView: View {
    @ObservedObject private var adMobStartup = AdMobStartup.shared

    var body: some View {
        GeometryReader { geometry in
            if adMobStartup.canShowAds, adMobStartup.isReady, geometry.size.width > 0 {
                BannerAdView(
                    adUnitID: AdMobConfig.bottomBannerID,
                    adSize: currentOrientationAnchoredAdaptiveBanner(width: geometry.size.width)
                )
            }
        }
        .frame(height: adMobStartup.canShowAds && adMobStartup.isReady ? 54 : 0)
        .frame(maxWidth: .infinity)
        .background(AppColors.ink.opacity(adMobStartup.canShowAds && adMobStartup.isReady ? 0.96 : 0))
        .task {
            adMobStartup.requestTrackingAndStart()
        }
    }
}

private extension UIApplication {
    var adRootViewController: UIViewController? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
