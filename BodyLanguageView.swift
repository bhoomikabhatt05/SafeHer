import SwiftUI

struct BodyLanguageView: View {
    
    @State private var selectedTip: Int? = nil
    
    private let tips: [(icon: String, title: String, subtitle: String, detail: String, color: Color)] = [
        (
            icon: "figure.stand",
            title: "Stand Tall",
            subtitle: "Posture & Presence",
            detail: "Keep your shoulders back and chin level. An upright posture signals confidence and awareness. People who look confident are less likely to be targeted. Practice standing with your weight evenly distributed on both feet.",
            color: Color.safePrimary
        ),
        (
            icon: "eye.fill",
            title: "Confident Eye Contact",
            subtitle: "Awareness Signals",
            detail: "Brief, deliberate eye contact shows you're aware of your surroundings. Scan your environment casually — don't stare, but don't avoid eye contact either. Acknowledging someone's presence can deter unwanted behavior.",
            color: Color.safeAccent
        ),
        (
            icon: "speaker.wave.2.fill",
            title: "Use a Firm Voice",
            subtitle: "Verbal Boundaries",
            detail: "Practice speaking in a clear, steady tone. If you need to set a boundary, say \"No\" or \"Stop\" loudly and firmly. A confident voice carries authority. Practice projecting your voice from your diaphragm, not your throat.",
            color: Color.safeSecondary
        ),
        (
            icon: "figure.walk",
            title: "Walk with Purpose",
            subtitle: "Movement Confidence",
            detail: "Walk at a steady, deliberate pace. Avoid looking at your phone while walking. Keep your head up and scan ahead. People who walk purposefully appear to know where they're going and are harder to approach unexpectedly.",
            color: Color.safeSuccess
        ),
        (
            icon: "hand.raised.fill",
            title: "Personal Space",
            subtitle: "Physical Boundaries",
            detail: "Maintain an arm's length distance from strangers. If someone enters your space uninvited, step back or sidestep confidently. You have every right to your personal space. Practice the phrase: \"Please step back.\"",
            color: Color.safeWarning
        ),
        (
            icon: "brain.head.profile",
            title: "Trust Your Gut",
            subtitle: "Intuitive Awareness",
            detail: "Your intuition is a powerful safety tool. If something feels wrong, it probably is. Don't worry about being polite — leave the situation. Studies show that instinctive discomfort is often an accurate threat assessment.",
            color: Color.safeGradientEnd
        )
    ]
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // Intro
                    VStack(spacing: 8) {
                        Text("Confidence is your best protection")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                        
                        Text("Tap each card to learn more")
                            .font(.caption)
                            .foregroundStyle(Color.safeSubtext.opacity(0.6))
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 4)
                    
                    // Tips grid
                    ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
                        tipCard(index: index, tip: tip)
                    }
                    
                    // Bottom motivation
                    VStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.title2)
                            .foregroundStyle(Color.safeAccent)
                        
                        Text("Practice these daily and they become\nsecond nature")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationTitle("Body Language")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func tipCard(index: Int, tip: (icon: String, title: String, subtitle: String, detail: String, color: Color)) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                if selectedTip == index {
                    selectedTip = nil
                } else {
                    selectedTip = index
                }
            }
            HapticManager.shared.impact()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 14) {
                    // Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(tip.color.opacity(0.15))
                            .frame(width: 46, height: 46)
                        
                        Image(systemName: tip.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(tip.color)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(tip.title)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.safeText)
                        
                        Text(tip.subtitle)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.safeSubtext)
                    }
                    
                    Spacer()
                    
                    Image(systemName: selectedTip == index ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundStyle(Color.safeSubtext)
                }
                .padding(16)
                
                // Expanded detail
                if selectedTip == index {
                    VStack(alignment: .leading, spacing: 10) {
                        Divider()
                            .background(Color.safeCardBorder)
                        
                        Text(tip.detail)
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .glassCard(cornerRadius: 16)
        }
        .padding(.horizontal, 20)
        .accessibilityLabel("\(tip.title): \(tip.subtitle)")
        .accessibilityHint(selectedTip == index ? "Collapse" : "Tap to learn more")
    }
}
