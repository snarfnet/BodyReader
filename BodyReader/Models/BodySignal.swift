import Foundation

struct BodySignalCategory: Codable, Identifiable {
    let id: String
    let name: String
    let icon: String
    let signals: [BodySignal]
}

struct BodySignal: Codable, Identifiable {
    let id: String
    let nameJP: String
    let nameEN: String
    let description: String
    let psychology: String
    let examples: [String]
    let reliability: String
}

extension BodySignal {
    var reliabilityColor: String {
        switch reliability {
        case "高": return "#2BCB8A"
        case "中": return "#F3B755"
        case "低": return "#E55757"
        default: return "#8892A4"
        }
    }

    var iconName: String {
        if id.contains("face") { return "face.smiling" }
        if id.contains("hand") { return "hand.raised.fill" }
        if id.contains("posture") { return "figure.stand" }
        if id.contains("distance") { return "arrow.left.and.right" }
        return "sparkle.magnifyingglass"
    }
}
