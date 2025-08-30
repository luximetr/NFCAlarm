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
    
    func createAlarm(_ addingAlarm: CreatingAlarm) async throws {
        let alarm = Alarm(id: UUID(), title: addingAlarm.name, hours: 0, minutes: 0, isOn: false)
        mainContext.insert(alarm)
        try mainContext.save()
    }
}
