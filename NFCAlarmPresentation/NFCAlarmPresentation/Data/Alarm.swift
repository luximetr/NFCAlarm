import Foundation
import SwiftData

@Model
final class Alarm: Identifiable {
    var id: UUID
    var title: String?
    var hours: Int
    var minutes: Int
    var isOn: Bool
    
    init(id: UUID, title: String?, hours: Int, minutes: Int, isOn: Bool) {
        self.id = id
        self.title = title
        self.hours = hours
        self.minutes = minutes
        self.isOn = isOn
    }
}
