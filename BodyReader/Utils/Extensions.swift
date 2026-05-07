import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension View {
    // Soft pastel card: white fill + subtle pink border + gentle shadow
    func glassCard(cornerRadius: CGFloat = 20) -> some View {
        self
            .background(AppColors.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(AppColors.cardBorder, lineWidth: 1.2)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: Color(hex: "#F0A8D0").opacity(0.18), radius: 8, x: 0, y: 4)
    }

    // Pastel card with a tint colour accent on the left edge
    func pastelCard(tint: Color, cornerRadius: CGFloat = 20) -> some View {
        self
            .background(
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(AppColors.cardBackground)
                    Rectangle()
                        .fill(tint.opacity(0.55))
                        .frame(width: 4)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: cornerRadius,
                                bottomLeadingRadius: cornerRadius,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 0
                            )
                        )
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(tint.opacity(0.30), lineWidth: 1.2)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: tint.opacity(0.15), radius: 8, x: 0, y: 4)
    }

    func appBackground() -> some View {
        self.background(
            LinearGradient(
                colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

extension String {
    func loadJSON<T: Decodable>() -> T? {
        guard let url = Bundle.main.url(forResource: self, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
