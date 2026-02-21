import SwiftUI

struct SafetyTipsView: View {
    
    @State private var expandedCategory: String?
    
    private let categories: [(icon: String, title: String, color: Color, tips: [String])] = [
        (
            "figure.walk",
            "Walking & Commuting",
            Color.safeAccent,
            [
                "Stay on well-lit, populated streets whenever possible",
                "Keep your phone charged and easily accessible",
                "Share your live location with a trusted contact",
                "Avoid wearing headphones in both ears — stay alert",
                "Walk confidently and with purpose"
            ]
        ),
        (
            "car.fill",
            "Rides & Transport",
            Color.safePrimary,
            [
                "Always verify the driver, car model, and license plate",
                "Share ride details with a friend or family member",
                "Sit in the back seat and keep your hand near the door",
                "Track the route on your own phone's map app",
                "If something feels wrong, ask to stop at a public place"
            ]
        ),
        (
            "person.3.fill",
            "Public Spaces",
            Color.safeSecondary,
            [
                "Stay aware of who is around you at all times",
                "Keep your bag in front of you in crowded areas",
                "Trust your intuition — if it feels wrong, leave",
                "Identify exit points when entering a new space",
                "Don't hesitate to ask for help from staff or security"
            ]
        ),
        (
            "iphone",
            "Digital Safety",
            Color.safeWarning,
            [
                "Don't share your real-time location on social media",
                "Use strong, unique passwords for every account",
                "Be cautious about meeting people from online",
                "Review app permissions for location access regularly",
                "Keep emergency contacts on your lock screen"
            ]
        ),
        (
            "house.fill",
            "Home Safety",
            Color.safeSuccess,
            [
                "Always lock doors and windows, even when home",
                "Don't open the door for unexpected visitors",
                "Keep a charged phone near your bed at night",
                "Know your neighbors — community matters",
                "Have an emergency plan and share it with family"
            ]
        )
    ]
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // Header
                    VStack(spacing: 6) {
                        Text("Safety Tips")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeText)
                        
                        Text("Quick reference for staying safe")
                            .font(.subheadline)
                            .foregroundStyle(Color.safeSubtext)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 6)
                    
                    // Categories
                    ForEach(categories, id: \.title) { category in
                        categoryCard(category)
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    private func categoryCard(_ category: (icon: String, title: String, color: Color, tips: [String])) -> some View {
        VStack(spacing: 0) {
            // Header
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    if expandedCategory == category.title {
                        expandedCategory = nil
                    } else {
                        expandedCategory = category.title
                    }
                }
                HapticManager.shared.impact()
            } label: {
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(category.color.opacity(0.15))
                            .frame(width: 42, height: 42)
                        
                        Image(systemName: category.icon)
                            .font(.body)
                            .foregroundStyle(category.color)
                    }
                    
                    Text(category.title)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                    
                    Spacer()
                    
                    Image(systemName: expandedCategory == category.title ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundStyle(Color.safeSubtext)
                }
                .padding(16)
            }
            
            // Expanded tips
            if expandedCategory == category.title {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(category.tips.enumerated()), id: \.offset) { index, tip in
                        HStack(alignment: .top, spacing: 10) {
                            Circle()
                                .fill(category.color.opacity(0.6))
                                .frame(width: 6, height: 6)
                                .padding(.top, 6)
                            
                            Text(tip)
                                .font(.subheadline)
                                .foregroundStyle(Color.safeSubtext)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .glassCard(cornerRadius: 18)
    }
}
