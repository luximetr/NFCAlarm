import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var alarms: [Alarm]
    @State private var isOn: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(alarms) { alarm in
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
                                try? modelContext.save()
                            })
                        )
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle())
                    }
                }.onDelete(perform: deleteItems(offsets:))
            }
            .navigationTitle("Alarms")
            .toolbar {
                Button(action: addItem) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newAlarm = Alarm(id: UUID(), title: "Alarm", hours: 0, minutes: 50, isOn: false)
            modelContext.insert(newAlarm)
            try? modelContext.save()
//            alarms.append(newAlarm)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(alarms[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Alarm.self, inMemory: true)
}
