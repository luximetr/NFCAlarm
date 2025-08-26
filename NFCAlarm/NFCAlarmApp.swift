import SwiftUI
import SwiftData

@main
struct NFCAlarmApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView(alarms: [.init(id: UUID(), title: "Alarm 1", hours: 00, minutes: 15),
                                 .init(id: UUID(), title: "Alarm 2", hours: 00, minutes: 30),
                                 .init(id: UUID(), title: "Alarm 3", hours: 00, minutes: 45)])
        }
//        .modelContainer(sharedModelContainer)
    }
}
