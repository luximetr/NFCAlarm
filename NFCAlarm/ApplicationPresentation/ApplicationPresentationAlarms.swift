import Foundation

extension ApplicationViewModel {
    
    func presentationAddAlarm(_ presentationCreatingAlarm: PresentationCreatingAlarm) async throws {
        let storageCreatingAlarm = CreatingAlarmMapper.mapToStorage(presentationCreatingAlarm)
        try await storage.createAlarm(storageCreatingAlarm)
    }
}
