import Foundation
import SwiftData

@MainActor
final class SwiftDataRepository {
    
    private var modelContainer: ModelContainer!
    private var mainContext: ModelContext { return modelContainer.mainContext }
    
    func initialize() throws {
        let schema = Schema([
            Alarm.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            throw Error("Unable to initialize SwiftDataRepository\n\(error)")
        }
    }
    
    func fetchAllAlarms() async throws -> [Alarm] {
        let descriptor = FetchDescriptor<Alarm>()
        let alarms = try mainContext.fetch(descriptor)
        return alarms
    }
    
    func createAlarm(_ addingAlarm: CreatingAlarm) async throws {
        let alarm = Alarm(id: UUID(), name: addingAlarm.name, hours: addingAlarm.hours, minutes: addingAlarm.minutes, isOn: addingAlarm.isOn)
        mainContext.insert(alarm)
        try mainContext.save()
    }
    
    func editAlarm(_ editingAlarm: EditingAlarm) async throws -> Alarm {
        let alarmId = editingAlarm.id
        let descriptor = FetchDescriptor<Alarm>(
            predicate: #Predicate { $0.id == alarmId }
        )
        guard let alarm = try mainContext.fetch(descriptor).first else {
            throw Error("Unable to fetch alarm by id: \(editingAlarm.id)")
        }
        alarm.name = editingAlarm.name
        alarm.hours = editingAlarm.hours
        alarm.minutes = editingAlarm.minutes
        alarm.isOn = editingAlarm.isOn
        try mainContext.save()
        return alarm
    }
}
