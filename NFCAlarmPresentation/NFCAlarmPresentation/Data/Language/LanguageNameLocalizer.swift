import Foundation

final class LanguageNameLocalizer: Localizable {
    
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
