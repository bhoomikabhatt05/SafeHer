import SwiftUI

struct BrandHeader: View {
    
    var large: Bool = true
    
    var body: some View {
        VStack(spacing: large ? 10 : 6) {
            
            // Premium icon with glow
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.safeAccent.opacity(0.12), Color.clear],
                            center: .center,
                            startRadius: 10,
                            endRadius: large ? 50 : 30
                        )
                    )
                    .frame(width: large ? 90 : 50, height: large ? 90 : 50)
                
                Image(systemName: "shield.lefthalf.filled")
                    .font(.system(size: large ? 36 : 20, weight: .thin))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.safePrimary, Color.safeAccent],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(color: Color.safeAccent.opacity(0.3), radius: 8)
            }
            .accessibilityLabel("SafeHer icon")
            
            Text("SafeHer")
                .font(.system(size: large ? 34 : 22,
                              weight: .bold,
                              design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.safePrimary, Color.safeAccent],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .tracking(0.6)
        }
    }
}
