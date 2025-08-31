import Foundation

public struct EditingAlarm {
    public let id: UUID
    public let name: String?
    public let hours: Int
    public let minutes: Int
    public let isOn: Bool
    
    public init(id: UUID, name: String?, hours: Int, minutes: Int, isOn: Bool) {
        self.id = id
        self.name = name
        self.hours = hours
        self.minutes = minutes
        self.isOn = isOn
    }
}
