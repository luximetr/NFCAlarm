import NFCAlarmPresentation
import NFCAlarmStorage

typealias PresentationCreatingAlarm = NFCAlarmPresentation.CreatingAlarm
typealias StorageCreatingAlarm = NFCAlarmStorage.CreatingAlarm

class CreatingAlarmMapper {
    
    static func mapToStorage(_ presentationCreatingAlarm: PresentationCreatingAlarm) -> StorageCreatingAlarm {
        let alarm = StorageCreatingAlarm(
            name: presentationCreatingAlarm.name
        )
        return alarm
    }
}
