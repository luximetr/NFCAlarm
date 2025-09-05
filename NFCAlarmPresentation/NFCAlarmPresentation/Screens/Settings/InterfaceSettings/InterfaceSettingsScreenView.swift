import SwiftUI

struct InterfaceSettingsScreenView: View {
    
    // MARK: - Init
    
    init(viewModel: InterfaceSettingsScreenViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    // MARK: - Appearance
    
    @Environment(\.appearance) private var appearance
    
    // MARK: - View model
    
    @ObservedObject private var viewModel: InterfaceSettingsScreenViewModel
    
    // MARK: - Body
    
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
                    .font(appearance.fonts.body)
                    .foregroundStyle(appearance.colors.primaryText)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
            .background {
                appearance.colors.primaryBackground
            }
        }
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
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
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
