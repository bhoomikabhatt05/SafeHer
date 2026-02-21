import SwiftUI

struct ReflectionHistoryView: View {
    
    @State private var entries: [ReflectionEntry] = []
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            if entries.isEmpty {
                // Empty state
                VStack(spacing: 16) {
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color.safePrimary.opacity(0.08))
                            .frame(width: 100, height: 100)
                            .blur(radius: 15)
                        
                        Image(systemName: "book.closed")
                            .font(.system(size: 44))
                            .foregroundStyle(Color.safePrimary.opacity(0.4))
                    }
                    
                    Text("No Reflections Yet")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                    
                    Text("Complete a practice scenario\nto see your reflections here")
                        .font(.subheadline)
                        .foregroundStyle(Color.safeSubtext)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink("Start Practicing") {
                        ScenarioSelectionView()
                    }
                    .buttonStyle(MainButton(fullWidth: false))
                    .padding(.top, 10)
                    
                    Spacer()
                }
                
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(entries) { entry in
                            ReflectionCard(entry: entry)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
        }
        .navigationTitle("Your Reflections")
        .onAppear {
            entries = ReflectionStorage.load()
        }
    }
}
