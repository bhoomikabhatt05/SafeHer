import Foundation

struct Scenario: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let difficulty: String
    let tips: [String]
}
