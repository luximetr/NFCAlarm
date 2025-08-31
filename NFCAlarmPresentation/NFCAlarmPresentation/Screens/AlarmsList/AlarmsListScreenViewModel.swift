import Foundation

@MainActor
class AlarmsListScreenViewModel: ObservableObject {
    
    @Published var alarms: [Alarm] = []
    var onLoadAlarms: (() async throws -> [Alarm])?
    
    func onAppear() {
        Task(priority: .userInitiated) {
            do {
                let alarms = try await onLoadAlarms?()
                self.alarms = alarms ?? []
            } catch {
                print(error)
            }
        }
    }
    
    var onAddAlarm: (() -> Void)?
    
    func addAlarmTapped() {
        onAddAlarm?()
    }
    
    var onEditAlarm: ((Alarm) -> Void)?
    
    func editAlarmTapped(_ alarm: Alarm) {
        onEditAlarm?(alarm)
    }
    
    var onUpdateAlarm: ((EditingAlarm) async throws -> Alarm)?
    
    func alarmIsOnTapped(_ alarm: Alarm, isOn: Bool) {
        guard let onUpdateAlarm = onUpdateAlarm else { return }
        let editingAlarm = EditingAlarm(
            id: alarm.id,
            name: alarm.name,
            hours: alarm.hours,
            minutes: alarm.minutes,
            isOn: isOn
        )
        Task(priority: .userInitiated) {
            let updatedAlarm = try await onUpdateAlarm(editingAlarm)
            guard let alarmIndex = alarms.firstIndex(of: alarm) else { return }
            alarms[alarmIndex] = updatedAlarm
        }
    }
}
