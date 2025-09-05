import Foundation
import SwiftUI

@MainActor
public class PresentationViewModel: ObservableObject {
    
    // MARK: - Init
    
    public init() {
        self.locale = Locale(language: .english, scriptCode: nil, regionCode: nil)
        self.appearanceSetting = .system
        self.appearance = CompositeAppearance(colorScheme: .light)
        self.colorScheme = .light
    }
    
    // MARK: - Locale
    
    private(set) var locale: Locale
    
    func setLocale(_ locale: Locale) {
        self.locale = locale
        alarmsListScreenViewModel?.setLocale(locale)
        interfaceSettingsScreenViewModel?.setLocale(locale)
    }
    
    // MARK: - Appearance
    
    private(set) var appearanceSetting: AppearanceSetting
    @Published var appearance: Appearance
    
    func setAppearanceSetting(_ setting: AppearanceSetting) {
        self.appearanceSetting = setting
        appearance = CompositeAppearance(appearanceSetting: appearanceSetting, colorScheme: colorScheme)
    }
    
    private(set) var colorScheme: ColorScheme
    
    func setColorScheme(_ colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
        guard appearanceSetting == .system else { return }
        appearance = CompositeAppearance(appearanceSetting: appearanceSetting, colorScheme: colorScheme)
    }
    
    // MARK: - Path
    
    @Published var screenPath = NavigationPath()
    
    // MARK: - Screens view models
    
    weak var alarmsListScreenViewModel: AlarmsListScreenViewModel?
    weak var createAlarmScreenViewModel: CreateAlarmScreenViewModel?
    weak var editAlarmScreenViewModel: EditAlarmScreenViewModel?
    
    weak var interfaceSettingsScreenViewModel: InterfaceSettingsScreenViewModel?
    
    // MARK: - Alarm
    
    public var getAllAlarms: (() async throws -> [Alarm])?
    public var createAlarm: ((CreatingAlarm) async throws -> Void)?
    public var editAlarm: ((EditingAlarm) async throws -> Alarm)!
    public var deleteAlarm: ((Alarm) async throws -> Void)!
    
}
