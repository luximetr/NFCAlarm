import Foundation
import NFCAlarmPresentation
import NFCAlarmStorage

typealias PresentationAlarm = NFCAlarmPresentation.Alarm
typealias StorageAlarm = NFCAlarmStorage.Alarm

class AlarmMapper {
    
    static func mapToPresentation(_ alarm: StorageAlarm) -> PresentationAlarm {
        let presentationAlarm = PresentationAlarm(
            id: alarm.id,
            name: alarm.name,
            hours: alarm.hours,
            minutes: alarm.minutes,
            isOn: alarm.isOn
        )
        return presentationAlarm
    }
}
