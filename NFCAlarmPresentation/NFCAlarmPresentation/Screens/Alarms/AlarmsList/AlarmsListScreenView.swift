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
        .background(appearance.colors.primaryBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            settingsButton()
            navigationTitle()
            addButton()
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    @ToolbarContentBuilder
    private func navigationTitle() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(viewModel.localizer.localizeText("navigationTitle"))
                .foregroundStyle(appearance.colors.primaryText)
                .font(appearance.fonts.headline)
        }
    }
    
    @ToolbarContentBuilder
    private func settingsButton() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                viewModel.settingsTapped()
            } label: {
                appearance.images.settings
            }
        }
    }
    
    @ToolbarContentBuilder
    private func addButton() -> some ToolbarContent {
        ToolbarItem {
            Button {
                viewModel.addAlarmTapped()
            } label: {
                appearance.images.plus
            }
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
            .labelsHidden()
            .toggleStyle(SwitchToggleStyle())
        }
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
