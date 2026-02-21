import SwiftUI

struct CompletionView: View {
    
    @EnvironmentObject var progress: ProgressManager
    @Environment(\.dismiss) private var dismiss
    
    let scenario: String
    let reflection: String
    
    @State private var showContent = false
    @State private var particles: [Particle] = []
    
    struct Particle: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var size: CGFloat
        var color: Color
        var opacity: Double
    }
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            // Celebration particles
            ForEach(particles) { p in
                Circle()
                    .fill(p.color)
                    .frame(width: p.size, height: p.size)
                    .position(x: p.x, y: p.y)
                    .opacity(p.opacity)
            }
            
            VStack(spacing: 24) {
                
                Spacer()
                
                // Success icon
                ZStack {
                    Circle()
                        .fill(Color.safeSuccess.opacity(0.12))
                        .frame(width: 120, height: 120)
                        .blur(radius: 20)
                    
                    Circle()
                        .fill(Color.safeSuccess.opacity(0.2))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(Color.safeSuccess)
                }
                .scaleEffect(showContent ? 1.0 : 0.5)
                .opacity(showContent ? 1.0 : 0.0)
                .accessibilityLabel("Session complete")
                
                Text("Well Done!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.safeText)
                    .opacity(showContent ? 1.0 : 0.0)
                
                Text("You practiced awareness for\n\"\(scenario)\"")
                    .font(.body)
                    .foregroundStyle(Color.safeSubtext)
                    .multilineTextAlignment(.center)
                    .opacity(showContent ? 1.0 : 0.0)
                
                // Motivational quote
                Text(AffirmationEngine.get())
                    .font(.callout.italic())
                    .foregroundStyle(Color.safePrimary.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .opacity(showContent ? 1.0 : 0.0)
                
                Spacer()
                
                // Action buttons
                VStack(spacing: 12) {
                    NavigationLink("Practice Another") {
                        ScenarioSelectionView()
                    }
                    .buttonStyle(MainButton())
                    
                    Button("Back to Home") {
                        dismiss()
                    }
                    .font(.headline)
                    .foregroundStyle(Color.safeSubtext)
                    .padding(.bottom, 20)
                }
                .opacity(showContent ? 1.0 : 0.0)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            ReflectionStorage.save(scenario: scenario, text: reflection)
            progress.recordSession()
            HapticManager.shared.success()
            
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                showContent = true
            }
            
            spawnParticles()
        }
    }
    
    private func spawnParticles() {
        let colors: [Color] = [.safePrimary, .safeAccent, .safeSuccess, .safeWarning, .safeGradientEnd]
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0..<30 {
            let particle = Particle(
                x: CGFloat.random(in: 20...screenWidth - 20),
                y: CGFloat.random(in: 50...screenHeight / 2),
                size: CGFloat.random(in: 4...10),
                color: colors.randomElement() ?? .safeAccent,
                opacity: Double.random(in: 0.3...0.8)
            )
            particles.append(particle)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 1.5)) {
                particles = particles.map { p in
                    var newP = p
                    newP.opacity = 0
                    return newP
                }
            }
        }
    }
}
