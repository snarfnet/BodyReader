import SwiftUI
import Combine

class QuizViewModel: ObservableObject {
    @Published var questions: [QuizQuestion] = []
    @Published var currentIndex: Int = 0
    @Published var selectedAnswer: Int? = nil
    @Published var showExplanation: Bool = false
    @Published var correctCount: Int = 0
    @Published var isFinished: Bool = false

    private var allQuestions: [QuizQuestion] = []

    init() {
        loadData()
    }

    private func loadData() {
        guard let url = Bundle.main.url(forResource: "quiz_data", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        allQuestions = (try? JSONDecoder().decode([QuizQuestion].self, from: data)) ?? []
        startNewQuiz()
    }

    func startNewQuiz() {
        questions = Array(allQuestions.shuffled().prefix(20))
        currentIndex = 0
        selectedAnswer = nil
        showExplanation = false
        correctCount = 0
        isFinished = false
    }

    var currentQuestion: QuizQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentIndex) / Double(questions.count)
    }

    var result: QuizResult {
        QuizResult(totalQuestions: questions.count, correctAnswers: correctCount)
    }

    func selectAnswer(_ index: Int) {
        guard selectedAnswer == nil else { return }
        selectedAnswer = index
        if let question = currentQuestion, index == question.correctIndex {
            correctCount += 1
        }
        withAnimation {
            showExplanation = true
        }
    }

    func nextQuestion() {
        if currentIndex + 1 >= questions.count {
            isFinished = true
        } else {
            currentIndex += 1
            selectedAnswer = nil
            showExplanation = false
        }
    }
}
