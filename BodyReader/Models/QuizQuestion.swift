import Foundation

struct QuizQuestion: Codable, Identifiable {
    let id: String
    let situation: String
    let question: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    let category: String
}

struct QuizResult {
    let totalQuestions: Int
    let correctAnswers: Int

    var score: Int {
        guard totalQuestions > 0 else { return 0 }
        return Int(Double(correctAnswers) / Double(totalQuestions) * 100)
    }

    var grade: String {
        switch score {
        case 90...100: return "観察マスター"
        case 70..<90: return "かなり読めています"
        case 50..<70: return "基礎は十分"
        case 30..<50: return "伸びしろあり"
        default: return "まずは図鑑から"
        }
    }

    var gradeMessage: String {
        switch score {
        case 90...100:
            return "ひとつのサインに飛びつかず、複数の手がかりを合わせて読めています。"
        case 70..<90:
            return "良い観察です。場面ごとの違いを意識すると、さらに精度が上がります。"
        case 50..<70:
            return "基本はつかめています。顔、手、姿勢、距離をセットで見る練習を続けましょう。"
        case 30..<50:
            return "まだ伸びます。まずはよく出るサインから少しずつ覚えるのがおすすめです。"
        default:
            return "図鑑を見ながら、決めつけずに観察するところから始めましょう。"
        }
    }
}
