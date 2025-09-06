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
    
    // MARK: - Body
    
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
            Button(viewModel.localizer.localizeText("continueButtonTitle")) {
                viewModel.saveAlarmTapped()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            navigationTitle()
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
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let viewModel = CreateAlarmScreenViewModel(locale: Locale(language: .english, scriptCode: nil, regionCode: nil))
    
    return NavigationStack {
        CreateAlarmScreenView(
            viewModel: viewModel
        )
    }
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
