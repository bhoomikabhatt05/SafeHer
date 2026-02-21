import SwiftUI

/// A SwiftUI-drawn logo that matches the SafeHer brand
/// (two cupping hands with a woman's silhouette in peach/rose tones).
/// This does NOT depend on the asset catalog, so it always renders.
struct AppLogo: View {
    
    var size: CGFloat = 100
    
    private var scale: CGFloat { size / 100 }
    
    var body: some View {
        ZStack {
            // Outer circle — soft peach background
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.96, green: 0.80, blue: 0.76),
                            Color(red: 0.93, green: 0.70, blue: 0.66)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size, height: size)
            
            // Inner face silhouette shape — deeper rose
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.88, green: 0.55, blue: 0.50),
                            Color(red: 0.82, green: 0.48, blue: 0.45)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size * 0.42, height: size * 0.55)
                .offset(y: -size * 0.02)
            
            // White flowing accent line (like the logo's white curves)
            Capsule()
                .fill(Color.white.opacity(0.5))
                .frame(width: size * 0.08, height: size * 0.45)
                .rotationEffect(.degrees(-20))
                .offset(x: -size * 0.08, y: -size * 0.05)
            
            Capsule()
                .fill(Color.white.opacity(0.35))
                .frame(width: size * 0.06, height: size * 0.30)
                .rotationEffect(.degrees(15))
                .offset(x: size * 0.10, y: size * 0.02)
            
            // Bottom cupping hands shape — two arcs
            // Left hand
            Circle()
                .trim(from: 0.5, to: 0.85)
                .stroke(
                    Color(red: 0.96, green: 0.78, blue: 0.76),
                    style: StrokeStyle(lineWidth: size * 0.10, lineCap: .round)
                )
                .frame(width: size * 0.75, height: size * 0.75)
                .offset(x: -size * 0.08, y: size * 0.18)
            
            // Right hand
            Circle()
                .trim(from: 0.15, to: 0.5)
                .stroke(
                    Color(red: 0.96, green: 0.78, blue: 0.76),
                    style: StrokeStyle(lineWidth: size * 0.10, lineCap: .round)
                )
                .frame(width: size * 0.75, height: size * 0.75)
                .offset(x: size * 0.08, y: size * 0.18)
        }
        .frame(width: size, height: size * 1.3)
        .accessibilityLabel("SafeHer logo")
    }
}
