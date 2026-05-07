import SwiftUI

struct ScenesView: View {
    @State private var scenes: [SceneGuide] = []
    @State private var selectedScene: SceneGuide?

    var body: some View {
        ZStack {
            AppBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    HeroArtCard(
                        imageName: "scene-conversation",
                        eyebrow: "SCENE PRACTICE",
                        title: "場面ごとに、見る順番を変える",
                        subtitle: "恋愛、面接、雑談、交渉。相手を決めつけず、状況に合う見方を選びます。"
                    )
                    .padding(.horizontal, 18)
                    .padding(.top, 14)

                    SectionHeader("シーン別ガイド", subtitle: "その場で使いやすい観察ポイント")
                        .padding(.horizontal, 18)

                    VStack(spacing: 14) {
                        ForEach(Array(scenes.enumerated()), id: \.element.id) { index, scene in
                            Button { selectedScene = scene } label: {
                                SceneCardView(scene: scene, index: index)
                            }
                            .buttonStyle(CardPressStyle())
                        }
                    }
                    .padding(.horizontal, 18)

                    Spacer(minLength: 34)
                }
            }
        }
        .sheet(item: $selectedScene) { scene in
            SceneDetailView(scene: scene)
        }
        .onAppear { loadData() }
    }

    private func loadData() {
        guard let url = Bundle.main.url(forResource: "scenes_data", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        scenes = (try? JSONDecoder().decode([SceneGuide].self, from: data)) ?? []
    }
}

struct SceneCardView: View {
    let scene: SceneGuide
    let index: Int

    private var accent: Color {
        [AppColors.coral, AppColors.teal, AppColors.gold, AppColors.lavender, AppColors.success][index % 5]
    }

    private var imageName: String {
        ["scene-conversation", "read-gently", "touch-map", "emotion-spectrum", "quiz-clues"][index % 5]
    }

    var body: some View {
        HStack(spacing: 14) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(.white.opacity(0.22), lineWidth: 1))

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 7) {
                    CategoryIconView(systemName: scene.icon, color: accent, size: 34)
                    Text(scene.title)
                        .font(AppFonts.headline(16))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                }
                Text(scene.subtitle)
                    .font(AppFonts.body(13))
                    .foregroundStyle(.white.opacity(0.68))
                    .lineLimit(2)
                PillTag(text: "\(scene.points.count)ステップ", color: accent)
            }

            Spacer()

            Image(systemName: "chevron.right.circle.fill")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(accent)
        }
        .padding(12)
        .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.14), lineWidth: 1))
        .shadow(color: .black.opacity(0.20), radius: 12, x: 0, y: 8)
    }
}
