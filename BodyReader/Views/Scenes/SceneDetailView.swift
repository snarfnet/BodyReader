import SwiftUI

struct SceneDetailView: View {
    let scene: SceneGuide
    @State private var expandedPointId: String?

    var body: some View {
        ZStack {
            AppBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.white.opacity(0.36))
                        .frame(width: 46, height: 5)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)

                    HeroArtCard(
                        imageName: imageName,
                        eyebrow: "SCENE",
                        title: scene.title,
                        subtitle: scene.subtitle
                    )
                    .padding(.horizontal, 18)

                    VStack(spacing: 12) {
                        ForEach(Array(scene.points.enumerated()), id: \.element.id) { index, point in
                            ScenePointRow(
                                point: point,
                                index: index + 1,
                                isExpanded: expandedPointId == point.id
                            ) {
                                withAnimation(.spring(response: 0.34, dampingFraction: 0.78)) {
                                    expandedPointId = expandedPointId == point.id ? nil : point.id
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 18)

                    Spacer(minLength: 42)
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }

    private var imageName: String {
        switch scene.id {
        case "date": return "scene-conversation"
        case "business": return "read-gently"
        case "first": return "touch-map"
        case "negotiation": return "emotion-spectrum"
        default: return "quiz-clues"
        }
    }
}

struct ScenePointRow: View {
    let point: ScenePoint
    let index: Int
    let isExpanded: Bool
    let onTap: () -> Void

    private var accent: Color {
        [AppColors.coral, AppColors.teal, AppColors.gold, AppColors.lavender, AppColors.success][(index - 1) % 5]
    }

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    Text("\(index)")
                        .font(AppFonts.headline(15))
                        .foregroundStyle(isExpanded ? AppColors.ink : accent)
                        .frame(width: 34, height: 34)
                        .background(isExpanded ? accent : accent.opacity(0.16), in: Circle())
                    Text(point.title)
                        .font(AppFonts.headline(15))
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(accent)
                }

                if isExpanded {
                    Text(point.description)
                        .font(AppFonts.body(14))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineSpacing(5)
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(AppColors.gold)
                        Text(point.tip)
                            .font(AppFonts.body(13))
                            .foregroundStyle(AppColors.textSecondary)
                            .lineSpacing(4)
                    }
                    .padding(12)
                    .background(AppColors.pastelYellow.opacity(0.62), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
            .padding(16)
            .background(AppColors.paper.opacity(0.94), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(accent.opacity(0.22), lineWidth: 1))
            .shadow(color: .black.opacity(0.16), radius: 12, x: 0, y: 7)
        }
        .buttonStyle(CardPressStyle())
    }
}
