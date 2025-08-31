import Foundation

public struct Alarm: Identifiable, Sendable, Equatable {
    public let id: UUID
    public var name: String?
    public var hours: Int
    public var minutes: Int
    public var isOn: Bool
    
    public init(id: UUID, name: String?, hours: Int, minutes: Int, isOn: Bool) {
        self.id = id
        self.name = name
        self.hours = hours
        self.minutes = minutes
        self.isOn = isOn
    }
}
