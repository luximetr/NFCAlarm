import Foundation

extension Storage {
    
    public func createAlarm(_ creatingAlarm: CreatingAlarm) async throws {
        try await swiftDataRepository.createAlarm(creatingAlarm)
    }
    
    public func fetchAllAlarms() async throws -> [Alarm] {
        return try await swiftDataRepository.fetchAllAlarms()
    }
}
