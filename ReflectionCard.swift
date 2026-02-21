import SwiftUI

struct ReflectionCard: View {
    
    let entry: ReflectionEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Image(systemName: "pencil.and.outline")
                    .font(.caption)
                    .foregroundStyle(Color.safeAccent)
                
                Text(entry.scenario)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.safeText)
                
                Spacer()
                
                Text(entry.date.formatted(.dateTime.month(.abbreviated).day()))
                    .font(.caption2)
                    .foregroundStyle(Color.safeSubtext)
            }
            
            Text(entry.text)
                .font(.subheadline)
                .foregroundStyle(Color.safeSubtext)
                .lineLimit(3)
        }
        .padding(16)
        .glassCard(cornerRadius: 16)
    }
}
