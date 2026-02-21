import Foundation

struct ReflectionEntry: Identifiable, Codable {
    let id: UUID
    let scenario: String
    let text: String
    let date: Date
    
    init(scenario: String, text: String) {
        self.id = UUID()
        self.scenario = scenario
        self.text = text
        self.date = Date()
    }
}
