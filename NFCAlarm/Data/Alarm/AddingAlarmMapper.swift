import NFCAlarmPresentation
import NFCAlarmStorage

typealias PresentationCreatingAlarm = NFCAlarmPresentation.CreatingAlarm
typealias StorageCreatingAlarm = NFCAlarmStorage.CreatingAlarm

class CreatingAlarmMapper {
    
    static func mapToStorage(_ alarm: PresentationCreatingAlarm) -> StorageCreatingAlarm {
        let storageAlarm = StorageCreatingAlarm(
            name: alarm.name,
            hours: alarm.hour,
            minutes: alarm.minute,
            isOn: true
        )
        return storageAlarm
    }
}
