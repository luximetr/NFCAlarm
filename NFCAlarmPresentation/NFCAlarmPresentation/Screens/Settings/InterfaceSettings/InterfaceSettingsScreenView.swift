import SwiftUI

struct InterfaceSettingsScreenView: View {
    
    @State var isSelected: Bool = false
    
    var body: some View {
        Form {
            Section("Language") {
                selectItem(title: "English")
                selectItem(title: "Ukrainian")
            }
            Section("Appearance") {
                Text("Light")
                Text("Dark")
                Text("System")
            }
        }
        .navigationTitle("Settings")
    }
    
    func selectItem(title: String) -> some View {
        Toggle(isOn: $isSelected) {
            Text(title)
        }
        .toggleStyle(.switch)
    }
}

#Preview {
    NavigationStack {
        InterfaceSettingsScreenView()
    }
}
