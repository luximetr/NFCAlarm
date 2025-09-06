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
                    case .createAlarm: viewModel.createCreateAlarmScreenView()
                    case .editAlarm(let alarm): viewModel.createEditAlarmScreenView(alarm: alarm)
                    case .ringAlarm: viewModel.createRingAlarmScreenView()
                    }
                }
                .navigationDestination(for: PresentationSettingsRoute.self) { route in
                    switch route {
                    case .interfaceSettings: viewModel.createInterfaceSettingsScreenView()
                    }
                }
        }
        .tint(viewModel.appearance.colors.accent)
        .environment(\.appearance, viewModel.appearance)
        .onChange(of: colorScheme) {
            viewModel.setColorScheme(colorScheme)
        }
    }
}

#Preview {
    PresentationView(viewModel: PresentationViewModel())
}
