import SwiftUI

struct CreateAlarmScreenView: View {
    
    // MARK: - Init
    
    init(viewModel: CreateAlarmScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - ViewModel
    
    @StateObject var viewModel: CreateAlarmScreenViewModel
    
    // MARK: - Appearance
    
    @Environment(\.appearance) private var appearance
    
//    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Text("Time")
                .foregroundStyle(appearance.colors.primaryText)
                .font(appearance.fonts.body)
            DatePicker("", selection: $viewModel.time, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
            TextField(text: $viewModel.name) {
                Text("Label (optional)")
            }
            Button("Save") {
//                let calendar = Calendar.current
//                let hour = calendar.component(.hour, from: time)
//                let minute = calendar.component(.minute, from: time)
//                let label: String? = self.label.isEmpty ? nil : self.label
//                let newAlarm = Alarm(id: UUID(), title: label, hours: hour, minutes: minute, isOn: isOn)
//                context.insert(newAlarm)
//                try? context.save()
                viewModel.saveAlarmTapped()
                dismiss()
            }
        }
        .navigationTitle("Create alarm")
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    CreateAlarmScreenView(
        viewModel: CreateAlarmScreenViewModel()
    )
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
