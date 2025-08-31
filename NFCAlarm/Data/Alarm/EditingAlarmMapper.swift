import NFCAlarmPresentation
import NFCAlarmStorage

typealias PresentationEditingAlarm = NFCAlarmPresentation.EditingAlarm
typealias StorageEditingAlarm = NFCAlarmStorage.EditingAlarm

class EditingAlarmMapper {
    
    static func mapToStorage(_ alarm: PresentationEditingAlarm) -> StorageEditingAlarm {
        let storageAlarm = StorageEditingAlarm(
            id: alarm.id,
            name: alarm.name,
            hours: alarm.hours,
            minutes: alarm.minutes,
            isOn: alarm.isOn
        )
        return storageAlarm
    }
}
