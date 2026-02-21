import SwiftUI

extension Color {
    
    // Background — deep dark with slight warmth
    static let safeBackground = Color(red: 0.06, green: 0.05, blue: 0.07)
    
    // Primary brand — warm peach (from logo)
    static let safePrimary = Color(red: 0.96, green: 0.78, blue: 0.73)
    
    // Accent — deeper rose (from logo hands)
    static let safeAccent = Color(red: 0.90, green: 0.55, blue: 0.52)
    
    // Secondary — soft blush pink (from logo face area)
    static let safeSecondary = Color(red: 0.85, green: 0.63, blue: 0.60)
    
    // Cards — glassmorphic
    static let safeCard = Color.white.opacity(0.07)
    static let safeCardBorder = Color.white.opacity(0.10)
    
    // Text
    static let safeText = Color.white
    static let safeSubtext = Color.white.opacity(0.6)
    
    // Gradient endpoints — warm rose to deeper mauve
    static let safeGradientStart = Color(red: 0.90, green: 0.55, blue: 0.52)
    static let safeGradientEnd = Color(red: 0.70, green: 0.38, blue: 0.55)
    
    // Status colors
    static let safeSuccess = Color(red: 0.40, green: 0.82, blue: 0.65)
    static let safeWarning = Color(red: 1.0, green: 0.80, blue: 0.40)
}

// MARK: - Glassmorphic Card Modifier

struct GlassCard: ViewModifier {
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial.opacity(0.3))
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.safeCard)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.safeCardBorder, lineWidth: 1)
            )
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 20) -> some View {
        modifier(GlassCard(cornerRadius: cornerRadius))
    }
}
