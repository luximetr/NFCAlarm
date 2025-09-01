import Foundation

@MainActor
class AlarmsListScreenViewModel: ObservableObject {
    
    // MARK: - Init
    
    init(locale: Locale) {
        self.locale = locale
    }
    
    // MARK: - Localization
    
    @Published var locale: Locale
    
    lazy var localizer: Localizer = {
        let localizer = Localizer(locale: locale, stringsTableName: "AlarmsListScreenStrings")
        return localizer
    }()
    
    // MARK: - View life cycle
    
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
    
    // MARK: - Alarms
    
    @Published var alarms: [Alarm] = []
    var onLoadAlarms: (() async throws -> [Alarm])?
    
    // MARK: - Add alarm
    
    var onAddAlarm: (() -> Void)?
    
    func addAlarmTapped() {
        onAddAlarm?()
    }
    
    // MARK: - Edit alarm
    
    var onEditAlarm: ((Alarm) -> Void)?
    
    func editAlarmTapped(_ alarm: Alarm) {
        onEditAlarm?(alarm)
    }
    
    // MARK: - Update alarm
    
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
    
    // MARK: - Delete alarm
    
    var onDeleteAlarm: ((Alarm) async throws -> Void)?
    
    func alarmDeleteActivated(_ indexSet: IndexSet) {
        guard let onDeleteAlarm = onDeleteAlarm else { return }
        guard let index = indexSet.first else { return }
        let alarm = alarms[index]
        Task(priority: .userInitiated) {
            try await onDeleteAlarm(alarm)
            alarms.remove(at: index)
        }
    }
}
