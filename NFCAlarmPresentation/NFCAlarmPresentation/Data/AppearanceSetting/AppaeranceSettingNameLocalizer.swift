import Foundation

final class AppearanceSettingNameLocalizer: Localizable {
    
    // MARK: - Init
    
    init(locale: Locale) {
        self.locale = locale
    }
    
    // MARK: - Locale
    
    @Published private var locale: Locale
    
    func setLocale(_ locale: Locale) {
        self.locale = locale
        localizer.setLocale(locale)
    }
    
    // MARK: - Localizer
    
    private lazy var localizer: Localizer = {
        let localizer = Localizer(locale: locale, stringsTableName: "AppearanceSettingNameStrings")
        return localizer
    }()
    
    // MARK: - Name
    
    func name(_ appearanceType: AppearanceSetting) -> String {
        switch appearanceType {
        case .light: return localizer.localizeText("light")
        case .dark: return localizer.localizeText("dark")
        case .system: return localizer.localizeText("system")
        }
    }
    
}
