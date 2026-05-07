import SwiftUI

struct AppBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [AppColors.ink, AppColors.inkSoft, Color(hex: "#231A22")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [AppColors.teal.opacity(0.26), .clear],
                center: .topLeading,
                startRadius: 10,
                endRadius: 420
            )

            RadialGradient(
                colors: [AppColors.coral.opacity(0.22), .clear],
                center: .bottomTrailing,
                startRadius: 30,
                endRadius: 520
            )

            SubtleContourPattern()
                .opacity(0.22)
        }
        .ignoresSafeArea()
    }
}

struct SubtleContourPattern: View {
    var body: some View {
        Canvas { context, size in
            for index in 0..<11 {
                let inset = CGFloat(index) * 26
                let rect = CGRect(
                    x: size.width * 0.08 + inset,
                    y: size.height * 0.05 + inset * 0.45,
                    width: size.width * 0.86 - inset * 1.3,
                    height: size.height * 0.34 - inset * 0.25
                )
                context.stroke(
                    Path(ellipseIn: rect),
                    with: .color(index.isMultiple(of: 2) ? AppColors.teal.opacity(0.35) : AppColors.gold.opacity(0.25)),
                    lineWidth: 1
                )
            }
        }
        .allowsHitTesting(false)
    }
}

struct GlassCardView<Content: View>: View {
    let cornerRadius: CGFloat
    let content: Content

    init(cornerRadius: CGFloat = 22, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).stroke(.white.opacity(0.18), lineWidth: 1))
            .shadow(color: .black.opacity(0.28), radius: 18, x: 0, y: 10)
    }
}

struct HeroArtCard: View {
    let imageName: String
    let eyebrow: String
    let title: String
    let subtitle: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 278)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            LinearGradient(
                colors: [.clear, .black.opacity(0.76)],
                startPoint: .center,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            VStack(alignment: .leading, spacing: 8) {
                Text(eyebrow)
                    .font(AppFonts.caption(12))
                    .foregroundStyle(AppColors.teal)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.32), in: Capsule())
                Text(title)
                    .font(AppFonts.title(31))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.78)
                Text(subtitle)
                    .font(AppFonts.body(14))
                    .foregroundStyle(.white.opacity(0.82))
                    .lineSpacing(3)
            }
            .padding(20)
        }
        .overlay(RoundedRectangle(cornerRadius: 28, style: .continuous).stroke(.white.opacity(0.16), lineWidth: 1))
        .shadow(color: .black.opacity(0.35), radius: 24, x: 0, y: 16)
    }
}

struct SectionHeader: View {
    let title: String
    let subtitle: String?

    init(_ title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(AppFonts.title(26))
                .foregroundStyle(.white)
            if let subtitle {
                Text(subtitle)
                    .font(AppFonts.body(14))
                    .foregroundStyle(.white.opacity(0.68))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct GradientText: View {
    let text: String
    let font: Font

    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(
                LinearGradient(
                    colors: [AppColors.teal, AppColors.gold, AppColors.coral],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

struct CategoryIconView: View {
    let systemName: String
    let color: Color
    let size: CGFloat

    init(systemName: String, color: Color = AppColors.coral, size: CGFloat = 44) {
        self.systemName = systemName
        self.color = color
        self.size = size
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.34, style: .continuous)
                .fill(color.opacity(0.18))
                .frame(width: size, height: size)
                .overlay(RoundedRectangle(cornerRadius: size * 0.34, style: .continuous).stroke(color.opacity(0.42), lineWidth: 1))
            Image(systemName: systemName)
                .font(.system(size: size * 0.42, weight: .bold))
                .foregroundStyle(color)
        }
    }
}

struct ReliabilityBadge: View {
    let level: String

    var color: Color {
        switch level {
        case "高": return AppColors.success
        case "中": return AppColors.gold
        case "低": return AppColors.error
        default: return AppColors.textSecondary
        }
    }

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: level == "高" ? "checkmark.seal.fill" : "circle.hexagongrid.fill")
                .font(.system(size: 10, weight: .bold))
            Text("信頼度 \(level)")
                .font(AppFonts.caption(11))
        }
        .foregroundStyle(color)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(color.opacity(0.14), in: Capsule())
        .overlay(Capsule().stroke(color.opacity(0.36), lineWidth: 1))
    }
}

struct PillTag: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(AppFonts.caption(11))
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(color.opacity(0.14), in: Capsule())
            .overlay(Capsule().stroke(color.opacity(0.34), lineWidth: 1))
    }
}

struct AppDivider: View {
    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.12))
            .frame(height: 1)
    }
}

struct CardPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.24, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

extension BodySignalCategory {
    var artName: String {
        switch id {
        case "cat_face": return "guide-signals"
        case "cat_hands": return "touch-map"
        case "cat_posture": return "emotion-spectrum"
        case "cat_distance": return "scene-conversation"
        default: return "guide-signals"
        }
    }
}
