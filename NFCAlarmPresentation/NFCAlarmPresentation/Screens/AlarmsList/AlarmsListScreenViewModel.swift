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
}
