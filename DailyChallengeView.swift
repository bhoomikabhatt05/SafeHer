import SwiftUI

struct DailyChallengeView: View {
    
    @AppStorage("lastChallengeDate") private var lastChallengeDate: String = ""
    @AppStorage("challengeStreak") private var streak: Int = 0
    @AppStorage("challengesCompleted") private var totalCompleted: Int = 0
    @State private var todayChallenge: DailyChallenge?
    @State private var isCompleted = false
    @State private var showConfetti = false
    
    struct DailyChallenge {
        let icon: String
        let title: String
        let description: String
        let category: String
        let color: Color
    }
    
    private let challenges: [DailyChallenge] = [
        DailyChallenge(icon: "eye.fill", title: "Exit Spotter", description: "Every time you enter a building today, identify 2 exits before doing anything else.", category: "Awareness", color: Color.safeAccent),
        DailyChallenge(icon: "figure.stand", title: "Power Posture", description: "Stand tall with shoulders back for 2 minutes. Notice how it changes how you feel and how people respond.", category: "Body Language", color: Color.safePrimary),
        DailyChallenge(icon: "ear.fill", title: "Sound Map", description: "Close your eyes for 1 minute and identify every sound around you. This sharpens your environmental awareness.", category: "Awareness", color: Color.safeSuccess),
        DailyChallenge(icon: "person.2.fill", title: "Trust Check-In", description: "Send your current location to a trusted contact with a quick 'thinking of you' message.", category: "Connection", color: Color.safeSecondary),
        DailyChallenge(icon: "iphone.gen3", title: "Digital Hygiene", description: "Review your app permissions today. Revoke location access from any app that doesn't need it.", category: "Digital Safety", color: Color.safeWarning),
        DailyChallenge(icon: "speaker.wave.2.fill", title: "Voice Power", description: "Practice saying 'No' and 'Stop' firmly out loud 5 times. Your voice is one of your best tools.", category: "Confidence", color: Color.safeAccent),
        DailyChallenge(icon: "map.fill", title: "Route Planner", description: "Plan an alternate route home. Having options gives you flexibility in unexpected situations.", category: "Preparedness", color: Color.safeGradientEnd),
        DailyChallenge(icon: "brain.head.profile", title: "Gut Check", description: "Notice one moment today where your instincts told you something. Write it down — what did you feel and why?", category: "Intuition", color: Color.safePrimary),
        DailyChallenge(icon: "eye.trianglebadge.exclamationmark.fill", title: "Peripheral Vision", description: "While walking, practice noticing things at the edges of your vision without turning your head.", category: "Awareness", color: Color.safeSuccess),
        DailyChallenge(icon: "heart.fill", title: "Breathe & Center", description: "Do 4-7-8 breathing (inhale 4s, hold 7s, exhale 8s) three times. Calm focus keeps you sharp.", category: "Calm", color: Color.safeSecondary),
        DailyChallenge(icon: "person.fill.checkmark", title: "Boundary Practice", description: "Set one small boundary today — decline something you don't want to do and notice how it feels.", category: "Confidence", color: Color.safeAccent),
        DailyChallenge(icon: "flashlight.on.fill", title: "Light Check", description: "Walk your usual evening route and note any poorly lit areas. Consider alternatives for safer paths.", category: "Preparedness", color: Color.safeWarning),
        DailyChallenge(icon: "lock.fill", title: "Lock Down", description: "Change one password today. Use a strong, unique passphrase you haven't used elsewhere.", category: "Digital Safety", color: Color.safeGradientEnd),
        DailyChallenge(icon: "hands.sparkles.fill", title: "Kindness Ripple", description: "Check in on a friend today. Safety is stronger in community.", category: "Connection", color: Color.safePrimary)
    ]
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // Streak card
                    HStack(spacing: 20) {
                        streakStat(value: "\(streak)", label: "Day Streak", icon: "flame.fill", color: Color.safeAccent)
                        streakStat(value: "\(totalCompleted)", label: "Completed", icon: "checkmark.seal.fill", color: Color.safeSuccess)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Today's challenge
                    if let challenge = todayChallenge {
                        VStack(spacing: 0) {
                            // Header
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("TODAY'S CHALLENGE")
                                        .font(.system(size: 11, weight: .bold, design: .rounded))
                                        .foregroundStyle(Color.safeSubtext)
                                        .tracking(1.5)
                                    
                                    Text(challenge.category)
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                        .foregroundStyle(challenge.color)
                                }
                                
                                Spacer()
                                
                                if isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(Color.safeSuccess)
                                }
                            }
                            .padding(18)
                            
                            Divider().background(Color.safeCardBorder)
                            
                            // Content
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(challenge.color.opacity(0.12))
                                        .frame(width: 80, height: 80)
                                    
                                    Image(systemName: challenge.icon)
                                        .font(.system(size: 32, weight: .thin))
                                        .foregroundStyle(challenge.color)
                                }
                                
                                Text(challenge.title)
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.safeText)
                                
                                Text(challenge.description)
                                    .font(.system(size: 15, design: .rounded))
                                    .foregroundStyle(Color.safeSubtext)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                                    .padding(.horizontal, 10)
                            }
                            .padding(18)
                            
                            // Complete button
                            if !isCompleted {
                                Button {
                                    completeChallenge()
                                } label: {
                                    HStack {
                                        Image(systemName: "checkmark.circle")
                                        Text("Mark Complete")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(
                                        LinearGradient(
                                            colors: [challenge.color, challenge.color.opacity(0.7)],
                                            startPoint: .leading, endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(14)
                                }
                                .padding(.horizontal, 18)
                                .padding(.bottom, 18)
                            } else {
                                VStack(spacing: 6) {
                                    Image(systemName: "sparkles")
                                        .font(.title3)
                                        .foregroundStyle(Color.safeSuccess)
                                    
                                    Text("Challenge completed! Come back tomorrow.")
                                        .font(.system(size: 13, design: .rounded))
                                        .foregroundStyle(Color.safeSuccess.opacity(0.8))
                                }
                                .padding(18)
                            }
                        }
                        .glassCard(cornerRadius: 20)
                        .padding(.horizontal, 20)
                    }
                    
                    // Tips section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Why daily challenges?")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeText)
                        
                        tipRow(icon: "brain", text: "Small daily actions build automatic safety habits")
                        tipRow(icon: "chart.line.uptrend.xyaxis", text: "Consistent practice increases awareness over time")
                        tipRow(icon: "shield.fill", text: "Preparation builds real confidence, not just knowledge")
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Daily Challenge")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadChallenge()
        }
    }
    
    private func streakStat(value: String, label: String, icon: String, color: Color) -> some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)
                Text(value)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.safeText)
            }
            Text(label)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(Color.safeSubtext)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .glassCard(cornerRadius: 16)
    }
    
    private func tipRow(icon: String, text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(Color.safeAccent)
                .frame(width: 20)
            Text(text)
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(Color.safeSubtext)
        }
    }
    
    private func loadChallenge() {
        let today = todayString()
        
        if lastChallengeDate == today {
            isCompleted = true
        }
        
        // Use day of year to pick a deterministic challenge
        let dayIndex = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        todayChallenge = challenges[dayIndex % challenges.count]
    }
    
    private func completeChallenge() {
        let today = todayString()
        
        // Check streak
        let yesterday = yesterdayString()
        if lastChallengeDate == yesterday {
            streak += 1
        } else if lastChallengeDate != today {
            streak = 1
        }
        
        lastChallengeDate = today
        totalCompleted += 1
        isCompleted = true
        
        HapticManager.shared.success()
    }
    
    private func todayString() -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: Date())
    }
    
    private func yesterdayString() -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
    }
}
