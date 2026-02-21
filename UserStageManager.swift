import SwiftUI

final class UserStateManager: ObservableObject {
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @AppStorage("hasCompletedFirstSession") var hasCompletedFirstSession: Bool = false
}
