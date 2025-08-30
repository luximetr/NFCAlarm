import Foundation
import SwiftData

@Model
final public class Alarm {
    public var id: UUID
    public var title: String?
    public var hours: Int
    public var minutes: Int
    public var isOn: Bool
    
    public init(id: UUID, title: String?, hours: Int, minutes: Int, isOn: Bool) {
        self.id = id
        self.title = title
        self.hours = hours
        self.minutes = minutes
        self.isOn = isOn
    }
}
