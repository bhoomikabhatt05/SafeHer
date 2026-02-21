import SwiftUI

struct ScenarioCard: View {
    
    let scenario: Scenario
    
    private var difficultyColor: Color {
        scenario.difficulty == "Moderate" ? Color.safeWarning : Color.safeSuccess
    }
    
    var body: some View {
        HStack(spacing: 14) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color.safeAccent.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: scenario.icon)
                    .font(.title3)
                    .foregroundStyle(Color.safeAccent)
            }
            
            // Title + description
            VStack(alignment: .leading, spacing: 4) {
                Text(scenario.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.safeText)
                    .lineLimit(1)
                
                Text(scenario.description)
                    .font(.caption)
                    .foregroundStyle(Color.safeSubtext)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            // Difficulty badge
            Text(scenario.difficulty)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(difficultyColor)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(difficultyColor.opacity(0.12))
                .cornerRadius(8)
            
            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundStyle(Color.safeSubtext)
        }
        .padding(16)
        .glassCard(cornerRadius: 18)
    }
}
