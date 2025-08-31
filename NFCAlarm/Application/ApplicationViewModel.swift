import Foundation
import NFCAlarmPresentation
import NFCAlarmStorage

@MainActor
class ApplicationViewModel: ObservableObject {
    
    var presentationViewModel: PresentationViewModel!
    var storage: Storage!
    
    @Published var isInitialized: Bool = false
    
    // MARK: - Init
    
    func initialize() throws {
        try initializeStorage()
        initializePresentation()
        isInitialized = true
    }
    
    private func initializeStorage() throws {
        self.storage = Storage()
        try storage.initialize()
    }
    
    private func initializePresentation() {
        presentationViewModel = PresentationViewModel()
        weak var weakSelf = self
        presentationViewModel.createAlarm = weakSelf?.presentationCreateAlarm
        presentationViewModel.getAllAlarms = weakSelf?.presentationGetAllAlarms
    }
}
