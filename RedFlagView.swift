import SwiftUI

struct RedFlagView: View {
    
    @State private var currentIndex = 0
    @State private var showDetail = false
    @State private var redCount = 0
    @State private var greenCount = 0
    @State private var done = false
    
    private let flags: [(text: String, isRed: Bool, why: String)] = [
        ("They insist on knowing your location at all times", true, "Excessive monitoring is a control tactic, not care. Healthy relationships respect personal space and trust."),
        ("They encourage you to spend time with your friends", false, "Supporting your independence and social life is a sign of a secure, healthy relationship."),
        ("They get angry when you don't reply instantly", true, "Demanding immediate responses is controlling behavior. Everyone has the right to respond at their own pace."),
        ("They respect when you say 'no' to something", false, "Respecting boundaries without guilt-tripping is a fundamental green flag in any relationship."),
        ("They check your phone without permission", true, "Going through your private messages is a violation of trust and personal boundaries."),
        ("They celebrate your achievements genuinely", false, "A supportive person is happy for your success, not threatened by it."),
        ("They isolate you from family and friends", true, "Cutting you off from your support network makes you dependent on them — a classic manipulation tactic."),
        ("They apologize and change when they hurt you", false, "Genuine accountability and behavior change show emotional maturity and respect."),
        ("They make you feel guilty for having boundaries", true, "Guilt-tripping over boundaries is emotional manipulation. Your limits are valid."),
        ("They communicate openly about their feelings", false, "Honest, vulnerable communication builds trust and shows emotional safety."),
        ("They threaten to hurt themselves if you leave", true, "Using self-harm threats to control your decisions is emotional abuse. It's not your responsibility."),
        ("They support your goals even when it's inconvenient", false, "Prioritizing your growth shows genuine care, not possessiveness.")
    ]
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            if done {
                resultsView
            } else {
                flagCardView
            }
        }
        .navigationTitle("Red or Green Flag")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var flagCardView: some View {
        VStack(spacing: 20) {
            HStack {
                Text("\(currentIndex + 1) of \(flags.count)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.safeSubtext)
                Spacer()
                HStack(spacing: 12) {
                    Label("\(redCount)", systemImage: "flag.fill")
                        .font(.caption)
                        .foregroundStyle(Color.safeAccent)
                    Label("\(greenCount)", systemImage: "flag.fill")
                        .font(.caption)
                        .foregroundStyle(Color.safeSuccess)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)
            
            Spacer()
            
            // Card
            VStack(spacing: 20) {
                Image(systemName: "flag.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.safeSubtext.opacity(0.3))
                
                Text(flags[currentIndex].text)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.safeText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                if showDetail {
                    VStack(spacing: 8) {
                        Divider().background(Color.safeCardBorder)
                        
                        HStack(spacing: 6) {
                            Image(systemName: flags[currentIndex].isRed ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                                .foregroundStyle(flags[currentIndex].isRed ? Color.safeAccent : Color.safeSuccess)
                            Text(flags[currentIndex].isRed ? "Red Flag" : "Green Flag")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(flags[currentIndex].isRed ? Color.safeAccent : Color.safeSuccess)
                        }
                        
                        Text(flags[currentIndex].why)
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
            
            Spacer()
            
            if showDetail {
                Button {
                    nextCard()
                } label: {
                    Text(currentIndex >= flags.count - 1 ? "See Results" : "Next")
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
            } else {
                HStack(spacing: 20) {
                    Button {
                        answer(isRed: true)
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "flag.fill")
                                .font(.caption)
                            Text("Red Flag")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.safeAccent)
                        .cornerRadius(14)
                    }
                    
                    Button {
                        answer(isRed: false)
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "flag.fill")
                                .font(.caption)
                            Text("Green Flag")
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
    
    private var resultsView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "flag.checkered")
                .font(.system(size: 50))
                .foregroundStyle(Color.safeAccent)
            
            Text("Awareness Unlocked!")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(Color.safeText)
            
            Text("Recognizing red and green flags\nis one of the most important safety skills.")
                .font(.body)
                .foregroundStyle(Color.safeSubtext)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            HStack(spacing: 30) {
                VStack(spacing: 4) {
                    Text("\(redCount)")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeAccent)
                    Text("Red Flags")
                        .font(.caption)
                        .foregroundStyle(Color.safeSubtext)
                }
                
                VStack(spacing: 4) {
                    Text("\(greenCount)")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeSuccess)
                    Text("Green Flags")
                        .font(.caption)
                        .foregroundStyle(Color.safeSubtext)
                }
            }
            
            Spacer()
            
            Button {
                currentIndex = 0
                showDetail = false
                redCount = 0
                greenCount = 0
                done = false
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
    
    private func answer(isRed: Bool) {
        let correct = flags[currentIndex].isRed == isRed
        if flags[currentIndex].isRed { redCount += 1 } else { greenCount += 1 }
        
        withAnimation(.spring(response: 0.3)) {
            showDetail = true
        }
        HapticManager.shared.impact()
    }
    
    private func nextCard() {
        if currentIndex >= flags.count - 1 {
            withAnimation { done = true }
        } else {
            withAnimation {
                currentIndex += 1
                showDetail = false
            }
        }
    }
}
