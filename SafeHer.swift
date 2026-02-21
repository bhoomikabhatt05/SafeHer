import SwiftUI

@main
struct SafeHerApp: App {
    
    @StateObject private var theme = ThemeManager()
    @StateObject private var userState = UserStateManager()
    @StateObject private var progress = ProgressManager()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(theme)
                .environmentObject(userState)
                .environmentObject(progress)
        }
    }
}
