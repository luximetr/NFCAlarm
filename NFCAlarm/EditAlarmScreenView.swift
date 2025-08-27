import SwiftUI

struct EditAlarmScreenView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var label: String
    @State private var time: Date
    @State private var isOn: Bool
    
    var alarm: Alarm
    
    init(alarm: Alarm) {
        self.alarm = alarm
        self.label = alarm.title ?? ""
        let calendar = Calendar.current
        var date = Date()
        date = calendar.date(bySetting: .hour, value: alarm.hours, of: date) ?? date
        date = calendar.date(bySetting: .minute, value: alarm.minutes, of: date) ?? date
        self.time = date
        self.isOn = alarm.isOn
    }
    
    var body: some View {
        Form {
            Text("Time")
            DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
            Toggle("Enabled", isOn: $isOn)
            TextField(text: $label) {
                Text("Label (optional)")
            }
            Button("Save") {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: time)
                let minute = calendar.component(.minute, from: time)
                let label: String? = self.label.isEmpty ? nil : self.label
                
                alarm.title = label
                alarm.isOn = isOn
                alarm.hours = hour
                alarm.minutes = minute
                
                try? context.save()
                dismiss()
            }
            Button("Delete") {
                context.delete(alarm)
                try? context.save()
                dismiss()
            }
        }
    }
}

#Preview {
    let alarm = Alarm(id: UUID(), title: "Alarm 1", hours: 10, minutes: 15, isOn: true)
    EditAlarmScreenView(alarm: alarm)
        .modelContainer(for: Alarm.self, inMemory: true)
}
