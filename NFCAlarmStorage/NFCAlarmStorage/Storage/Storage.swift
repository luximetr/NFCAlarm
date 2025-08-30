import SwiftData

@MainActor
public class Storage {
    
    // MARK: - SwiftDataRepository
    
    let swiftDataRepository = SwiftDataRepository()
    
    // MARK: - Init
    
    public init() {}
    
    public func initialize() throws {
        do {
            try swiftDataRepository.initialize()
        } catch {
            throw Error("Failed to initialize Storage\n\(error)")
        }
    }
}
