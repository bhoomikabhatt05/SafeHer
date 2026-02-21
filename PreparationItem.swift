import Foundation

struct PreparationItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isEssential: Bool
    var usageCount: Int = 0
}

