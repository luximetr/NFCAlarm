import Foundation

@MainActor
class AlarmsListScreenViewModel {
    
    var onAddAlarm: (() -> Void)?
    
    func addAlarmTapped() {
        onAddAlarm?()
    }
}
