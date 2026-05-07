import SwiftUI

struct AppColors {
    static let ink = Color(hex: "#071A2F")
    static let inkSoft = Color(hex: "#102B3F")
    static let paper = Color(hex: "#FFF4E7")
    static let paperDeep = Color(hex: "#F3D8BE")
    static let coral = Color(hex: "#FF6F61")
    static let coralSoft = Color(hex: "#FFD1C8")
    static let teal = Color(hex: "#19C6B4")
    static let tealSoft = Color(hex: "#C7F5EA")
    static let gold = Color(hex: "#F3B755")
    static let clay = Color(hex: "#B95D47")

    static let accent = coral
    static let lavender = Color(hex: "#8FA7FF")
    static let cream = gold
    static let backgroundStart = ink
    static let backgroundEnd = Color(hex: "#132D3F")
    static let textPrimary = Color(hex: "#271D1A")
    static let textSecondary = Color(hex: "#765F56")
    static let cardBackground = Color.white.opacity(0.86)
    static let cardBorder = Color.white.opacity(0.38)
    static let success = Color(hex: "#2BCB8A")
    static let error = Color(hex: "#E55757")
    static let pastelPink = coralSoft
    static let pastelMint = tealSoft
    static let pastelLavender = Color(hex: "#DCE5FF")
    static let pastelYellow = Color(hex: "#FFE7B8")
    static let pastelBlue = Color(hex: "#CDEBFF")
}

struct AppFonts {
    static func title(_ size: CGFloat = 28) -> Font {
        .system(size: size, weight: .black, design: .rounded)
    }

    static func headline(_ size: CGFloat = 18) -> Font {
        .system(size: size, weight: .bold, design: .rounded)
    }

    static func body(_ size: CGFloat = 15) -> Font {
        .system(size: size, weight: .regular, design: .rounded)
    }

    static func caption(_ size: CGFloat = 12) -> Font {
        .system(size: size, weight: .semibold, design: .rounded)
    }
}

struct AppStrings {
    static let appName = "BodyReader"
    static let tabDictionary = "図鑑"
    static let tabQuiz = "クイズ"
    static let tabScenes = "シーン"
    static let tabAbout = "ガイド"
}
