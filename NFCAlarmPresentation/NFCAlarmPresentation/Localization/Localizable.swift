import Foundation

@MainActor
protocol Localizable {
    func setLocale(_ locale: Locale)
}
