import SwiftUI
import SwiftData
import NFCAlarmPresentation
import NFCAlarmStorage

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
    
    init() {
        self.viewModel = ApplicationViewModel()
    }
    
    let viewModel: ApplicationViewModel

    var body: some Scene {
        WindowGroup {
            PresentationView(viewModel: viewModel.presentationViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
