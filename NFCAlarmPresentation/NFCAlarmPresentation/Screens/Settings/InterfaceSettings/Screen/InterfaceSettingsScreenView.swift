import SwiftUI

struct InterfaceSettingsScreenView: View {
    
    // MARK: - Init
    
    init(viewModel: InterfaceSettingsScreenViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    // MARK: - View model
    
    @ObservedObject private var viewModel: InterfaceSettingsScreenViewModel
    
    // MARK: - Appearance
    
    @Environment(\.appearance) private var appearance
    
    // MARK: - Body
    
    var body: some View {
        List {
            section(viewModel.localizer.localizeText("languageSectionTitle")) {
                ForEach(viewModel.languages, id: \.self) { language in
                    selectItem(
                        title: viewModel.languageNameLocalizer.name(language),
                        isSelected: language == viewModel.selectedLanguage,
                        onSelect: {
                            self.viewModel.selectLanguage(language)
                        }
                    )
                }
            }
            section(viewModel.localizer.localizeText("appearanceSectionTitle")) {
                ForEach(viewModel.appearanceSettings, id: \.self) { setting in
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
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(appearance.colors.primaryBackground)
        .titleBackNavigationBar(title: viewModel.localizer.localizeText("navigationTitle")) {
            viewModel.backButtonTapped()
        }
    }
    
    @ViewBuilder
    func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        Section(content: content, header: {
            Text(title)
                .font(appearance.fonts.headline)
                .foregroundStyle(appearance.colors.tertiaryText)
        })
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
                    appearance.images.checkmark
                        .foregroundStyle(appearance.colors.accent)
                }
            }
        }
        .listRowBackground(appearance.colors.primaryBackground)
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
