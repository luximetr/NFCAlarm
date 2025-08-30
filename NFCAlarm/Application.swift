import SwiftUI
import SwiftData
import NFCAlarmPresentation
import NFCAlarmStorage

@main
struct Application: App {
    
    // MARK: - View model
    
    let viewModel: ApplicationViewModel
    
    // MARK: - Init
    
    init() {
        self.viewModel = ApplicationViewModel()
        do {
            try self.viewModel.initialize()
        } catch {
            print("Initialization failed: \(error)")
        }
    }
    
    // MARK: - Content

    var body: some Scene {
        WindowGroup {
            if let presentationViewModel = viewModel.presentationViewModel {
                PresentationView(viewModel: presentationViewModel)
            } else {
                errorView
            }
        }
    }
    
    var errorView: some View {
        Text("Application failed to initialize")
    }
}
