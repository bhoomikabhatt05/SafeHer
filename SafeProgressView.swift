import SwiftUI

struct SafeProgressView: View {
    
    @EnvironmentObject var progress: ProgressManager
    @State private var animateRing = false
    
    private var ringProgress: CGFloat {
        min(CGFloat(progress.totalSessions) / 30.0, 1.0)
    }
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    
                    // Progress Ring
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.06), lineWidth: 14)
                            .frame(width: 180, height: 180)
                        
                        Circle()
                            .trim(from: 0, to: animateRing ? ringProgress : 0)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.safeAccent, Color.safeGradientEnd],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 14, lineCap: .round)
                            )
                            .frame(width: 180, height: 180)
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: 4) {
                            Text("\(progress.totalSessions)")
                                .font(.system(size: 42, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeText)
                            
                            Text("Sessions")
                                .font(.caption)
                                .foregroundStyle(Color.safeSubtext)
                        }
                    }
                    .padding(.vertical, 10)
                    .accessibilityLabel("\(progress.totalSessions) sessions completed out of 30 goal")
                    
                    // Stats cards
                    HStack(spacing: 14) {
                        statCard(
                            icon: "flame.fill",
                            value: "\(progress.currentStreak)",
                            label: "Day Streak",
                            color: Color.safeAccent
                        )
                        
                        statCard(
                            icon: progress.levelIcon,
                            value: progress.levelTitle,
                            label: "Level",
                            color: Color.safeWarning
                        )
                        
                        statCard(
                            icon: "target",
                            value: "\(max(30 - progress.totalSessions, 0))",
                            label: "To Goal",
                            color: Color.safeSuccess
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // Motivational message
                    VStack(spacing: 10) {
                        Image(systemName: "quote.opening")
                            .font(.title3)
                            .foregroundStyle(Color.safeAccent.opacity(0.5))
                        
                        Text(progress.motivationalMessage)
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.safeText)
                            .multilineTextAlignment(.center)
                        
                        Image(systemName: "quote.closing")
                            .font(.title3)
                            .foregroundStyle(Color.safeAccent.opacity(0.5))
                    }
                    .padding(20)
                    .glassCard(cornerRadius: 20)
                    .padding(.horizontal, 20)
                    
                    // CTA
                    NavigationLink("Practice Now") {
                        ScenarioSelectionView()
                    }
                    .buttonStyle(MainButton())
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationTitle("Your Progress")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.easeOut(duration: 1.2).delay(0.3)) {
                animateRing = true
            }
        }
    }
    
    private func statCard(icon: String, value: String, label: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(Color.safeText)
            
            Text(label)
                .font(.caption2)
                .foregroundStyle(Color.safeSubtext)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .glassCard(cornerRadius: 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }
}
