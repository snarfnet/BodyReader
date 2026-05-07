import Foundation

struct SceneGuide: Codable, Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    let points: [ScenePoint]
}

struct ScenePoint: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let tip: String
}
