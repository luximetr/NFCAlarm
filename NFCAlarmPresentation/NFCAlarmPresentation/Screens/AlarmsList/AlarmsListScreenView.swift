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
        List(viewModel.alarms) { alarm in
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
//        List(viewModel.alarms) { alarm in
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("\(alarm.hours):\(alarm.minutes)")
//                    Text(alarm.title ?? "No title")
//                }
//                Spacer()
//                Toggle("", isOn: Binding(
//                    get: { alarm.isOn },
//                    set: { newValue in
//                        alarm.isOn = newValue
////                                    try? modelContext.save()
//                    })
//                )
//                .labelsHidden()
//                .toggleStyle(SwitchToggleStyle())
//            }
//            .onTapGesture {
////                viewModel.editAlarmTapped(alarm)
//            }
////            .onDelete(perform: deleteItems(offsets:))
//        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
        .navigationTitle("Alarms")
        .toolbar {
            Button {
                viewModel.addAlarmTapped()
//                path.append(PresentationAlarmRoute.createAlarm)
            } label: {
                Image(systemName: "plus")
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
//                modelContext.delete(alarms[index])
            }
        }
    }
}

#Preview {
    let viewModel = AlarmsListScreenViewModel()
    viewModel.onLoadAlarms = {
        return [Alarm(id: UUID(), name: "Alarm 1", hours: 10, minutes: 15, isOn: true)]
    }
    return AlarmsListScreenView(
        viewModel: viewModel
    )
//        .modelContainer(for: Alarm.self, inMemory: false)
}
