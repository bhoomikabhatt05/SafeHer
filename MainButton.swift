import SwiftUI

struct MainButton: ButtonStyle {
    var fullWidth: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .padding(.vertical, 14)
            .padding(.horizontal, fullWidth ? 0 : 28)
            .background(
                LinearGradient(
                    colors: [Color.safeAccent, Color.safeGradientEnd],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .shadow(color: Color.safeAccent.opacity(configuration.isPressed ? 0.1 : 0.25),
                    radius: configuration.isPressed ? 4 : 10,
                    y: configuration.isPressed ? 2 : 5)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
            .padding(.horizontal, fullWidth ? 24 : 0)
    }
}
