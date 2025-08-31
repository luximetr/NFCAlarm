import Foundation

@MainActor
class AlarmsListScreenViewModel {
    
    var onAddAlarm: (() -> Void)?
    
    func addAlarmTapped() {
        onAddAlarm?()
    }
    
    var onEditAlarm: ((Alarm) -> Void)?
    
    func editAlarmTapped(_ alarm: Alarm) {
        onEditAlarm?(alarm)
    }
}
