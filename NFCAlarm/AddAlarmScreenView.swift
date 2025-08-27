import SwiftUI

struct AddAlarmScreenView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var label = ""
    @State private var time = Date()
    @State private var isOn = true
    
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
                let newAlarm = Alarm(id: UUID(), title: label, hours: hour, minutes: minute, isOn: isOn)
                context.insert(newAlarm)
                try? context.save()
                dismiss()
            }
        }
    }
}

#Preview {
    AddAlarmScreenView()
        .modelContainer(for: Alarm.self, inMemory: true)
}
