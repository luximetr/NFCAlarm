import SwiftUI

struct InterfaceSettingsScreenView: View {
    
    let languages: [Language]
    @State var selectedLanguage: Language
    let appearanceSettings: [AppearanceSetting]
    @State var selectedAppearanceSetting: AppearanceSetting
    
    var body: some View {
        Form {
            Section("Language") {
                ForEach(languages, id: \.self) { language in
                    selectItem(title: "\(language)", isSelected: language == selectedLanguage, onSelect: {
                        self.selectedLanguage = language
                    })
                }
            }
            Section("Appearance") {
                ForEach(appearanceSettings, id: \.self) { setting in
                    selectItem(title: "\(setting)", isSelected: setting == selectedAppearanceSetting, onSelect: {
                        self.selectedAppearanceSetting = setting
                    })
                }
            }
        }
        .navigationTitle("Settings")
    }
    
    func selectItem(title: String, isSelected: Bool, onSelect: @escaping () -> Void) -> some View {
        Button {
            onSelect()
        } label: {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        InterfaceSettingsScreenView(
            languages: Language.allCases,
            selectedLanguage: .english,
            appearanceSettings: AppearanceSetting.allCases,
            selectedAppearanceSetting: .light
        )
    }
}
