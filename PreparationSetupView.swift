import SwiftUI

struct PreparationSetupView: View {
    
    @State private var items: [PreparationItem] = []
    @State private var newItem = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Before you go out")
                .font(.title.bold())
            
            Text("What do you usually carry?")
                .foregroundStyle(.secondary)
            
            HStack {
                TextField("Example: Keys, Pepper spray, Powerbank", text: $newItem)
                    .textFieldStyle(.roundedBorder)
                
                Button("Add") {
                    guard !newItem.isEmpty else { return }
                    items.append(PreparationItem(title: newItem, isEssential: false))
                    newItem = ""
                }
            }
            
            List {
                ForEach(items) { item in
                    Text(item.title)
                }
            }
            
            Button("Save & Continue") {
                PreparationStorage.shared.save(items)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
