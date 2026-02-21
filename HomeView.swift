import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var progress: ProgressManager
    @State private var message = AffirmationEngine.get()
    @State private var showContent = false
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good Morning"
        case 12..<17: return "Good Afternoon"
        case 17..<21: return "Good Evening"
        default: return "Stay Safe Tonight"
        }
    }
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            // Background gradient orb
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.safeAccent.opacity(0.08), Color.clear],
                        center: .center,
                        startRadius: 50,
                        endRadius: 300
                    )
                )
                .frame(width: 500, height: 500)
                .offset(y: -100)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // Header
                    HStack(spacing: 12) {
                        Image(systemName: "shield.lefthalf.filled")
                            .font(.system(size: 24, weight: .thin))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.safePrimary, Color.safeAccent],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .accessibilityHidden(true)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(greeting)
                                .font(.system(size: 26, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeText)
                            
                            Text("Keep building your awareness")
                                .font(.caption)
                                .foregroundStyle(Color.safeSubtext)
                        }
                        
                        Spacer()
                        
                        if progress.currentStreak > 0 {
                            VStack(spacing: 2) {
                                Image(systemName: progress.levelIcon)
                                    .font(.body)
                                    .foregroundStyle(Color.safeAccent)
                                Text("\(progress.currentStreak)")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.safeAccent)
                            }
                            .padding(10)
                            .glassCard(cornerRadius: 14)
                            .accessibilityLabel("\(progress.currentStreak) day streak")
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    
                    // Affirmation Card
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundStyle(Color.safeAccent)
                            Text("Today's Thought")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.safeSubtext)
                            Spacer()
                        }
                        
                        Text(message)
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.safeText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(18)
                    .background(
                        LinearGradient(
                            colors: [Color.safeAccent.opacity(0.12), Color.safeGradientEnd.opacity(0.08)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .glassCard(cornerRadius: 20)
                    .padding(.horizontal, 20)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Today's thought: \(message)")
                    
                    // MARK: - 3 HERO FEATURES
                    
                    VStack(spacing: 14) {
                        Text("CORE FEATURES")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                            .tracking(1.5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                        
                        // Hero 1: Practice Scenarios
                        heroCard(
                            icon: "figure.walk",
                            title: "Practice Scenarios",
                            description: "Walk through realistic safety situations and build real-world awareness",
                            gradient: [Color.safeAccent, Color.safeGradientEnd],
                            destination: AnyView(ScenarioSelectionView())
                        )
                        
                        // Hero 2: Safety Quiz
                        heroCard(
                            icon: "brain.head.profile",
                            title: "Safety Quiz",
                            description: "Test your instincts with timed situational awareness challenges",
                            gradient: [Color.safeWarning, Color(red: 0.95, green: 0.55, blue: 0.30)],
                            destination: AnyView(SafetyQuizView())
                        )
                        
                        // Hero 3: Myth or Fact
                        heroCard(
                            icon: "arrow.left.arrow.right",
                            title: "Myth or Fact",
                            description: "Swipe to bust common safety myths and learn the real facts",
                            gradient: [Color(red: 0.65, green: 0.50, blue: 0.85), Color(red: 0.50, green: 0.35, blue: 0.75)],
                            destination: AnyView(SafetyMythView())
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - EXPLORE MORE
                    
                    VStack(spacing: 14) {
                        Text("EXPLORE MORE")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                            .tracking(1.5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                        
                        // Row 1
                        HStack(spacing: 12) {
                            miniFeature(icon: "flag.fill", title: "Red or\nGreen Flag", color: Color.safeAccent, destination: AnyView(RedFlagView()))
                            miniFeature(icon: "calendar.badge.clock", title: "Daily\nChallenge", color: Color(red: 0.35, green: 0.75, blue: 0.85), destination: AnyView(DailyChallengeView()))
                            miniFeature(icon: "figure.stand", title: "Body\nLanguage", color: Color.safeSuccess, destination: AnyView(BodyLanguageView()))
                        }
                        
                        // Row 2
                        HStack(spacing: 12) {
                            miniFeature(icon: "moon.fill", title: "Calm\nMode", color: Color.safeGradientEnd, destination: AnyView(CalmModeView()))
                            miniFeature(icon: "shield.lefthalf.filled", title: "Safety\nPlan", color: Color.safeSecondary, destination: AnyView(SafetyPlanView()))
                            miniFeature(icon: "lightbulb.fill", title: "Safety\nTips", color: Color(red: 1.0, green: 0.72, blue: 0.35), destination: AnyView(SafetyTipsView()))
                        }
                        
                        // Row 3
                        HStack(spacing: 12) {
                            miniFeature(icon: "checkmark.square.fill", title: "Safety\nBingo", color: Color.safePrimary, destination: AnyView(SafetyBingoView()))
                            miniFeature(icon: "phone.fill", title: "Safety\nContacts", color: Color(red: 0.35, green: 0.75, blue: 0.85), destination: AnyView(SafetyContactsView()))
                            miniFeature(icon: "book.fill", title: "My\nReflections", color: Color.safeGradientEnd, destination: AnyView(ReflectionHistoryView()))
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Achievements
                    NavigationLink {
                        AchievementsView()
                    } label: {
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(Color.safeWarning.opacity(0.15))
                                    .frame(width: 42, height: 42)
                                
                                Image(systemName: "trophy.fill")
                                    .font(.body)
                                    .foregroundStyle(Color.safeWarning)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Achievements")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color.safeText)
                                
                                Text("Track your badges and milestones")
                                    .font(.caption)
                                    .foregroundStyle(Color.safeSubtext)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(Color.safeSubtext)
                        }
                        .padding(14)
                        .glassCard(cornerRadius: 16)
                    }
                    .accessibilityLabel("Achievements, track your badges and milestones")
                    .padding(.horizontal, 20)
                    
                    // Progress bar
                    NavigationLink {
                        SafeProgressView()
                    } label: {
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(Color.safeSuccess.opacity(0.15))
                                    .frame(width: 42, height: 42)
                                
                                Image(systemName: "chart.bar.fill")
                                    .font(.body)
                                    .foregroundStyle(Color.safeSuccess)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("My Progress")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color.safeText)
                                
                                Text("\(progress.totalSessions) sessions completed")
                                    .font(.caption)
                                    .foregroundStyle(Color.safeSubtext)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(Color.safeSubtext)
                        }
                        .padding(14)
                        .glassCard(cornerRadius: 16)
                    }
                    .accessibilityLabel("My progress, \(progress.totalSessions) sessions completed")
                    .padding(.horizontal, 20)
                    
                    // About link
                    NavigationLink {
                        AboutView()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "info.circle")
                                .font(.caption)
                            Text("About SafeHer")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                        }
                        .foregroundStyle(Color.safeSubtext.opacity(0.6))
                    }
                    .padding(.bottom, 40)
                }
                .padding(.top, 10)
            }
        }
        .navigationBarHidden(true)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("refreshAffirmation"))) { _ in
            message = AffirmationEngine.get()
        }
    }
    
    // MARK: - Hero Card
    
    private func heroCard(icon: String, title: String, description: String, gradient: [Color], destination: AnyView) -> some View {
        NavigationLink {
            destination
        } label: {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .light))
                        .foregroundStyle(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                    
                    Text(description)
                        .font(.system(size: 13, design: .rounded))
                        .foregroundStyle(Color.safeSubtext)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(Color.safeSubtext)
            }
            .padding(16)
            .background(
                LinearGradient(
                    colors: [gradient[0].opacity(0.08), gradient[1].opacity(0.04)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .glassCard(cornerRadius: 20)
        }
        .accessibilityLabel("\(title). \(description)")
    }
    
    // MARK: - Mini Feature
    
    private func miniFeature(icon: String, title: String, color: Color, destination: AnyView) -> some View {
        NavigationLink {
            destination
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(color)
                
                Text(title)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.safeSubtext)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .glassCard(cornerRadius: 14)
        }
        .accessibilityLabel(title.replacingOccurrences(of: "\n", with: " "))
    }
}
