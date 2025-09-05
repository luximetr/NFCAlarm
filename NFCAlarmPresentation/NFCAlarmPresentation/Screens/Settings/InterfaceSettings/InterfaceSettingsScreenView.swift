import SwiftUI

struct InterfaceSettingsScreenView: View {
    
    @ObservedObject private var viewModel: InterfaceSettingsScreenViewModel
    
    init(viewModel: InterfaceSettingsScreenViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Form {
            Section("Language") {
                List(viewModel.languages, id: \.self) { language in
                    selectItem(
                        title: viewModel.languageNameLocalizer.name(language),
                        isSelected: language == viewModel.selectedLanguage,
                        onSelect: {
                            self.viewModel.selectLanguage(language)
                        }
                    )
                }
            }
            Section("Appearance") {
                List(viewModel.appearanceSettings, id: \.self) { setting in
                    selectItem(
                        title: viewModel.appearanceSettingNameLocalier.name(setting),
                        isSelected: setting == viewModel.selectedAppearanceSetting,
                        onSelect: {
                            self.viewModel.selectedAppearanceSetting(setting)
                        }
                    )
                }
            }
        }
        .navigationTitle(viewModel.localizer.localizeText("navigationTitle"))
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
    let viewModel = InterfaceSettingsScreenViewModel(
        locale: Locale(language: .english, scriptCode: nil, regionCode: nil),
        languages: Language.allCases,
        selectedLanguage: .english,
        appearanceSettings: AppearanceSetting.allCases,
        selectedAppearanceSetting: .light
    )
    return NavigationStack {
        InterfaceSettingsScreenView(viewModel: viewModel)
    }
}
