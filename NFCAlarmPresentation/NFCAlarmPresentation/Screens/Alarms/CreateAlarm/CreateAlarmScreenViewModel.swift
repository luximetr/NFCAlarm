import Foundation
import SwiftUI

@MainActor
class CreateAlarmScreenViewModel: ObservableObject, Localizable {
    
    // MARK: - Init
    
    init(locale: Locale) {
        self.locale = locale
        self.localizer = Localizer(locale: locale, stringsTableName: "CreateAlarmScreenStrings")
    }
    
    // MARK: - Localization
    
    @Published var locale: Locale
    @ObservedObject var localizer: Localizer
    
    func setLocale(_ locale: Locale) {
        self.locale = locale
        localizer.setLocale(locale)
    }
    
    // MARK: - Back
    
    var onBackTapped: (() -> Void)?
    
    func backButtonTapped() {
        onBackTapped?()
    }
    
    // MARK: - Time
    
    @Published var time = Date()
    
    // MARK: - Name
    
    @Published var name = ""
    
    // MARK: - Create alarm
    
    var onCreateAlarm: ((CreatingAlarm) -> Void)?
    
    func saveAlarmTapped() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        let creatingAlarm = CreatingAlarm(name: name, hour: hour, minute: minute)
        onCreateAlarm?(creatingAlarm)
    }
}
