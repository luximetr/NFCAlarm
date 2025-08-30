import Foundation
import NFCAlarmPresentation
import NFCAlarmStorage

@MainActor
class ApplicationViewModel {
    
    var presentationViewModel: PresentationViewModel!
    var storage: Storage!
    
    // MARK: - Init
    
    func initialize() throws {
        initializeStorage()
        initializePresentation()
    }
    
    private func initializeStorage() {
        self.storage = Storage()
    }
    
    private func initializePresentation() {
        presentationViewModel = PresentationViewModel()
    }
}
