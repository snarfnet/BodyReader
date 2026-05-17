import SwiftUI

struct DictionaryView: View {
    @StateObject private var viewModel = DictionaryViewModel()
    @State private var selectedSignal: BodySignal?

    var body: some View {
        ZStack {
            AppBackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    HeroArtCard(
                        imageName: "hero-bodyreader",
                        eyebrow: "BODY SIGNAL ATLAS",
                        title: "しぐさから気持ちの手がかりを読む",
                        subtitle: "顔、手、姿勢、距離感。ひとつのサインで決めつけず、複数の手がかりを合わせて見ます。"
                    )
                    .padding(.horizontal, 18)
                    .padding(.top, 14)

                    searchBar
                        .padding(.horizontal, 18)

                    HStack {
                        SectionHeader("ボディサイン図鑑", subtitle: "\(viewModel.allSignals.count)個のサインを画像つきで整理")
                        Spacer()
                    }
                    .padding(.horizontal, 18)

                    ForEach(viewModel.filteredCategories) { category in
                        CategorySection(category: category) { signal in
                            selectedSignal = signal
                        }
                    }

                    Spacer(minLength: 34)
                }
            }
        }
        .sheet(item: $selectedSignal) { signal in
            SignalDetailView(signal: signal)
        }
    }

    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(AppColors.gold)
            TextField("サイン名や説明で検索", text: $viewModel.searchText)
                .font(AppFonts.body(15))
                .foregroundStyle(.white)
                .tint(AppColors.gold)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(.white.opacity(0.09), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(.white.opacity(0.18), lineWidth: 1))
    }
}

private let categoryAccents: [Color] = [AppColors.coral, AppColors.teal, AppColors.gold, AppColors.lavender]

struct CategorySection: View {
    let category: BodySignalCategory
    let onSelect: (BodySignal) -> Void
    @State private var isExpanded = true

    private var accent: Color {
        categoryAccents[abs(category.id.hashValue) % categoryAccents.count]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                    isExpanded.toggle()
                }
            } label: {
                ZStack(alignment: .bottomLeading) {
                    Image(category.artName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 154)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    LinearGradient(colors: [.clear, .black.opacity(0.78)], startPoint: .top, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))

                    HStack(alignment: .bottom, spacing: 12) {
                        CategoryIconView(systemName: category.icon, color: accent, size: 46)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(category.name)
                                .font(AppFonts.title(22))
                                .foregroundStyle(.white)
                            Text("\(category.signals.count)個のサイン")
                                .font(AppFonts.caption(12))
                                .foregroundStyle(.white.opacity(0.72))
                        }
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(accent)
                    }
                    .padding(16)
                }
                .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(.white.opacity(0.16), lineWidth: 1))
            }
            .buttonStyle(CardPressStyle())
            .padding(.horizontal, 18)

            if isExpanded {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 230), spacing: 12)], spacing: 12) {
                    ForEach(category.signals) { signal in
                        Button { onSelect(signal) } label: {
                            SignalCardView(signal: signal, accent: accent)
                        }
                        .buttonStyle(CardPressStyle())
                    }
                }
                .padding(.horizontal, 18)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

struct SignalCardView: View {
    let signal: BodySignal
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: signal.iconName)
                    .font(.system(size: 19, weight: .bold))
                    .foregroundStyle(accent)
                    .frame(width: 36, height: 36)
                    .background(accent.opacity(0.14), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                Spacer()
                ReliabilityBadge(level: signal.reliability)
                    .scaleEffect(0.88)
            }

            Text(signal.nameJP)
                .font(AppFonts.headline(15))
                .foregroundStyle(AppColors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Text(signal.nameEN)
                .font(AppFonts.caption(11))
                .foregroundStyle(accent)
                .fixedSize(horizontal: false, vertical: true)

            Text(signal.description)
                .font(AppFonts.body(12))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 176, alignment: .topLeading)
        .padding(14)
        .background(AppColors.paper.opacity(0.94), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(accent.opacity(0.26), lineWidth: 1))
        .shadow(color: .black.opacity(0.18), radius: 14, x: 0, y: 8)
    }
}
