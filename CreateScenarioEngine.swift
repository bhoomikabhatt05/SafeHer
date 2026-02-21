import Foundation

struct ScenarioEngine {
    
    static let allScenarios = [
        "Walking Alone at Night",
        "Cab Ride",
        "Crowded Place",
        "Elevator with a Stranger",
        "Parking Lot",
        "Public Transport"
    ]
    
    static func random() -> String {
        allScenarios.randomElement() ?? "Walking Alone at Night"
    }
}
