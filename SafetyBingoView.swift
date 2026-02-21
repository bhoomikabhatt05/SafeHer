import SwiftUI

struct SafetyBingoView: View {
    
    @AppStorage("bingoState") private var bingoStateData: String = ""
    @State private var completed: Set<Int> = []
    
    private let items: [(icon: String, task: String)] = [
        ("eye.fill", "Identified 2 exits"),
        ("location.fill", "Shared your location"),
        ("figure.walk", "Walked with confidence"),
        ("iphone.gen3", "Checked app permissions"),
        ("person.2.fill", "Checked on a friend"),
        ("speaker.wave.2.fill", "Practiced saying 'No'"),
        ("map.fill", "Planned alternate route"),
        ("lock.fill", "Changed a password"),
        ("star.fill", "FREE SPACE"),
        ("brain.head.profile", "Trusted your gut"),
        ("flashlight.on.fill", "Noted dark areas"),
        ("hand.raised.fill", "Set a boundary"),
        ("figure.stand", "Power posture 2 min"),
        ("ear.fill", "Did a sound check"),
        ("heart.fill", "Sent a safety text"),
        ("shield.fill", "Reviewed safety plan")
    ]
    
    private let gridSize = 4
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    // Stats
                    HStack {
                        VStack(spacing: 2) {
                            Text("\(completed.count)")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeAccent)
                            Text("of \(items.count)")
                                .font(.caption)
                                .foregroundStyle(Color.safeSubtext)
                        }
                        
                        Spacer()
                        
                        if completed.count == items.count {
                            HStack(spacing: 6) {
                                Image(systemName: "trophy.fill")
                                    .foregroundStyle(Color.safeWarning)
                                Text("BINGO!")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.safeWarning)
                            }
                        } else {
                            Text("Tap to check off")
                                .font(.caption)
                                .foregroundStyle(Color.safeSubtext)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    
                    // Bingo grid
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: gridSize), spacing: 8) {
                        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                            Button {
                                withAnimation(.spring(response: 0.3)) {
                                    if completed.contains(index) {
                                        completed.remove(index)
                                    } else {
                                        completed.insert(index)
                                        HapticManager.shared.impact()
                                    }
                                    saveBingoState()
                                }
                            } label: {
                                VStack(spacing: 6) {
                                    Image(systemName: item.icon)
                                        .font(.system(size: 18))
                                        .foregroundStyle(completed.contains(index) ? Color.white : Color.safeAccent)
                                    
                                    Text(item.task)
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundStyle(completed.contains(index) ? Color.white.opacity(0.9) : Color.safeSubtext)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 80)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(completed.contains(index)
                                              ? LinearGradient(colors: [Color.safeAccent, Color.safeGradientEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
                                              : LinearGradient(colors: [Color.safeCard, Color.safeCard], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(completed.contains(index) ? Color.clear : Color.safeCardBorder, lineWidth: 0.5)
                                )
                            }
                            .accessibilityLabel("\(item.task), \(completed.contains(index) ? "completed" : "not completed")")
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    // Reset
                    Button {
                        withAnimation {
                            completed.removeAll()
                            saveBingoState()
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Reset Board")
                        }
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(Color.safeSubtext)
                    }
                    .padding(.top, 8)
                    
                    // Tip
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "lightbulb.fill")
                                .foregroundStyle(Color.safeWarning)
                            Text("How to play")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeText)
                        }
                        
                        Text("Complete these safety habits throughout your week. Tap each tile as you accomplish it. Try to fill the entire board!")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundStyle(Color.safeSubtext)
                            .lineSpacing(3)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("Safety Bingo")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { loadBingoState() }
    }
    
    private func saveBingoState() {
        bingoStateData = completed.map { String($0) }.joined(separator: ",")
    }
    
    private func loadBingoState() {
        guard !bingoStateData.isEmpty else {
            completed = [8] // Free space
            return
        }
        completed = Set(bingoStateData.split(separator: ",").compactMap { Int($0) })
    }
}
