import Foundation

extension PresentationViewModel {
    
    // MARK: - Alarms list
    
    func createAlarmsListScreenView() -> AlarmsListScreenView {
        let viewModel = self.alarmsListScreenViewModel ?? AlarmsListScreenViewModel(locale: locale)
        viewModel.onAddAlarm = { [weak self] in
            self?.screenPath.append(PresentationAlarmRoute.createAlarm)
        }
        viewModel.onEditAlarm = { [weak self] alarm in
            self?.screenPath.append(PresentationAlarmRoute.editAlarm(alarm))
        }
        viewModel.onUpdateAlarm = { [weak self] editingAlarm in
            guard let self = self else { throw Error.weakSelf }
            return try await self.editAlarm(editingAlarm)
        }
        viewModel.onDeleteAlarm = { [weak self] alarm in
            guard let self = self else { throw Error.weakSelf }
            try await self.deleteAlarm(alarm)
        }
        viewModel.onLoadAlarms = { [weak self] in
            try await self?.getAllAlarms?() ?? []
        }
        self.alarmsListScreenViewModel = viewModel
        let view = AlarmsListScreenView(viewModel: viewModel)
        return view
    }
    
    // MARK: - Create alarm
    
    func createCreateAlarmScreenView() -> CreateAlarmScreenView {
        let viewModel = self.createAlarmScreenViewModel ?? CreateAlarmScreenViewModel()
        self.createAlarmScreenViewModel = viewModel
        viewModel.onCreateAlarm = { [weak self] creatingAlarm in
            Task(priority: .userInitiated) {
                do {
                    try await self?.createAlarm?(creatingAlarm)
                } catch {
                    print(error)
                }
            }
        }
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

enum PresentationAlarmRoute: Hashable, Equatable {
    case createAlarm
    case editAlarm(Alarm)
    
    static func == (lhs: PresentationAlarmRoute, rhs: PresentationAlarmRoute) -> Bool {
        switch (lhs, rhs) {
        case (.createAlarm, .createAlarm): return true
        case (.editAlarm(let lhsValue), .editAlarm(let rhsValue)): return lhsValue == rhsValue
        default: return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}
