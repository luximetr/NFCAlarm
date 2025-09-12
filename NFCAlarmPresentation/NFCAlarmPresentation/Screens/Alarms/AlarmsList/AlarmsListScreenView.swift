import SwiftUI
import SwiftData

struct AlarmsListScreenView: View {
    
    // MARK: - Init
    
    init(viewModel: AlarmsListScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - ViewModel
    
    @StateObject var viewModel: AlarmsListScreenViewModel
    
    // MARK: - Appearance
    
    @Environment(\.appearance) private var appearance
    
    // MARK: - Body

    var body: some View {
        List {
            ForEach(viewModel.alarms) { alarm in
                alarmItem(alarm: alarm)
                .onTapGesture {
                    viewModel.editAlarmTapped(alarm)
                }
            }
            .onDelete { indexSet in
                viewModel.alarmDeleteActivated(indexSet)
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(appearance.colors.primaryBackground)
        .titleLeadingTrailingViewNavigationBar(
            title: viewModel.localizer.localizeText("navigationTitle"),
            leadingView: settingsButton,
            trailingView: addButton
        )
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private func settingsButton() -> some View {
        Button {
            viewModel.settingsTapped()
        } label: {
            appearance.images.settings
        }
    }
    
    private func addButton() -> some View {
        Button {
            viewModel.addAlarmTapped()
        } label: {
            appearance.images.plus
        }
    }
    
    private func alarmItem(alarm: Alarm) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(alarm.hours):\(alarm.minutes)")
                    .font(appearance.fonts.body)
                    .foregroundStyle(appearance.colors.primaryText)
                Text(alarm.name ?? "Alarm")
                    .font(appearance.fonts.body)
                    .foregroundStyle(appearance.colors.tertiaryText)
            }
            Spacer()
            Toggle("", isOn: Binding(
                get: { alarm.isOn },
                set: { newValue in
                    viewModel.alarmIsOnTapped(alarm, isOn: newValue)
                })
            )
            .tint(appearance.colors.accent)
            .labelsHidden()
            .toggleStyle(SwitchToggleStyle())
        }
        .listRowBackground(appearance.colors.primaryBackground)
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let viewModel = AlarmsListScreenViewModel(locale: Locale(language: .english, scriptCode: nil, regionCode: nil))
    viewModel.onLoadAlarms = {
        return [Alarm(id: UUID(), name: "Alarm 1", hours: 10, minutes: 15, isOn: true)]
    }
    return NavigationStack {
        AlarmsListScreenView(
            viewModel: viewModel
        )
    }
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
