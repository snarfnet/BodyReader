import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            AppBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    HeroArtCard(
                        imageName: "read-gently",
                        eyebrow: "READ GENTLY",
                        title: "相手を決めつけない読み方",
                        subtitle: "BodyReaderは、ボディタッチやしぐさを観察するための学習アプリです。診断ではなく、会話をやさしく助けるヒントとして使います。"
                    )
                    .padding(.horizontal, 18)
                    .padding(.top, 14)

                    SectionHeader("アプリの中身", subtitle: "画像で学び、クイズで試し、場面で使う")
                        .padding(.horizontal, 18)

                    VStack(spacing: 12) {
                        FeatureRow(icon: "person.text.rectangle.fill", color: AppColors.coral, title: "サイン図鑑", subtitle: "顔、手、姿勢、距離感のサインを絵入りで確認できます。")
                        FeatureRow(icon: "sparkle.magnifyingglass", color: AppColors.teal, title: "読み取りクイズ", subtitle: "場面文から、どの感情に近いかを選んで練習できます。")
                        FeatureRow(icon: "rectangle.3.group.bubble.left.fill", color: AppColors.gold, title: "シーン別ガイド", subtitle: "恋愛、面接、初対面、交渉など、場面ごとの見方を整理します。")
                    }
                    .padding(.horizontal, 18)

                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 9) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(AppColors.gold)
                            Text("使うときの注意")
                                .font(AppFonts.headline(16))
                                .foregroundStyle(AppColors.textPrimary)
                        }
                        Text("しぐさは、文化、体調、性格、緊張、環境で大きく変わります。ひとつのサインだけで相手の感情を断定せず、複数の手がかりと会話の流れを合わせて見てください。")
                            .font(AppFonts.body(14))
                            .foregroundStyle(AppColors.textSecondary)
                            .lineSpacing(5)
                    }
                    .padding(18)
                    .background(AppColors.paper.opacity(0.94), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(AppColors.gold.opacity(0.24), lineWidth: 1))
                    .padding(.horizontal, 18)

                    VStack(spacing: 0) {
                        LinkRow(icon: "lock.shield.fill", color: AppColors.teal, title: "プライバシーポリシー", url: "https://tokyonasu.github.io/privacy/bodyreader")
                        AppDivider().padding(.horizontal, 16)
                        LinkRow(icon: "envelope.fill", color: AppColors.coral, title: "お問い合わせ", url: "mailto:support@tokyonasu.com")
                        AppDivider().padding(.horizontal, 16)
                        LinkRow(icon: "star.fill", color: AppColors.gold, title: "App Storeでレビュー", url: "https://apps.apple.com")
                    }
                    .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(.white.opacity(0.14), lineWidth: 1))
                    .padding(.horizontal, 18)

                    Text("© 2026 tokyonasu")
                        .font(AppFonts.caption(11))
                        .foregroundStyle(.white.opacity(0.42))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)

                    Spacer(minLength: 34)
                }
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            CategoryIconView(systemName: icon, color: color, size: 46)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(AppFonts.headline(15))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(AppFonts.body(13))
                    .foregroundStyle(.white.opacity(0.66))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding(15)
        .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.white.opacity(0.14), lineWidth: 1))
    }
}

struct LinkRow: View {
    let icon: String
    let color: Color
    let title: String
    let url: String

    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack(spacing: 14) {
                CategoryIconView(systemName: icon, color: color, size: 42)
                Text(title)
                    .font(AppFonts.headline(14))
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white.opacity(0.52))
            }
            .padding(15)
        }
    }
}
