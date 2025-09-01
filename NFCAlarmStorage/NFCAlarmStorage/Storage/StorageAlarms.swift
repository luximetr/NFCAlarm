import Foundation

extension Storage {
    
    public func fetchAllAlarms() async throws -> [Alarm] {
        return try await swiftDataRepository.fetchAllAlarms()
    }
    
    public func createAlarm(_ creatingAlarm: CreatingAlarm) async throws {
        try await swiftDataRepository.createAlarm(creatingAlarm)
    }
    
    public func editAlarm(_ editingAlarm: EditingAlarm) async throws -> Alarm {
        return try await swiftDataRepository.editAlarm(editingAlarm)
    }
    
    public func deleteAlarm(whereId alarmId: UUID) async throws {
        try await swiftDataRepository.deleteAlarm(whereId: alarmId)
    }
}
