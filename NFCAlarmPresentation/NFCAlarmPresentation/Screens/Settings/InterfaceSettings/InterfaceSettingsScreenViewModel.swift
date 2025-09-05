import Foundation

@MainActor
class InterfaceSettingsScreenViewModel: ObservableObject {
    
    // MARK: - Init
    
    init(
        locale: Locale,
        languages: [Language],
        selectedLanguage: Language,
        appearanceSettings: [AppearanceSetting],
        selectedAppearanceSetting: AppearanceSetting
    ) {
        self.locale = locale
        self.languages = languages
        self.selectedLanguage = selectedLanguage
        self.appearanceSettings = appearanceSettings
        self.selectedAppearanceSetting = selectedAppearanceSetting
    }
    
    // MARK: - Localization
    
    @Published var locale: Locale
    
    lazy var localizer: Localizer = {
        let localizer = Localizer(locale: locale, stringsTableName: "InterfaceSettingsScreenStrings")
        return localizer
    }()
    
    lazy var languageNameLocalizer: LanguageNameLocalizer = {
        let localizer = LanguageNameLocalizer(locale: locale)
        return localizer
    }()
    
    lazy var appearanceSettingNameLocalier: AppearanceSettingNameLocalizer = {
        let localizer = AppearanceSettingNameLocalizer(locale: locale)
        return localizer
    }()
    
    // MARK: - Languages
    
    let languages: [Language]
    @Published var selectedLanguage: Language
    
    func selectLanguage(_ language: Language) {
        self.selectedLanguage = language
    }
    
    // MARK: - Appearance setting
    
    let appearanceSettings: [AppearanceSetting]
    @Published var selectedAppearanceSetting: AppearanceSetting
    
    func selectedAppearanceSetting(_ setting: AppearanceSetting) {
        self.selectedAppearanceSetting = setting
    }
}
