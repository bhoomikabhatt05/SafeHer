import SwiftUI

struct OnBoardingView: View {
    
    @EnvironmentObject var userState: UserStateManager
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            // Subtle animated background
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.safeAccent.opacity(0.08), Color.clear],
                        center: .center,
                        startRadius: 30,
                        endRadius: 250
                    )
                )
                .frame(width: 500, height: 500)
                .offset(y: -80)
                .blur(radius: 40)
            
            VStack(spacing: 0) {
                
                TabView(selection: $currentPage) {
                    // Page 1
                    onboardingPage(
                        icon: "shield.lefthalf.filled",
                        title: "Welcome to SafeHer",
                        subtitle: "A safe space to practice awareness\nand build confidence for real situations.",
                        color: Color.safePrimary
                    ).tag(0)
                    
                    // Page 2
                    onboardingPage(
                        icon: "eye.fill",
                        title: "Awareness First",
                        subtitle: "Train your mind to notice potential dangers\nearly and respond with calm clarity.",
                        color: Color.safeAccent
                    ).tag(1)
                    
                    // Page 3
                    onboardingPage(
                        icon: "hand.raised.fill",
                        title: "Practice Makes Prepared",
                        subtitle: "Walk through realistic scenarios, reflect\non your responses, and grow stronger.",
                        color: Color.safeSecondary
                    ).tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.4), value: currentPage)
                
                // Custom page dots
                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { i in
                        Capsule()
                            .fill(i == currentPage ? Color.safeAccent : Color.white.opacity(0.2))
                            .frame(width: i == currentPage ? 24 : 8, height: 8)
                            .animation(.spring(response: 0.4), value: currentPage)
                    }
                }
                .padding(.bottom, 30)
                
                // Button
                Button(action: nextAction) {
                    HStack {
                        Text(currentPage == 2 ? "Get Started" : "Continue")
                            .font(.headline)
                        
                        Image(systemName: currentPage == 2 ? "arrow.right" : "chevron.right")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            colors: [Color.safeAccent, Color.safeGradientEnd],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                    .shadow(color: Color.safeAccent.opacity(0.3), radius: 12, y: 6)
                }
                .accessibilityLabel(currentPage == 2 ? "Get started with SafeHer" : "Continue to next page")
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
    }
    
    private func onboardingPage(icon: String, title: String, subtitle: String, color: Color) -> some View {
        VStack(spacing: 28) {
            Spacer()
            
            // Premium icon treatment
            ZStack {
                // Soft glow behind
                Circle()
                    .fill(color.opacity(0.12))
                    .frame(width: 160, height: 160)
                    .blur(radius: 30)
                
                // Glassmorphic circle
                Circle()
                    .fill(.ultraThinMaterial.opacity(0.15))
                    .frame(width: 110, height: 110)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [color.opacity(0.4), color.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                
                Image(systemName: icon)
                    .font(.system(size: 44, weight: .thin))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [color, color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: color.opacity(0.3), radius: 8)
            }
            .accessibilityHidden(true)
            
            Text(title)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(Color.safeText)
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(.body)
                .foregroundStyle(Color.safeSubtext)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 40)
            
            Spacer()
            Spacer()
        }
        .accessibilityElement(children: .combine)
    }
    
    private func nextAction() {
        if currentPage < 2 {
            withAnimation {
                currentPage += 1
            }
        } else {
            userState.hasSeenOnboarding = true
        }
        HapticManager.shared.impact()
    }
}
