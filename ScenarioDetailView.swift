import SwiftUI

struct ScenarioDetailView: View {
    
    let scenario: Scenario
    @State private var showTips = false
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // Hero icon
                    ZStack {
                        Circle()
                            .fill(Color.safeAccent.opacity(0.10))
                            .frame(width: 120, height: 120)
                            .blur(radius: 20)
                        
                        Circle()
                            .fill(Color.safeAccent.opacity(0.15))
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: scenario.icon)
                            .font(.system(size: 36))
                            .foregroundStyle(Color.safeAccent)
                    }
                    .padding(.top, 20)
                    .accessibilityHidden(true)
                    
                    // Title & description
                    VStack(spacing: 8) {
                        Text(scenario.title)
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeText)
                            .multilineTextAlignment(.center)
                        
                        Text(scenario.description)
                            .font(.body)
                            .foregroundStyle(Color.safeSubtext)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    
                    // Difficulty badge
                    HStack(spacing: 6) {
                        Circle()
                            .fill(scenario.difficulty == "Moderate" ? Color.safeWarning : Color.safeSuccess)
                            .frame(width: 8, height: 8)
                        Text(scenario.difficulty)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(scenario.difficulty == "Moderate" ? Color.safeWarning : Color.safeSuccess)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .glassCard(cornerRadius: 12)
                    .accessibilityLabel("Difficulty: \(scenario.difficulty)")
                    
                    // Tips section
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                                .foregroundStyle(Color.safeWarning)
                            Text("Safety Tips")
                                .font(.headline)
                                .foregroundStyle(Color.safeText)
                        }
                        
                        ForEach(Array(scenario.tips.enumerated()), id: \.offset) { index, tip in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(index + 1)")
                                    .font(.system(size: 13, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.safeAccent)
                                    .frame(width: 24, height: 24)
                                    .background(Color.safeAccent.opacity(0.12))
                                    .cornerRadius(8)
                                
                                Text(tip)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.safeSubtext)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .opacity(showTips ? 1 : 0)
                            .offset(x: showTips ? 0 : -15)
                            .animation(
                                .spring(response: 0.4, dampingFraction: 0.7)
                                .delay(Double(index) * 0.06),
                                value: showTips
                            )
                        }
                    }
                    .padding(18)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // CTA
                    NavigationLink("Start Reflection") {
                        ReflectionView(scenario: scenario.title)
                    }
                    .buttonStyle(MainButton())
                    .padding(.top, 8)
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .onAppear {
            HapticManager.shared.impact()
            withAnimation {
                showTips = true
            }
        }
    }
}
