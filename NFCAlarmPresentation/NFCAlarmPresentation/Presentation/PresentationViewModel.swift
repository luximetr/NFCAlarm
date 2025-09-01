import Foundation
import SwiftUI

@MainActor
public class PresentationViewModel: ObservableObject {
    
    // MARK: - Init
    
    public init() {
        self.locale = Locale(language: .english, scriptCode: nil, regionCode: nil)
    }
    
    // MARK: - Locale
    
    var locale: Locale
    
    // MARK: - Path
    
    @Published var screenPath = NavigationPath()
    
    // MARK: - Screens view models
    
    weak var alarmsListScreenViewModel: AlarmsListScreenViewModel?
    weak var createAlarmScreenViewModel: CreateAlarmScreenViewModel?
    weak var editAlarmScreenViewModel: EditAlarmScreenViewModel?
    
    // MARK: - Alarm
    
    public var getAllAlarms: (() async throws -> [Alarm])?
    public var createAlarm: ((CreatingAlarm) async throws -> Void)?
    public var editAlarm: ((EditingAlarm) async throws -> Alarm)!
    public var deleteAlarm: ((Alarm) async throws -> Void)!
    
}
