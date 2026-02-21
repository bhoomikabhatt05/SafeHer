import SwiftUI

struct BreathingOrb: View {
    
    @Binding var phase: BreathPhase
    @State private var animate = false
    
    enum BreathPhase: String {
        case inhale = "Inhale"
        case hold = "Hold"
        case exhale = "Exhale"
    }
    
    var body: some View {
        ZStack {
            // Outermost soft glow
            Circle()
                .fill(Color.safeGradientEnd.opacity(0.12))
                .frame(width: 280, height: 280)
                .blur(radius: 50)
                .scaleEffect(animate ? 1.3 : 0.7)
            
            // Middle glow ring
            Circle()
                .fill(Color.safeAccent.opacity(0.18))
                .frame(width: 220, height: 220)
                .blur(radius: 35)
                .scaleEffect(animate ? 1.2 : 0.8)
            
            // Inner orb
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.safePrimary.opacity(0.9),
                            Color.safeAccent,
                            Color.safeGradientEnd.opacity(0.6)
                        ],
                        center: .center,
                        startRadius: 5,
                        endRadius: 90
                    )
                )
                .frame(width: 150, height: 150)
                .scaleEffect(animate ? 1.15 : 0.85)
                .shadow(color: Color.safeAccent.opacity(0.4), radius: 20)
            
            // Inner light core
            Circle()
                .fill(Color.white.opacity(0.15))
                .frame(width: 60, height: 60)
                .blur(radius: 10)
                .scaleEffect(animate ? 1.1 : 0.9)
        }
        .accessibilityLabel("Breathing orb, currently \(phase.rawValue)")
        .animation(
            .easeInOut(duration: 4)
            .repeatForever(autoreverses: true),
            value: animate
        )
        .onAppear {
            animate = true
        }
    }
}
