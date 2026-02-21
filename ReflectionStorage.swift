import Foundation

struct ReflectionStorage {
    
    private static let key = "reflections"
    
    static func save(scenario: String, text: String) {
        let new = ReflectionEntry(scenario: scenario, text: text)
        var all = load()
        all.insert(new, at: 0)
        
        if let data = try? JSONEncoder().encode(all) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    static func load() -> [ReflectionEntry] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([ReflectionEntry].self, from: data)
        else { return [] }
        
        return decoded
    }
}
