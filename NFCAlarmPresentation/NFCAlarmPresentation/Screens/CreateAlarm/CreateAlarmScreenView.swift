import SwiftUI

struct CreateAlarmScreenView: View {
    
    // MARK: - Init
    
    init(viewModel: CreateAlarmScreenViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - ViewModel
    
    private let viewModel: CreateAlarmScreenViewModel
    
    // MARK: - Appearance
    
    @Environment(\.appearance) private var appearance
    
//    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var label = ""
    @State private var time = Date()
    @State private var isOn = true
    
    var body: some View {
        Form {
            Text("Time")
                .foregroundStyle(appearance.colors.primaryText)
                .font(appearance.fonts.body)
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
//                context.insert(newAlarm)
//                try? context.save()
                dismiss()
            }
        }
        
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    CreateAlarmScreenView(
        viewModel: CreateAlarmScreenViewModel()
    )
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
