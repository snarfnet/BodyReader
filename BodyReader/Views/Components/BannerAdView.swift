import SwiftUI

struct BottomAdBannerView: View {
    @ObservedObject private var adMobStartup = AdMobStartup.shared

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(AppColors.gold)
            Text("BodyReader")
                .font(AppFonts.caption(12))
                .foregroundStyle(.white.opacity(0.54))
        }
        .frame(height: 54)
        .frame(maxWidth: .infinity)
        .background(AppColors.ink.opacity(0.96))
        .accessibilityHidden(true)
    }
}
