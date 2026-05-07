import SwiftUI

struct SignalDetailView: View {
    let signal: BodySignal

    var body: some View {
        ZStack {
            AppBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.white.opacity(0.36))
                        .frame(width: 46, height: 5)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)

                    ZStack(alignment: .bottomLeading) {
                        Image(detailImageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                        LinearGradient(colors: [.clear, .black.opacity(0.76)], startPoint: .center, endPoint: .bottom)
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                        VStack(alignment: .leading, spacing: 7) {
                            ReliabilityBadge(level: signal.reliability)
                            Text(signal.nameJP)
                                .font(AppFonts.title(28))
                                .foregroundStyle(.white)
                            Text(signal.nameEN)
                                .font(AppFonts.headline(15))
                                .foregroundStyle(AppColors.gold)
                        }
                        .padding(18)
                    }
                    .padding(.horizontal, 18)

                    DetailSection(title: "まず見るポイント", icon: "eye.fill", accent: AppColors.gold) {
                        Text(signal.description)
                            .font(AppFonts.body(15))
                            .foregroundStyle(AppColors.textPrimary)
                            .lineSpacing(6)
                    }

                    DetailSection(title: "心の動き", icon: "heart.text.square.fill", accent: AppColors.coral) {
                        Text(signal.psychology)
                            .font(AppFonts.body(15))
                            .foregroundStyle(AppColors.textPrimary)
                            .lineSpacing(6)
                    }

                    DetailSection(title: "よく出る場面", icon: "list.bullet.rectangle.fill", accent: AppColors.teal) {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(signal.examples, id: \.self) { example in
                                HStack(alignment: .top, spacing: 10) {
                                    Circle()
                                        .fill(AppColors.teal)
                                        .frame(width: 7, height: 7)
                                        .padding(.top, 7)
                                    Text(example)
                                        .font(AppFonts.body(14))
                                        .foregroundStyle(AppColors.textPrimary)
                                        .lineSpacing(4)
                                }
                            }
                        }
                    }

                    DetailSection(title: "読み取りのコツ", icon: "checkmark.seal.fill", accent: AppColors.success) {
                        Text(reliabilityText)
                            .font(AppFonts.body(14))
                            .foregroundStyle(AppColors.textSecondary)
                            .lineSpacing(5)
                    }

                    Spacer(minLength: 42)
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }

    private var detailImageName: String {
        if signal.id.contains("face") { return "guide-signals" }
        if signal.id.contains("hand") { return "touch-map" }
        if signal.id.contains("posture") { return "emotion-spectrum" }
        if signal.id.contains("distance") { return "scene-conversation" }
        return "read-gently"
    }

    private var reliabilityText: String {
        switch signal.reliability {
        case "高":
            return "比較的読み取りやすいサインです。ただし、ひとつだけで判断せず、表情、声の調子、距離感と合わせて見てください。"
        case "中":
            return "状況によって意味が変わります。相手の普段の癖や、その場の緊張度も一緒に観察しましょう。"
        default:
            return "単独では誤解しやすいサインです。決めつけず、会話や他の手がかりでそっと確かめる姿勢が大切です。"
        }
    }
}

struct DetailSection<Content: View>: View {
    let title: String
    let icon: String
    let accent: Color
    let content: Content

    init(title: String, icon: String, accent: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.accent = accent
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(spacing: 9) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(accent)
                    .frame(width: 30, height: 30)
                    .background(accent.opacity(0.14), in: Circle())
                Text(title)
                    .font(AppFonts.headline(16))
                    .foregroundStyle(AppColors.textPrimary)
            }
            content
        }
        .padding(18)
        .background(AppColors.paper.opacity(0.94), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(accent.opacity(0.24), lineWidth: 1))
        .shadow(color: .black.opacity(0.16), radius: 14, x: 0, y: 8)
        .padding(.horizontal, 18)
    }
}
