import SwiftUI

struct ReflectionView: View {
    
    let scenario: String
    @State private var text = ""
    @State private var showPlaceholder = true
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 36))
                            .foregroundStyle(Color.safeAccent)
                        
                        Text("Reflect")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.safeText)
                        
                        Text(scenario)
                            .font(.subheadline)
                            .foregroundStyle(Color.safeSubtext)
                    }
                    .padding(.top, 20)
                    
                    // Text editor with placeholder
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $text)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(minHeight: 180)
                            .padding(16)
                            .onChange(of: text) { _, newValue in
                                showPlaceholder = newValue.isEmpty
                            }
                        
                        if showPlaceholder {
                            Text("How would you react in this situation? What would you do first? What could you do to stay safe?")
                                .font(.body)
                                .foregroundStyle(Color.safeSubtext.opacity(0.5))
                                .padding(20)
                                .allowsHitTesting(false)
                        }
                    }
                    .background(Color.safeCard)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // Submit
                    NavigationLink {
                        CompletionView(scenario: scenario, reflection: text)
                    } label: {
                        Text("Save Reflection")
                    }
                    .buttonStyle(MainButton())
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
                    
                    Spacer(minLength: 40)
                }
            }
        }
    }
}
