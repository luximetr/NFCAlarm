import Foundation

extension ApplicationViewModel {
    
    func presentationCreateAlarm(_ presentationCreatingAlarm: PresentationCreatingAlarm) async throws {
        let storageCreatingAlarm = CreatingAlarmMapper.mapToStorage(presentationCreatingAlarm)
        try await storage.createAlarm(storageCreatingAlarm)
    }
    
    func presentationGetAllAlarms() async throws -> [PresentationAlarm] {
        let storageAlarms = try await storage.fetchAllAlarms()
        let presentationAlarms = storageAlarms.map(AlarmMapper.mapToPresentation)
        return presentationAlarms
    }
}
