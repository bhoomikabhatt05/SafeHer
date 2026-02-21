import SwiftUI

struct SafeCard<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .glassCard(cornerRadius: 20)
            .padding(.horizontal)
    }
}
