import Foundation
import CoreNFC

extension ApplicationViewModel {
    
    func presentationGetAllAlarms() async throws -> [PresentationAlarm] {
        let storageAlarms = try await storage.fetchAllAlarms()
        let presentationAlarms = storageAlarms.map(AlarmMapper.mapToPresentation)
        return presentationAlarms
    }
    
    func presentationCreateAlarm(_ presentationCreatingAlarm: PresentationCreatingAlarm) async throws {
        let storageCreatingAlarm = CreatingAlarmMapper.mapToStorage(presentationCreatingAlarm)
        try await storage.createAlarm(storageCreatingAlarm)
    }
    
    func presentationEditAlarm(_ presentationEditingAlarm: PresentationEditingAlarm) async throws -> PresentationAlarm {
        let storageEditingAlarm = EditingAlarmMapper.mapToStorage(presentationEditingAlarm)
        let storageUpdatedAlarm = try await storage.editAlarm(storageEditingAlarm)
        let presentationUpdatedAlarm = AlarmMapper.mapToPresentation(storageUpdatedAlarm)
        return presentationUpdatedAlarm
    }
    
    func presentationDeleteAlarm(_ presentationAlarm: PresentationAlarm) async throws {
        try await storage.deleteAlarm(whereId: presentationAlarm.id)
    }
}
