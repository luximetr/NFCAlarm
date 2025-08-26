import SwiftUI
import SwiftData

struct Alarm: Identifiable {
    let id: UUID
    let title: String?
    let hours: Int
    let minutes: Int
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var alarms: [Alarm]
    @State private var isOn: Bool = false

    var body: some View {
        List {
            ForEach(alarms) { alarm in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(alarm.hours):\(alarm.minutes)")
                        Text(alarm.title ?? "No title")
                    }
                    Spacer()
                    Toggle("", isOn: $isOn)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle())
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
//                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView(alarms: [
        .init(id: UUID(), title: "Alarm 1", hours: 00, minutes: 15),
        .init(id: UUID(), title: "Alarm 2", hours: 00, minutes: 30),
        .init(id: UUID(), title: "Alarm 3", hours: 00, minutes: 45)
    ])
        .modelContainer(for: Item.self, inMemory: true)
}
