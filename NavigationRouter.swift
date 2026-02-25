import SwiftUI

class NavigationRouter: ObservableObject {
    @Published var navigationID = UUID()
    
    func popToRoot() {
        navigationID = UUID()
    }
}
