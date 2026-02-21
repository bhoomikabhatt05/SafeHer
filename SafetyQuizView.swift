import SwiftUI

struct SafetyQuizView: View {
    
    @State private var questions: [QuizQuestion] = QuizQuestion.randomQuiz(count: 5)
    @State private var currentIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showExplanation = false
    @State private var score = 0
    @State private var quizComplete = false
    @State private var showContent = false
    @State private var timeRemaining = 15
    @State private var timerActive = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            if quizComplete {
                quizResultsView
            } else if questions.isEmpty {
                ProgressView()
                    .tint(Color.safeAccent)
            } else {
                quizQuestionView
            }
        }
        .navigationTitle("Safety Quiz")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Question View
    
    private var quizQuestionView: some View {
        let question = questions[currentIndex]
        
        return ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                
                // Progress + Timer
                HStack {
                    // Question counter
                    Text("Question \(currentIndex + 1) of \(questions.count)")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.safeSubtext)
                    
                    Spacer()
                    
                    // Timer
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                        Text("\(timeRemaining)s")
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                    }
                    .foregroundStyle(timeRemaining <= 5 ? Color.safeAccent : Color.safeSubtext)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.white.opacity(0.08))
                            .frame(height: 4)
                        
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [Color.safeAccent, Color.safeGradientEnd],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geo.size.width * CGFloat(currentIndex + 1) / CGFloat(questions.count), height: 4)
                            .animation(.spring(response: 0.4), value: currentIndex)
                    }
                }
                .frame(height: 4)
                .padding(.horizontal, 20)
                
                // Scenario card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.caption)
                            .foregroundStyle(Color.safeWarning)
                        Text("SCENARIO")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeWarning)
                            .tracking(1.5)
                    }
                    
                    Text(question.scenario)
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.safeText)
                        .lineSpacing(4)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassCard(cornerRadius: 18)
                .padding(.horizontal, 20)
                
                // Answer options
                VStack(spacing: 10) {
                    ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                        Button {
                            selectAnswer(index)
                        } label: {
                            HStack(spacing: 14) {
                                // Letter badge
                                ZStack {
                                    Circle()
                                        .fill(answerColor(for: index).opacity(0.2))
                                        .frame(width: 32, height: 32)
                                    
                                    if showExplanation && index == question.correctIndex {
                                        Image(systemName: "checkmark")
                                            .font(.caption.bold())
                                            .foregroundStyle(Color.safeSuccess)
                                    } else if showExplanation && index == selectedAnswer && index != question.correctIndex {
                                        Image(systemName: "xmark")
                                            .font(.caption.bold())
                                            .foregroundStyle(Color.safeAccent)
                                    } else {
                                        Text(["A", "B", "C", "D"][index])
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                            .foregroundStyle(answerColor(for: index))
                                    }
                                }
                                
                                Text(option)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(Color.safeText)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                            .padding(14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(answerBackground(for: index))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(answerBorder(for: index), lineWidth: selectedAnswer == index ? 1.5 : 0.5)
                            )
                        }
                        .disabled(showExplanation)
                        .accessibilityLabel("Option \(["A", "B", "C", "D"][index]): \(option)")
                    }
                }
                .padding(.horizontal, 20)
                
                // Explanation card
                if showExplanation {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: selectedAnswer == question.correctIndex ? "checkmark.circle.fill" : "info.circle.fill")
                                .foregroundStyle(selectedAnswer == question.correctIndex ? Color.safeSuccess : Color.safeAccent)
                            
                            Text(selectedAnswer == question.correctIndex ? "Correct!" : "Not quite")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(selectedAnswer == question.correctIndex ? Color.safeSuccess : Color.safeAccent)
                        }
                        
                        Text(question.explanation)
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                            .lineSpacing(3)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(selectedAnswer == question.correctIndex ? Color.safeSuccess.opacity(0.08) : Color.safeAccent.opacity(0.08))
                    )
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    
                    // Next button
                    Button(action: nextQuestion) {
                        Text(currentIndex < questions.count - 1 ? "Next Question" : "See Results")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                LinearGradient(
                                    colors: [Color.safeAccent, Color.safeGradientEnd],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .onReceive(timer) { _ in
            guard timerActive && !showExplanation && !questions.isEmpty else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                selectAnswer(-1)
            }
        }
    }
    
    // MARK: - Results View
    
    private var quizResultsView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Score ring
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.08), lineWidth: 8)
                    .frame(width: 140, height: 140)
                
                Circle()
                    .trim(from: 0, to: CGFloat(score) / CGFloat(questions.count))
                    .stroke(
                        LinearGradient(
                            colors: [Color.safeAccent, Color.safeSuccess],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 140, height: 140)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 0.8), value: showContent)
                
                VStack(spacing: 4) {
                    Text("\(score)/\(questions.count)")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                    
                    Text("Score")
                        .font(.caption)
                        .foregroundStyle(Color.safeSubtext)
                }
            }
            .scaleEffect(showContent ? 1 : 0.5)
            .opacity(showContent ? 1 : 0)
            .accessibilityLabel("Your score: \(score) out of \(questions.count)")
            
            Text(resultTitle)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(Color.safeText)
                .opacity(showContent ? 1 : 0)
            
            Text(resultMessage)
                .font(.body)
                .foregroundStyle(Color.safeSubtext)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .opacity(showContent ? 1 : 0)
            
            Spacer()
            
            Button {
                // Retry quiz
                questions = QuizQuestion.randomQuiz(count: 5)
                currentIndex = 0
                selectedAnswer = nil
                showExplanation = false
                score = 0
                quizComplete = false
                showContent = false
                timeRemaining = 15
                timerActive = true
            } label: {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Try Again")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    LinearGradient(
                        colors: [Color.safeAccent, Color.safeGradientEnd],
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
            .opacity(showContent ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                showContent = true
            }
            HapticManager.shared.success()
        }
    }
    
    // MARK: - Helpers
    
    private func selectAnswer(_ index: Int) {
        guard !showExplanation else { return }
        selectedAnswer = index
        timerActive = false
        
        if index == questions[currentIndex].correctIndex {
            score += 1
        }
        
        withAnimation(.spring(response: 0.3)) {
            showExplanation = true
        }
        HapticManager.shared.impact()
    }
    
    private func nextQuestion() {
        if currentIndex < questions.count - 1 {
            withAnimation {
                currentIndex += 1
                selectedAnswer = nil
                showExplanation = false
                timeRemaining = 15
                timerActive = true
            }
        } else {
            withAnimation {
                quizComplete = true
            }
        }
    }
    
    private func answerColor(for index: Int) -> Color {
        guard showExplanation else { return Color.safeSubtext }
        if index == questions[currentIndex].correctIndex { return Color.safeSuccess }
        if index == selectedAnswer { return Color.safeAccent }
        return Color.safeSubtext
    }
    
    private func answerBackground(for index: Int) -> Color {
        guard showExplanation else {
            return selectedAnswer == index ? Color.white.opacity(0.06) : Color.safeCard
        }
        if index == questions[currentIndex].correctIndex { return Color.safeSuccess.opacity(0.08) }
        if index == selectedAnswer { return Color.safeAccent.opacity(0.08) }
        return Color.safeCard
    }
    
    private func answerBorder(for index: Int) -> Color {
        guard showExplanation else {
            return selectedAnswer == index ? Color.safeAccent.opacity(0.3) : Color.safeCardBorder
        }
        if index == questions[currentIndex].correctIndex { return Color.safeSuccess.opacity(0.4) }
        if index == selectedAnswer { return Color.safeAccent.opacity(0.3) }
        return Color.safeCardBorder
    }
    
    private var resultTitle: String {
        let pct = Double(score) / Double(questions.count)
        switch pct {
        case 0.8...1.0: return "Safety Expert!"
        case 0.6..<0.8: return "Well Prepared"
        case 0.4..<0.6: return "Getting There"
        default: return "Keep Learning"
        }
    }
    
    private var resultMessage: String {
        let pct = Double(score) / Double(questions.count)
        switch pct {
        case 0.8...1.0: return "Outstanding awareness! You know how to handle tough situations with confidence."
        case 0.6..<0.8: return "Good instincts! A little more practice will sharpen your awareness even further."
        case 0.4..<0.6: return "You're building solid foundations. Review the explanations to strengthen your knowledge."
        default: return "Every expert was once a beginner. The important thing is you're learning."
        }
    }
}
