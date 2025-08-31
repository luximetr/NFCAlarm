import SwiftUI

public struct PresentationView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject var viewModel: PresentationViewModel
    
    public init(viewModel: PresentationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack(path: $viewModel.screenPath) {
            viewModel.createAlarmsListScreenView()
                .navigationDestination(for: PresentationAlarmRoute.self) { route in
                    switch route {
                    case .alarmsList: viewModel.createAlarmsListScreenView()
                    case .createAlarm: viewModel.createCreateAlarmScreenView()
                    case .editAlarm(let alarm): viewModel.createEditAlarmScreenView(alarm: alarm)
                    }
                }
        }
        .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
    }
}

#Preview {
    PresentationView(viewModel: PresentationViewModel())
}
