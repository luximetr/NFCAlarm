import Foundation

protocol Localizer {
    func setLocale(_ locale: Locale)
    func localizeText(_ text: String, _ arguments: CVarArg...) -> String
}
