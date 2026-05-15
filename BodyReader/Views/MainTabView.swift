import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                DictionaryView()
                    .tabItem { Label(AppStrings.tabDictionary, systemImage: "person.text.rectangle.fill") }
                    .tag(0)

                QuizView()
                    .tabItem { Label(AppStrings.tabQuiz, systemImage: "sparkle.magnifyingglass") }
                    .tag(1)

                ScenesView()
                    .tabItem { Label(AppStrings.tabScenes, systemImage: "rectangle.3.group.bubble.left.fill") }
                    .tag(2)

                AboutView()
                    .tabItem { Label(AppStrings.tabAbout, systemImage: "heart.text.square.fill") }
                    .tag(3)
            }
            BottomAdBannerView()
        }
        .tint(AppColors.gold)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(AppColors.ink)

            let item = UITabBarItemAppearance()
            item.normal.iconColor = UIColor.white.withAlphaComponent(0.48)
            item.normal.titleTextAttributes = [
                .foregroundColor: UIColor.white.withAlphaComponent(0.48),
                .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
            ]
            item.selected.iconColor = UIColor(AppColors.gold)
            item.selected.titleTextAttributes = [
                .foregroundColor: UIColor(AppColors.gold),
                .font: UIFont.systemFont(ofSize: 10, weight: .bold)
            ]

            appearance.stackedLayoutAppearance = item
            appearance.inlineLayoutAppearance = item
            appearance.compactInlineLayoutAppearance = item
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
