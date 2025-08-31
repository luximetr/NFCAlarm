import Foundation
import SwiftUI

@MainActor
public class PresentationViewModel: ObservableObject {
    
    // MARK: - Init
    
    public init() {
//        self.appearance = CompositeAppearance(colorScheme: <#T##ColorScheme#>)
    }
    
    // MARK: - Appearance
    
//    private(set) var appearance: Appearance
    
    // MARK: - Path
    
    @Published var screenPath = NavigationPath()
//    @Published var screenPath: [AnyHashable] = []
    
    // MARK: - Screens view models
    
    weak var alarmsListScreenViewModel: AlarmsListScreenViewModel?
    weak var createAlarmScreenViewModel: CreateAlarmScreenViewModel?
    weak var editAlarmScreenViewModel: EditAlarmScreenViewModel?
    
    // MARK: - Alarm
    
    public var addAlarm: ((CreatingAlarm) async throws -> Void)?
    
}
