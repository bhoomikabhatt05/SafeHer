import SwiftUI

struct SafetyMythView: View {
    
    @State private var currentIndex = 0
    @State private var offset: CGFloat = 0
    @State private var showAnswer = false
    @State private var score = 0
    @State private var answered = 0
    @State private var resultColor: Color = .clear
    
    private let myths: [(statement: String, isFact: Bool, explanation: String)] = [
        (
            "Most attacks happen by strangers in dark alleys.",
            false,
            "Most incidents actually involve someone the person knows. While stranger danger exists, awareness in familiar settings is equally important."
        ),
        (
            "Trusting your gut feeling is one of the best safety tools you have.",
            true,
            "Research shows that intuitive discomfort is often an accurate subconscious threat assessment. If something feels off, it probably is."
        ),
        (
            "Carrying a weapon guarantees your safety.",
            false,
            "Weapons can be taken and used against you. Awareness, de-escalation skills, and avoidance are statistically more effective safety strategies."
        ),
        (
            "Making eye contact with a potential threat can deter them.",
            true,
            "Eye contact signals that you are aware and alert. Aggressors typically look for people who appear distracted or unaware."
        ),
        (
            "You should always fight back physically in a dangerous situation.",
            false,
            "The safest response depends on the situation. Sometimes compliance, de-escalation, or escape is safer than physical confrontation."
        ),
        (
            "Sharing your live location with a trusted person improves safety.",
            true,
            "Location sharing gives trusted contacts the ability to check on you and provides a trail if something goes wrong."
        ),
        (
            "If you dress a certain way, you're more likely to be targeted.",
            false,
            "Research consistently shows that clothing is not a factor. Targeting is based on perceived vulnerability, not appearance."
        ),
        (
            "Practicing safety scenarios improves real-life response time.",
            true,
            "Mental rehearsal is used by military, athletes, and safety experts. Practicing responses creates neural pathways that activate under stress."
        ),
        (
            "You can always tell if your drink has been tampered with.",
            false,
            "Most substances used to tamper with drinks are odorless, colorless, and tasteless. Always watch your drink being made and keep it with you."
        ),
        (
            "Walking confidently reduces the chance of being targeted.",
            true,
            "Studies show that people who walk with purpose, upright posture, and steady pace are less likely to be selected as targets."
        )
    ]
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            if answered >= myths.count {
                resultsView
            } else {
                cardGameView
            }
        }
        .navigationTitle("Myth or Fact")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Card Game
    
    private var cardGameView: some View {
        VStack(spacing: 20) {
            
            // Score
            HStack {
                Text("\(answered + 1) of \(myths.count)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.safeSubtext)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(Color.safeWarning)
                    Text("\(score)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)
            
            Spacer()
            
            // Card
            ZStack {
                // Background card hint
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.safeCard)
                    .frame(width: 280, height: 360)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.safeCardBorder, lineWidth: 0.5)
                    )
                    .offset(y: 8)
                    .scaleEffect(0.95)
                    .opacity(answered < myths.count - 1 ? 0.5 : 0)
                
                // Main card
                VStack(spacing: 20) {
                    Image(systemName: "questionmark.diamond.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.safeAccent, Color.safeGradientEnd],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    Text(myths[currentIndex].statement)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 8)
                    
                    if showAnswer {
                        VStack(spacing: 8) {
                            Divider().background(Color.safeCardBorder)
                            
                            Text(myths[currentIndex].explanation)
                                .font(.system(size: 13, design: .rounded))
                                .foregroundStyle(Color.safeSubtext)
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
                .padding(28)
                .frame(width: 300)
                .glassCard(cornerRadius: 24)
                .offset(x: offset)
                .rotationEffect(.degrees(Double(offset / 20)))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if !showAnswer {
                                offset = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if !showAnswer {
                                if value.translation.width > 80 {
                                    swipe(isFact: true)
                                } else if value.translation.width < -80 {
                                    swipe(isFact: false)
                                } else {
                                    withAnimation(.spring(response: 0.3)) {
                                        offset = 0
                                    }
                                }
                            }
                        }
                )
                .animation(.spring(response: 0.3), value: offset)
                
                // Swipe indicators
                if !showAnswer {
                    HStack {
                        // Myth indicator
                        Text("MYTH")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeAccent)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.safeAccent, lineWidth: 2)
                            )
                            .opacity(Double(-min(offset, 0)) / 80)
                            .offset(x: -20)
                        
                        Spacer()
                        
                        // Fact indicator
                        Text("FACT")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeSuccess)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.safeSuccess, lineWidth: 2)
                            )
                            .opacity(Double(max(offset, 0)) / 80)
                            .offset(x: 20)
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            Spacer()
            
            if showAnswer {
                Button {
                    moveToNext()
                } label: {
                    Text(answered >= myths.count - 1 ? "See Results" : "Next")
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
                .transition(.move(edge: .bottom).combined(with: .opacity))
                // Tap buttons
                HStack(spacing: 20) {
                    Button {
                        swipe(isFact: false)
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "xmark")
                                .font(.caption.bold())
                            Text("Myth")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.safeAccent)
                        .cornerRadius(14)
                    }
                    
                    Button {
                        swipe(isFact: true)
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark")
                                .font(.caption.bold())
                            Text("Fact")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.safeSuccess)
                        .cornerRadius(14)
                    }
                }
                .padding(.horizontal, 24)
            }
            
            Spacer().frame(height: 30)
        }
    }
    
    // MARK: - Results
    
    private var resultsView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.08), lineWidth: 8)
                    .frame(width: 130, height: 130)
                
                Circle()
                    .trim(from: 0, to: CGFloat(score) / CGFloat(myths.count))
                    .stroke(
                        LinearGradient(
                            colors: [Color.safeAccent, Color.safeSuccess],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 130, height: 130)
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 2) {
                    Text("\(score)/\(myths.count)")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                    Text("Correct")
                        .font(.caption)
                        .foregroundStyle(Color.safeSubtext)
                }
            }
            
            Text("Myth Buster!")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(Color.safeText)
            
            Text("Now you know the facts.\nShare this knowledge to help others stay safe.")
                .font(.body)
                .foregroundStyle(Color.safeSubtext)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button {
                currentIndex = 0
                offset = 0
                showAnswer = false
                score = 0
                answered = 0
            } label: {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Play Again")
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
        }
    }
    
    // MARK: - Helpers
    
    private func swipe(isFact: Bool) {
        let correct = myths[currentIndex].isFact == isFact
        if correct { score += 1 }
        
        withAnimation(.spring(response: 0.3)) {
            offset = isFact ? 300 : -300
        }
        
        HapticManager.shared.impact()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.3)) {
                offset = 0
                showAnswer = true
            }
        }
    }
    
    private func moveToNext() {
        answered += 1
        if answered < myths.count {
            withAnimation {
                currentIndex = answered
                showAnswer = false
            }
        }
    }
}
