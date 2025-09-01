import Foundation

@MainActor
class CreateAlarmScreenViewModel: ObservableObject {
    
    // MARK: - Time
    
    @Published var time = Date()
    
    // MARK: - Name
    
    @Published var name = ""
    
    // MARK: - Create alarm
    
    var onCreateAlarm: ((CreatingAlarm) -> Void)?
    
    func saveAlarmTapped() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        let creatingAlarm = CreatingAlarm(name: name, hour: hour, minute: minute)
        onCreateAlarm?(creatingAlarm)
    }
}
