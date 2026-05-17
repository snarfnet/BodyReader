import SwiftUI

struct QuizView: View {
    @StateObject private var viewModel = QuizViewModel()

    var body: some View {
        ZStack {
            AppBackgroundView()

            if viewModel.isFinished {
                QuizResultView(result: viewModel.result) {
                    viewModel.startNewQuiz()
                }
            } else if let question = viewModel.currentQuestion {
                QuizQuestionView(
                    question: question,
                    questionNumber: viewModel.currentIndex + 1,
                    totalQuestions: viewModel.questions.count,
                    progress: viewModel.progress,
                    selectedAnswer: viewModel.selectedAnswer,
                    showExplanation: viewModel.showExplanation,
                    correctCount: viewModel.correctCount,
                    onSelect: { viewModel.selectAnswer($0) },
                    onNext: { viewModel.nextQuestion() }
                )
            } else {
                EmptyQuizView {
                    viewModel.startNewQuiz()
                }
            }
        }
        .animation(.spring(response: 0.38, dampingFraction: 0.82), value: viewModel.currentIndex)
        .animation(.spring(response: 0.38, dampingFraction: 0.82), value: viewModel.isFinished)
    }
}

struct QuizQuestionView: View {
    let question: QuizQuestion
    let questionNumber: Int
    let totalQuestions: Int
    let progress: Double
    let selectedAnswer: Int?
    let showExplanation: Bool
    let correctCount: Int
    let onSelect: (Int) -> Void
    let onNext: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HeroArtCard(
                    imageName: "quiz-clues",
                    eyebrow: "PRACTICE",
                    title: "読み取りクイズ",
                    subtitle: "場面を読んで、相手の気持ちに近い選択肢を選びます。"
                )
                .padding(.horizontal, 18)
                .padding(.top, 14)

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("問題 \(questionNumber) / \(totalQuestions)")
                            .font(AppFonts.caption(13))
                            .foregroundStyle(.white.opacity(0.72))
                        Spacer()
                        Text("\(correctCount)問 正解")
                            .font(AppFonts.caption(13))
                            .foregroundStyle(AppColors.gold)
                    }
                    ProgressView(value: progress)
                        .tint(AppColors.gold)
                }
                .padding(.horizontal, 18)

                VStack(alignment: .leading, spacing: 12) {
                    PillTag(text: question.category, color: AppColors.teal)
                    Text(question.situation)
                        .font(AppFonts.body(14))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineSpacing(5)
                    Text(question.question)
                        .font(AppFonts.headline(18))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineSpacing(4)
                }
                .padding(18)
                .background(AppColors.paper.opacity(0.94), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(AppColors.gold.opacity(0.22), lineWidth: 1))
                .padding(.horizontal, 18)

                VStack(spacing: 10) {
                    ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                        QuizOptionButton(
                            text: option,
                            index: index,
                            selectedAnswer: selectedAnswer,
                            correctIndex: question.correctIndex
                        ) {
                            onSelect(index)
                        }
                    }
                }
                .padding(.horizontal, 18)

                if showExplanation {
                    ExplanationView(
                        isCorrect: selectedAnswer == question.correctIndex,
                        explanation: question.explanation,
                        onNext: onNext,
                        isLast: questionNumber == totalQuestions
                    )
                    .padding(.horizontal, 18)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                Spacer(minLength: 40)
            }
        }
    }
}

struct QuizOptionButton: View {
    let text: String
    let index: Int
    let selectedAnswer: Int?
    let correctIndex: Int
    let onSelect: () -> Void

    private let labels = ["A", "B", "C", "D"]
    private var hasAnswered: Bool { selectedAnswer != nil }
    private var isSelected: Bool { selectedAnswer == index }
    private var isCorrect: Bool { correctIndex == index }
    private var accent: Color {
        if !hasAnswered { return AppColors.teal }
        if isCorrect { return AppColors.success }
        if isSelected { return AppColors.error }
        return AppColors.textSecondary.opacity(0.55)
    }

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 13) {
                Text(hasAnswered && isCorrect ? "✓" : labels[index])
                    .font(AppFonts.headline(14))
                    .foregroundStyle(isCorrect && hasAnswered ? AppColors.ink : accent)
                    .frame(width: 34, height: 34)
                    .background(hasAnswered && isCorrect ? accent : accent.opacity(0.14), in: Circle())
                Text(text)
                    .font(AppFonts.body(14))
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(3)
                Spacer()
            }
            .padding(15)
            .background(AppColors.paper.opacity(0.94), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(accent.opacity(0.30), lineWidth: 1))
            .shadow(color: .black.opacity(0.14), radius: 10, x: 0, y: 6)
        }
        .disabled(hasAnswered)
        .buttonStyle(CardPressStyle())
    }
}

struct ExplanationView: View {
    let isCorrect: Bool
    let explanation: String
    let onNext: () -> Void
    let isLast: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(spacing: 8) {
                Image(systemName: isCorrect ? "checkmark.seal.fill" : "lightbulb.fill")
                    .foregroundStyle(isCorrect ? AppColors.success : AppColors.gold)
                Text(isCorrect ? "正解です" : "解説")
                    .font(AppFonts.headline(16))
                    .foregroundStyle(AppColors.textPrimary)
            }
            Text(explanation)
                .font(AppFonts.body(14))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(5)
            Button(action: onNext) {
                Text(isLast ? "結果を見る" : "次の問題へ")
                    .font(AppFonts.headline(15))
                    .foregroundStyle(AppColors.ink)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(AppColors.gold, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
        .padding(18)
        .background(AppColors.paper.opacity(0.96), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

struct QuizResultView: View {
    let result: QuizResult
    let onRetry: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                HeroArtCard(
                    imageName: "read-gently",
                    eyebrow: "RESULT",
                    title: "\(result.score)点",
                    subtitle: result.gradeMessage
                )
                .padding(.horizontal, 18)
                .padding(.top, 14)

                Text(result.grade)
                    .font(AppFonts.title(30))
                    .foregroundStyle(AppColors.gold)

                HStack(spacing: 12) {
                    StatCard(title: "正解", value: "\(result.correctAnswers)", tint: AppColors.pastelMint, accent: AppColors.teal)
                    StatCard(title: "問題", value: "\(result.totalQuestions)", tint: AppColors.pastelLavender, accent: AppColors.lavender)
                    StatCard(title: "正答率", value: "\(result.score)%", tint: AppColors.pastelYellow, accent: AppColors.gold)
                }
                .padding(.horizontal, 18)

                Button(action: onRetry) {
                    Text("もう一度はじめる")
                        .font(AppFonts.headline(16))
                        .foregroundStyle(AppColors.ink)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(AppColors.gold, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
                .padding(.horizontal, 18)

                Spacer(minLength: 40)
            }
        }
    }
}

struct EmptyQuizView: View {
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            CategoryIconView(systemName: "exclamationmark.triangle.fill", color: AppColors.gold, size: 54)
            Text("クイズを準備できませんでした")
                .font(AppFonts.headline(18))
                .foregroundStyle(.white)
            Button("再読み込み", action: onRetry)
                .font(AppFonts.headline(15))
                .foregroundStyle(AppColors.ink)
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
                .background(AppColors.gold, in: Capsule())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let tint: Color
    let accent: Color

    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(AppFonts.title(24))
                .foregroundStyle(AppColors.textPrimary)
            Text(title)
                .font(AppFonts.caption(12))
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(tint.opacity(0.86), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).stroke(accent.opacity(0.26), lineWidth: 1))
    }
}
