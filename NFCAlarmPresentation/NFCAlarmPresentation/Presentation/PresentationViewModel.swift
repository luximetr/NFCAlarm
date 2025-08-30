import Foundation
import SwiftUI

@MainActor
public class PresentationViewModel: ObservableObject {
    
    // MARK: - Init
    
    public init() {
//        self.appearance = appearance
        screenPath.append(PresentationAlarmRoute.alarmsList)
    }
    
    // MARK: - Appearance
    
//    private(set) var appearance: Appearance
    
    // MARK: - Path
    
    @State var screenPath = NavigationPath()
//    @Published var screenPath: [AnyHashable] = []
    
    // MARK: - Screens view models
    
    weak var createAlarmScreenViewModel: CreateAlarmScreenViewModel?
    
    // MARK: - Alarm
    
    public var addAlarm: ((CreatingAlarm) async throws -> Void)?
    
}
