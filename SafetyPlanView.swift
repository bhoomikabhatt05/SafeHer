import SwiftUI

struct SafetyPlanView: View {
    
    @AppStorage("emergencyContact1") private var contact1 = ""
    @AppStorage("emergencyContact2") private var contact2 = ""
    @AppStorage("safePlace1") private var place1 = ""
    @AppStorage("safePlace2") private var place2 = ""
    @AppStorage("personalNote") private var personalNote = ""
    @State private var showSaved = false
    
    private let emergencySteps = [
        (icon: "1.circle.fill", step: "Stay calm and assess the situation"),
        (icon: "2.circle.fill", step: "Move toward people or a well-lit area"),
        (icon: "3.circle.fill", step: "Call your emergency contact or 112/911"),
        (icon: "4.circle.fill", step: "Share your live location with someone you trust"),
        (icon: "5.circle.fill", step: "If confronted, use a firm voice and set boundaries")
    ]
    
    var body: some View {
        ZStack {
            Color.safeBackground.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // Emergency Steps
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "list.bullet.clipboard.fill")
                                .foregroundStyle(Color.safeAccent)
                            Text("Emergency Steps")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeText)
                        }
                        
                        ForEach(Array(emergencySteps.enumerated()), id: \.offset) { _, item in
                            HStack(spacing: 12) {
                                Image(systemName: item.icon)
                                    .font(.title3)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.safeAccent, Color.safeGradientEnd],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 28)
                                
                                Text(item.step)
                                    .font(.system(size: 15, design: .rounded))
                                    .foregroundStyle(Color.safeText)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // My Contacts
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .foregroundStyle(Color.safePrimary)
                            Text("My Trusted Contacts")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeText)
                        }
                        
                        planTextField(title: "Contact 1 (Name & Number)", text: $contact1)
                        planTextField(title: "Contact 2 (Name & Number)", text: $contact2)
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // My Safe Places
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundStyle(Color.safeSuccess)
                            Text("My Safe Places")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeText)
                        }
                        
                        planTextField(title: "Safe place near home", text: $place1)
                        planTextField(title: "Safe place near work/school", text: $place2)
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // Personal Notes
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "note.text")
                                .foregroundStyle(Color.safeWarning)
                            Text("Personal Safety Notes")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.safeText)
                        }
                        
                        TextField("Add any personal safety reminders...", text: $personalNote, axis: .vertical)
                            .font(.system(size: 15, design: .rounded))
                            .foregroundStyle(Color.safeText)
                            .lineLimit(3...6)
                            .padding(12)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.safeCardBorder, lineWidth: 0.5)
                            )
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 18)
                    .padding(.horizontal, 20)
                    
                    // Save button
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            showSaved = true
                        }
                        HapticManager.shared.success()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSaved = false
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: showSaved ? "checkmark.circle.fill" : "square.and.arrow.down.fill")
                            Text(showSaved ? "Saved!" : "Save My Plan")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            LinearGradient(
                                colors: showSaved ? [Color.safeSuccess, Color.safeSuccess.opacity(0.8)] : [Color.safeAccent, Color.safeGradientEnd],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(14)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
                .padding(.top, 10)
            }
        }
        .navigationTitle("Safety Plan")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func planTextField(title: String, text: Binding<String>) -> some View {
        TextField(title, text: text)
            .font(.system(size: 15, design: .rounded))
            .foregroundStyle(Color.safeText)
            .padding(12)
            .background(Color.white.opacity(0.05))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.safeCardBorder, lineWidth: 0.5)
            )
            .accessibilityLabel(title)
    }
}
