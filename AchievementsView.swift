import SwiftUI

struct AchievementsView: View {
    
    @EnvironmentObject var progress: ProgressManager
    @AppStorage("challengesCompleted") private var challengesCompleted: Int = 0
    @AppStorage("challengeStreak") private var streak: Int = 0
    
    private var badges: [(icon: String, title: String, description: String, color: Color, unlocked: Bool)] {
        [
            ("figure.walk", "First Steps", "Complete your first scenario", Color.safeAccent, progress.totalSessions >= 1),
            ("star.fill", "Rising Star", "Complete 5 scenarios", Color.safeWarning, progress.totalSessions >= 5),
            ("flame.fill", "On Fire", "Reach a 3-day streak", Color.safeAccent, progress.currentStreak >= 3),
            ("bolt.fill", "Unstoppable", "Reach a 7-day streak", Color(red: 1.0, green: 0.72, blue: 0.35), progress.currentStreak >= 7),
            ("calendar.badge.clock", "Challenger", "Complete 3 daily challenges", Color(red: 0.35, green: 0.75, blue: 0.85), challengesCompleted >= 3),
            ("trophy.fill", "Champion", "Complete 10 daily challenges", Color.safeWarning, challengesCompleted >= 10),
            ("brain.head.profile", "Quick Thinker", "Complete 10 scenarios", Color.safePrimary, progress.totalSessions >= 10),
            ("shield.fill", "Safety Expert", "Complete 25 scenarios", Color.safeSuccess, progress.totalSessions >= 25),
            ("crown.fill", "Legend", "Reach a 30-day streak", Color(red: 0.65, green: 0.50, blue: 0.85), progress.currentStreak >= 30)
        ]
    }
    
    private var unlockedCount: Int {
        badges.filter { $0.unlocked }.count
    }
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // Summary
                    VStack(spacing: 6) {
                        Text("\(unlockedCount) of \(badges.count)")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeText)
                        
                        Text("achievements unlocked")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                        
                        // Progress bar
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white.opacity(0.08))
                                    .frame(height: 6)
                                
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.safeAccent, Color.safeWarning],
                                            startPoint: .leading, endPoint: .trailing
                                        )
                                    )
                                    .frame(width: geo.size.width * CGFloat(unlockedCount) / CGFloat(badges.count), height: 6)
                            }
                        }
                        .frame(height: 6)
                        .padding(.horizontal, 40)
                        .padding(.top, 8)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 4)
                    
                    // Badges
                    ForEach(Array(badges.enumerated()), id: \.offset) { _, badge in
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(badge.unlocked ? badge.color.opacity(0.15) : Color.white.opacity(0.03))
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: badge.icon)
                                    .font(.system(size: 22))
                                    .foregroundStyle(badge.unlocked ? badge.color : Color.safeSubtext.opacity(0.3))
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(badge.title)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundStyle(badge.unlocked ? Color.safeText : Color.safeSubtext.opacity(0.4))
                                
                                Text(badge.description)
                                    .font(.system(size: 13, design: .rounded))
                                    .foregroundStyle(badge.unlocked ? Color.safeSubtext : Color.safeSubtext.opacity(0.3))
                            }
                            
                            Spacer()
                            
                            if badge.unlocked {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.safeSuccess)
                            } else {
                                Image(systemName: "lock.fill")
                                    .font(.caption)
                                    .foregroundStyle(Color.safeSubtext.opacity(0.2))
                            }
                        }
                        .padding(14)
                        .glassCard(cornerRadius: 16)
                        .padding(.horizontal, 20)
                        .opacity(badge.unlocked ? 1 : 0.6)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationTitle("Achievements")
        .navigationBarTitleDisplayMode(.inline)
    }
}
