import Foundation

extension PresentationViewModel {
    
    // MARK: - Interface settings
    
    func createInterfaceSettingsScreenView() -> InterfaceSettingsScreenView {
        let viewModel = self.interfaceSettingsScreenViewModel ?? InterfaceSettingsScreenViewModel(
            locale: locale,
            languages: Language.allCases,
            selectedLanguage: .english,
            appearanceSettings: AppearanceSetting.allCases,
            selectedAppearanceSetting: .light
        )
        self.interfaceSettingsScreenViewModel = viewModel
        viewModel.onBackTapped = { [weak self] in
            self?.screenPath.removeLast()
        }
        viewModel.onSelectLanguage = { [weak self] language in
            self?.setLocale(Locale(language: language, scriptCode: nil, regionCode: nil))
        }
        viewModel.onSelectAppearanceSetting = { [weak self] setting in
            self?.setAppearanceSetting(setting)
        }
        let view = InterfaceSettingsScreenView(viewModel: viewModel)
        return view
    }
}

// MARK: - Route

enum PresentationSettingsRoute: Hashable, Equatable {
    case interfaceSettings
    
    static func == (lhs: PresentationSettingsRoute, rhs: PresentationSettingsRoute) -> Bool {
        switch (lhs, rhs) {
        case (.interfaceSettings, .interfaceSettings): return true
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}
