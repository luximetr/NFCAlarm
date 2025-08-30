import Foundation

extension PresentationViewModel {
    
    // MARK: - Alarms list
    
    func createAlarmsListScreenView() -> AlarmsListScreenView {
        let appearance = CompositeAppearance(colorScheme: .light)
        let viewModel = AlarmsListScreenViewModel()
        viewModel.onAddAlarm = { [weak self] in
            self?.screenPath.append(PresentationAlarmRoute.createAlarm)
        }
        let view = AlarmsListScreenView(appearance: appearance, viewModel: viewModel)
        return view
//        viewModel.onCreateAlarmRequested = { [weak self] in
//            self?.createCreateAlarmScreenView()
//        }
    }
    
    // MARK: - Create alarm
    
    func createCreateAlarmScreenView() -> CreateAlarmScreenView {
        let appearance = CompositeAppearance(colorScheme: .light)
        let viewModel = CreateAlarmScreenViewModel()
        self.createAlarmScreenViewModel = viewModel
        let view = CreateAlarmScreenView(appearance: appearance, viewModel: viewModel)
        return view
    }
}

// MARK: - Route

enum PresentationAlarmRoute: Hashable {
    case alarmsList
    case createAlarm
}
