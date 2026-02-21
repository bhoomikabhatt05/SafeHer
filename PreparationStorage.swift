import Foundation

class PreparationStorage {
    
    static let shared = PreparationStorage()
    private let key = "safeher_preparation_items"
    
    func load() -> [PreparationItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([PreparationItem].self, from: data)
        else { return [] }
        
        return decoded
    }
    
    func save(_ items: [PreparationItem]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
