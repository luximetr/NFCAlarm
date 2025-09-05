import SwiftUI
import SwiftData

struct AlarmsListScreenView: View {
    
    // MARK: - Appearance
    
    @Environment(\.appearance) private var appearance
    
    // MARK: - ViewModel
    
    @StateObject var viewModel: AlarmsListScreenViewModel
    
    // MARK: - Init
    
    init(viewModel: AlarmsListScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Alarms
    
    @State private var path = NavigationPath()

    var body: some View {
        List {
            ForEach(viewModel.alarms) { alarm in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(alarm.hours):\(alarm.minutes)")
                        Text(alarm.name ?? "Alarm")
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
                .onTapGesture {
                    viewModel.editAlarmTapped(alarm)
                }
            }
            .onDelete { indexSet in
                deleteItems(indexSet: indexSet)
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
        .navigationTitle(viewModel.localizer.localizeText("navigationTitle"))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.settingsTapped()
                } label: {
                    Image(systemName: "gear")
                }
            }
            ToolbarItem {
                Button {
                    viewModel.addAlarmTapped()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newAlarm = Alarm(id: UUID(), name: "Alarm", hours: 0, minutes: 50, isOn: false)
//            modelContext.insert(newAlarm)
//            try? modelContext.save()
        }
    }

    private func deleteItems(indexSet: IndexSet) {
        viewModel.alarmDeleteActivated(indexSet)
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(alarms[index])
//            }
//        }
    }
}

#Preview {
    let viewModel = AlarmsListScreenViewModel(locale: Locale(language: .english, scriptCode: nil, regionCode: nil))
    viewModel.onLoadAlarms = {
        return [Alarm(id: UUID(), name: "Alarm 1", hours: 10, minutes: 15, isOn: true)]
    }
    return NavigationStack {
        AlarmsListScreenView(
            viewModel: viewModel
        )
    }
//        .modelContainer(for: Alarm.self, inMemory: false)
}
