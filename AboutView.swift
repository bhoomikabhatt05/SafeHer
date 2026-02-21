import SwiftUI

struct AboutView: View {
    
    @State private var showHeart = false
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // App icon + name
                    VStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [Color.safeAccent.opacity(0.15), Color.clear],
                                        center: .center,
                                        startRadius: 10,
                                        endRadius: 60
                                    )
                                )
                                .frame(width: 110, height: 110)
                            
                            Image(systemName: "shield.lefthalf.filled")
                                .font(.system(size: 44, weight: .thin))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.safePrimary, Color.safeAccent],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .shadow(color: Color.safeAccent.opacity(0.3), radius: 10)
                        }
                        
                        Text("SafeHer")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.safePrimary, Color.safeAccent],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("Awareness builds confidence")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                        
                        Text("Version 1.0")
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundStyle(Color.safeSubtext.opacity(0.5))
                    }
                    .padding(.top, 20)
                    
                    // Mission
                    VStack(alignment: .leading, spacing: 12) {
                        sectionHeader(icon: "heart.fill", title: "Our Mission", color: Color.safeAccent)
                        
                        Text("SafeHer empowers women and girls with the awareness, knowledge, and confidence to navigate the world safely. Through interactive scenarios, quizzes, and daily practices, we believe that preparation — not fear — is the key to personal safety.")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                            .lineSpacing(4)
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // Features
                    VStack(alignment: .leading, spacing: 12) {
                        sectionHeader(icon: "sparkles", title: "Features", color: Color.safeWarning)
                        
                        featureRow(icon: "figure.walk", text: "Interactive safety scenarios")
                        featureRow(icon: "questionmark.circle.fill", text: "Timed safety knowledge quiz")
                        featureRow(icon: "arrow.left.arrow.right", text: "Myth vs Fact swipe game")
                        featureRow(icon: "calendar.badge.clock", text: "Daily safety challenges")
                        featureRow(icon: "figure.stand", text: "Body language confidence guide")
                        featureRow(icon: "shield.lefthalf.filled", text: "Personal emergency safety plan")
                        featureRow(icon: "moon.fill", text: "Calm mode with guided breathing")
                        featureRow(icon: "pencil.and.outline", text: "Personal reflection journal")
                        featureRow(icon: "chart.bar.fill", text: "Progress & streak tracking")
                        featureRow(icon: "lightbulb.fill", text: "Curated safety tips")
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // Accessibility
                    VStack(alignment: .leading, spacing: 12) {
                        sectionHeader(icon: "accessibility", title: "Accessibility", color: Color.safeSuccess)
                        
                        Text("SafeHer is designed to be accessible to everyone:")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                        
                        featureRow(icon: "voiceover", text: "Full VoiceOver support")
                        featureRow(icon: "textformat.size", text: "Dynamic Type support")
                        featureRow(icon: "hand.tap.fill", text: "Haptic feedback for interactions")
                        featureRow(icon: "paintpalette.fill", text: "High contrast color design")
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // Tech
                    VStack(alignment: .leading, spacing: 12) {
                        sectionHeader(icon: "swift", title: "Built With", color: Color(red: 0.95, green: 0.45, blue: 0.25))
                        
                        featureRow(icon: "swift", text: "100% SwiftUI — no third-party dependencies")
                        featureRow(icon: "iphone.gen3", text: "Runs entirely offline")
                        featureRow(icon: "lock.fill", text: "All data stored locally on device")
                        featureRow(icon: "cpu", text: "Lightweight — under 1MB")
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // Made with love
                    VStack(spacing: 8) {
                        HStack(spacing: 6) {
                            Text("Made with")
                                .font(.system(size: 13, design: .rounded))
                                .foregroundStyle(Color.safeSubtext)
                            
                            Image(systemName: "heart.fill")
                                .font(.caption)
                                .foregroundStyle(Color.safeAccent)
                                .scaleEffect(showHeart ? 1.2 : 1.0)
                            
                            Text("for Swift Student Challenge 2025")
                                .font(.system(size: 13, design: .rounded))
                                .foregroundStyle(Color.safeSubtext)
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                showHeart = true
            }
        }
    }
    
    private func sectionHeader(icon: String, title: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundStyle(color)
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(Color.safeText)
        }
    }
    
    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(Color.safeAccent)
                .frame(width: 20)
            Text(text)
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(Color.safeSubtext)
        }
        .padding(.vertical, 2)
    }
}
