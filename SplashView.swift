import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var userState: UserStateManager
    
    @State private var showIcon = false
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var ringRotation: Double = 0
    @State private var pulseScale: CGFloat = 0.8
    @State private var navigateNext = false
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            // Animated background orbs
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.safeAccent.opacity(0.15), Color.clear],
                        center: .center,
                        startRadius: 30,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .offset(x: -50, y: -120)
                .blur(radius: 60)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.safeGradientEnd.opacity(0.10), Color.clear],
                        center: .center,
                        startRadius: 20,
                        endRadius: 180
                    )
                )
                .frame(width: 350, height: 350)
                .offset(x: 60, y: 100)
                .blur(radius: 50)
            
            VStack(spacing: 24) {
                Spacer()
                
                // Premium animated icon
                ZStack {
                    // Outer pulsing ring
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.safePrimary.opacity(0.3), Color.safeAccent.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                        .frame(width: 140, height: 140)
                        .scaleEffect(pulseScale)
                    
                    // Rotating orbit ring
                    Circle()
                        .trim(from: 0, to: 0.3)
                        .stroke(
                            LinearGradient(
                                colors: [Color.safeAccent, Color.safeAccent.opacity(0)],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            style: StrokeStyle(lineWidth: 2, lineCap: .round)
                        )
                        .frame(width: 130, height: 130)
                        .rotationEffect(.degrees(ringRotation))
                    
                    // Inner glow circle
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.safeAccent.opacity(0.15),
                                    Color.safeGradientEnd.opacity(0.05),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 10,
                                endRadius: 50
                            )
                        )
                        .frame(width: 100, height: 100)
                    
                    // Shield icon
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.system(size: 48, weight: .thin))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.safePrimary, Color.safeAccent],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: Color.safeAccent.opacity(0.3), radius: 12)
                }
                .scaleEffect(showIcon ? 1.0 : 0.3)
                .opacity(showIcon ? 1.0 : 0.0)
                .accessibilityLabel("SafeHer app icon")
                
                VStack(spacing: 8) {
                    Text("SafeHer")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.safePrimary, Color.safeAccent],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .opacity(showTitle ? 1.0 : 0.0)
                        .offset(y: showTitle ? 0 : 15)
                    
                    Text("Awareness builds confidence")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.safeSubtext)
                        .opacity(showSubtitle ? 1.0 : 0.0)
                        .offset(y: showSubtitle ? 0 : 8)
                }
                
                Spacer()
                
                // Bottom indicator
                HStack(spacing: 6) {
                    ForEach(0..<3, id: \.self) { i in
                        Circle()
                            .fill(Color.safeAccent.opacity(0.4))
                            .frame(width: 4, height: 4)
                            .scaleEffect(showSubtitle ? 1 : 0)
                            .animation(.spring(response: 0.5).delay(Double(i) * 0.1 + 1.2), value: showSubtitle)
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                showIcon = true
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
                showTitle = true
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.6)) {
                showSubtitle = true
            }
            withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                ringRotation = 360
            }
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                pulseScale = 1.1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                navigateNext = true
            }
        }
        .fullScreenCover(isPresented: $navigateNext) {
            if userState.hasSeenOnboarding {
                NavigationStack {
                    HomeView()
                }
            } else {
                OnBoardingView()
            }
        }
    }
}
