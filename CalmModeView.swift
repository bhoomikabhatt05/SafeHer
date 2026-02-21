import SwiftUI

struct CalmModeView: View {
    
    @State private var phase: BreathingOrb.BreathPhase = .inhale
    @State private var cycleCount = 0
    @State private var timer: Timer?
    
    let phaseDuration: TimeInterval = 4.0
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            // Ambient background glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color.safeGradientEnd.opacity(0.06), Color.clear],
                        center: .center,
                        startRadius: 30,
                        endRadius: 250
                    )
                )
                .frame(width: 500, height: 500)
            
            VStack(spacing: 0) {
                
                Spacer()
                
                // Breathing Orb
                BreathingOrb(phase: $phase)
                
                Spacer()
                    .frame(height: 50)
                
                // Phase instruction text — BELOW the orb
                VStack(spacing: 10) {
                    Text(phase.rawValue)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safePrimary)
                        .contentTransition(.numericText())
                        .animation(.easeInOut(duration: 0.5), value: phase)
                    
                    Text(phaseSubtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color.safeSubtext)
                        .animation(.easeInOut(duration: 0.5), value: phase)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Breathing phase: \(phase.rawValue). \(phaseSubtitle)")
                
                Spacer()
                    .frame(height: 30)
                
                // Cycle counter
                if cycleCount > 0 {
                    HStack(spacing: 6) {
                        Image(systemName: "wind")
                            .foregroundStyle(Color.safeAccent)
                        Text("\(cycleCount) breath\(cycleCount == 1 ? "" : "s") completed")
                            .font(.caption)
                            .foregroundStyle(Color.safeSubtext)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .glassCard(cornerRadius: 12)
                    .accessibilityLabel("\(cycleCount) breathing cycles completed")
                }
                
                Spacer()
                
                // Tip
                Text("Focus on the orb and match your breathing")
                    .font(.caption)
                    .foregroundStyle(Color.safeSubtext.opacity(0.6))
                    .padding(.bottom, 30)
            }
        }
        .navigationTitle("Calm Mode")
        .onAppear(perform: startBreathingCycle)
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private var phaseSubtitle: String {
        switch phase {
        case .inhale: return "Fill your lungs slowly..."
        case .hold: return "Hold it gently..."
        case .exhale: return "Release slowly..."
        }
    }
    
    private func startBreathingCycle() {
        timer = Timer.scheduledTimer(withTimeInterval: phaseDuration, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.6)) {
                switch phase {
                case .inhale:
                    phase = .hold
                    HapticManager.shared.impact()
                case .hold:
                    phase = .exhale
                    HapticManager.shared.impact()
                case .exhale:
                    phase = .inhale
                    cycleCount += 1
                    HapticManager.shared.success()
                }
            }
        }
    }
}
