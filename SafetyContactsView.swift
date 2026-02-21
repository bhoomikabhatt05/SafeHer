import SwiftUI

struct SafetyContactsView: View {
    
    @State private var copiedIndex: Int? = nil
    
    private let contacts: [(name: String, number: String, description: String, icon: String, color: Color)] = [
        ("Emergency (India)", "112", "Universal emergency number — police, fire, ambulance", "phone.fill", Color.safeAccent),
        ("Women Helpline", "181", "24/7 women helpline for immediate assistance", "person.fill", Color.safePrimary),
        ("Police", "100", "Direct police helpline for reporting crimes", "shield.fill", Color.safeSecondary),
        ("Women Commission", "7827-170-170", "National Commission for Women — WhatsApp too", "message.fill", Color.safeSuccess),
        ("Cyber Crime", "1930", "Report cyber crime, online harassment, stalking", "lock.trianglebadge.exclamationmark.fill", Color.safeWarning),
        ("Child Helpline", "1098", "For anyone under 18 needing help or protection", "heart.fill", Color.safeGradientEnd),
        ("Ambulance", "108", "Emergency medical services and ambulance", "cross.fill", Color(red: 0.35, green: 0.75, blue: 0.85)),
        ("Domestic Violence", "181", "Report domestic violence — confidential support available", "house.fill", Color(red: 0.65, green: 0.50, blue: 0.85))
    ]
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    
                    // Disclaimer
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(Color.safeWarning)
                        Text("In an emergency, always call 112 first")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.safeWarning)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.safeWarning.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Contact cards
                    ForEach(Array(contacts.enumerated()), id: \.offset) { index, contact in
                        contactCard(index: index, contact: contact)
                    }
                    
                    // Note
                    Text("Tap any number to copy it")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundStyle(Color.safeSubtext.opacity(0.5))
                        .padding(.vertical, 20)
                        .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Safety Contacts")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func contactCard(index: Int, contact: (name: String, number: String, description: String, icon: String, color: Color)) -> some View {
        Button {
            UIPasteboard.general.string = contact.number
            withAnimation(.spring(response: 0.3)) {
                copiedIndex = index
            }
            HapticManager.shared.success()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation { copiedIndex = nil }
            }
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(contact.color.opacity(0.15))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: contact.icon)
                        .font(.system(size: 18))
                        .foregroundStyle(contact.color)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(contact.name)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.safeText)
                    
                    Text(contact.description)
                        .font(.system(size: 12, design: .rounded))
                        .foregroundStyle(Color.safeSubtext)
                        .lineLimit(1)
                }
                
                Spacer()
                
                if copiedIndex == index {
                    Text("Copied!")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.safeSuccess)
                } else {
                    Text(contact.number)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(contact.color)
                }
            }
            .padding(14)
            .glassCard(cornerRadius: 16)
        }
        .padding(.horizontal, 20)
        .accessibilityLabel("\(contact.name), \(contact.number)")
        .accessibilityHint("Tap to copy number")
    }
}
