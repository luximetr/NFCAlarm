import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var alarms: [Alarm]
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(alarms) { alarm in
                    NavigationLink(destination: EditAlarmScreenView(alarm: alarm)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(alarm.hours):\(alarm.minutes)")
                                Text(alarm.title ?? "No title")
                            }
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: { alarm.isOn },
                                set: { newValue in
                                    alarm.isOn = newValue
//                                    try? modelContext.save()
                                })
                            )
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle())
                        }
//                        .onTapGesture {
//                            path.append("edit")
//                            print("Tap on alarm")
//                        }
                    }
                }.onDelete(perform: deleteItems(offsets:))
            }
            .navigationTitle("Alarms")
            .toolbar {
                Button {
                    path.append("add")
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "add" {
                    AddAlarmScreenView()
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newAlarm = Alarm(id: UUID(), title: "Alarm", hours: 0, minutes: 50, isOn: false)
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
    ContentView()
        .modelContainer(for: Alarm.self, inMemory: false)
}
