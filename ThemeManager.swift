import SwiftUI

final class ThemeManager: ObservableObject {
    @Published var isNight: Bool = false
    
    init() {
        update()
    }
    
    func update() {
        let hour = Calendar.current.component(.hour, from: Date())
        isNight = hour >= 21 || hour < 6
    }
}
