import SwiftUI
import SwiftData
import NCFAlarmPresentation

@main
struct Application: App {
    @Environment(\.modelContext) private var modelContext
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Alarm.self,
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
            PresentationView()
        }
        .modelContainer(sharedModelContainer)
    }
}
