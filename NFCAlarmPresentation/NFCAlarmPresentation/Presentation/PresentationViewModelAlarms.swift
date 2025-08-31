import Foundation

extension PresentationViewModel {
    
    // MARK: - Alarms list
    
    func createAlarmsListScreenView() -> AlarmsListScreenView {
        let viewModel = self.alarmsListScreenViewModel ?? AlarmsListScreenViewModel()
        viewModel.onAddAlarm = { [weak self] in
            self?.screenPath.append(PresentationAlarmRoute.createAlarm)
        }
        viewModel.onEditAlarm = { [weak self] alarm in
            self?.screenPath.append(PresentationAlarmRoute.editAlarm(alarm))
        }
        self.alarmsListScreenViewModel = viewModel
        let view = AlarmsListScreenView(viewModel: viewModel)
        return view
    }
    
    // MARK: - Create alarm
    
    func createCreateAlarmScreenView() -> CreateAlarmScreenView {
        let viewModel = self.createAlarmScreenViewModel ?? CreateAlarmScreenViewModel()
        self.createAlarmScreenViewModel = viewModel
        let view = CreateAlarmScreenView(viewModel: viewModel)
        return view
    }
    
    // MARK: - Edit alarm
    
    func createEditAlarmScreenView(alarm: Alarm) -> EditAlarmScreenView {
        let viewModel = self.editAlarmScreenViewModel ?? EditAlarmScreenViewModel()
        self.editAlarmScreenViewModel = viewModel
        let view = EditAlarmScreenView(alarm: alarm, viewModel: viewModel)
        return view
    }
}

// MARK: - Route

enum PresentationAlarmRoute: Hashable {
    case alarmsList
    case createAlarm
    case editAlarm(Alarm)
}
