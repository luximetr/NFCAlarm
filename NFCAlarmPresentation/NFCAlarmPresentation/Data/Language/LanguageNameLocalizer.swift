import Foundation

final class LanguageNameLocalizer {
    
    // MARK: - Data
    
    private var locale: Locale
    
    func changeLocale(_ locale: Locale) {
        self.locale = locale
        localizer.setLocale(locale)
    }
    
    // MARK: - Initialization
    
    init(locale: Locale) {
        self.locale = locale
    }
    
    // MARK: - Localizer
    
    private lazy var localizer: Localizer = {
        let localizer = Localizer(locale: locale, stringsTableName: "LanguageNameStrings")
        return localizer
    }()
    
    func name(_ language: Language) -> String {
        switch language {
        case .english: return localizer.localizeText("english")
        case .ukrainian: return localizer.localizeText("ukrainian")
        }
    }
    
}
