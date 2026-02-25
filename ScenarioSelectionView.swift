import SwiftUI

struct ScenarioSelectionView: View {
    
    let scenarios = [
        Scenario(
            title: "Walking Alone at Night",
            description: "You're walking home and sense someone following you.",
            icon: "figure.walk",
            difficulty: "Common",
            tips: [
                "Stay on well-lit streets with other people around",
                "Keep your phone charged and easily accessible",
                "Share your live location with a trusted contact",
                "Walk confidently and stay aware of your surroundings",
                "Trust your instincts — if something feels wrong, act on it"
            ]
        ),
        Scenario(
            title: "Cab Ride",
            description: "The driver takes a different route than expected.",
            icon: "car.fill",
            difficulty: "Common",
            tips: [
                "Always share your ride details with someone you trust",
                "Verify the driver's name, car model, and license plate",
                "Sit in the back seat and keep your belongings close",
                "Track the route on your own phone's map",
                "If uncomfortable, ask the driver to stop in a public area"
            ]
        ),
        Scenario(
            title: "Crowded Place",
            description: "You notice someone paying uncomfortable attention to you.",
            icon: "person.3.fill",
            difficulty: "Common",
            tips: [
                "Move toward a group of people or a shop/store",
                "Make eye contact with the person to show you've noticed them",
                "Ask a nearby woman or family for help if needed",
                "Keep your bag in front of you and valuables secured",
                "Report persistent harassment to nearby security or police"
            ]
        ),
        Scenario(
            title: "Elevator with a Stranger",
            description: "You step into an elevator and someone unfamiliar enters too.",
            icon: "arrow.up.arrow.down",
            difficulty: "Moderate",
            tips: [
                "Stand near the buttons so you can exit at any floor",
                "If you feel unsafe, press the next floor and step out",
                "Keep your phone visible — awareness is a deterrent",
                "Trust your gut — it's OK to wait for the next elevator",
                "Avoid looking down at your phone — stay aware"
            ]
        ),
        Scenario(
            title: "Parking Lot",
            description: "You're returning to your car alone in a dimly lit parking area.",
            icon: "car.side.fill",
            difficulty: "Moderate",
            tips: [
                "Have your keys ready before you reach your car",
                "Check around and inside your car before getting in",
                "Park in well-lit areas near exits when possible",
                "If a van is parked next to your car, enter from the other side",
                "Lock the doors immediately once inside"
            ]
        ),
        Scenario(
            title: "Public Transport",
            description: "Late-night bus ride with few passengers.",
            icon: "bus.fill",
            difficulty: "Common",
            tips: [
                "Sit near the driver or in a well-lit section",
                "Stay awake and alert — avoid falling asleep",
                "Keep your belongings close and secure",
                "Note the route number and share it with someone",
                "If someone makes you uncomfortable, move seats or exit"
            ]
        )
    ]
    
    @State private var appeared = false
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // Scenario cards with staggered animation
                    ForEach(Array(scenarios.enumerated()), id: \.element.id) { index, scenario in
                        NavigationLink(destination: ScenarioDetailView(scenario: scenario)) {
                            ScenarioCard(scenario: scenario)
                        }
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 20)
                        .animation(
                            .spring(response: 0.5, dampingFraction: 0.8)
                            .delay(Double(index) * 0.08),
                            value: appeared
                        )
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("Practice Scenarios")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation {
                appeared = true
            }
        }
    }
}
