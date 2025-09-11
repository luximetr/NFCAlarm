import Foundation
import SwiftUI

@MainActor
class InterfaceSettingsScreenViewModel: ObservableObject, Localizable {
    
    // MARK: - Init
    
    init(
        locale: Locale,
        languages: [Language],
        selectedLanguage: Language,
        appearanceSettings: [AppearanceSetting],
        selectedAppearanceSetting: AppearanceSetting
    ) {
        self.locale = locale
        self.localizer = Localizer(locale: locale, stringsTableName: "InterfaceSettingsScreenStrings")
        self.languages = languages
        self.selectedLanguage = selectedLanguage
        self.appearanceSettings = appearanceSettings
        self.selectedAppearanceSetting = selectedAppearanceSetting
    }
    
    // MARK: - Localization
    
    @Published var locale: Locale
    @ObservedObject var localizer: Localizer
    
    func setLocale(_ locale: Locale) {
        self.locale = locale
        localizer.setLocale(locale)
        languageNameLocalizer.setLocale(locale)
        appearanceSettingNameLocalier.setLocale(locale)
    }
    
    lazy var languageNameLocalizer: LanguageNameLocalizer = {
        let localizer = LanguageNameLocalizer(locale: locale)
        return localizer
    }()
    
    lazy var appearanceSettingNameLocalier: AppearanceSettingNameLocalizer = {
        let localizer = AppearanceSettingNameLocalizer(locale: locale)
        return localizer
    }()
    
    // MARK: - Back
    
    var onBackTapped: (() -> Void)?
    
    func backButtonTapped() {
        onBackTapped?()
    }
    
    // MARK: - Languages
    
    let languages: [Language]
    @Published var selectedLanguage: Language
    
    var onSelectLanguage: ((Language) -> Void)?
    
    func selectLanguage(_ language: Language) {
        self.selectedLanguage = language
        onSelectLanguage?(language)
    }
    
    // MARK: - Appearance setting
    
    let appearanceSettings: [AppearanceSetting]
    @Published var selectedAppearanceSetting: AppearanceSetting
    
    var onSelectAppearanceSetting: ((AppearanceSetting) -> Void)?
    
    func selectedAppearanceSetting(_ setting: AppearanceSetting) {
        self.selectedAppearanceSetting = setting
        onSelectAppearanceSetting?(setting)
    }
}
