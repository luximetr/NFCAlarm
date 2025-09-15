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
        ScrollView {
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
            MinutePickerView()
                .frame(width: 300, height: 300)
            
//            CircularStack(count: 24, radius: 120) { i, _ in
//                Text(String(format: "%02d", i))
//                    .font(.headline)
//            }
        }
        .background(appearance.colors.primaryBackground)
        .titleBackNavigationBar(title: viewModel.localizer.localizeText("navigationTitle")) {
            viewModel.backButtonTapped()
        }
    }
}

struct CircularPicker: View {
    @State private var rotation: Angle = .zero
    
    let values = Array(0..<60)
    
    var body: some View {
        ZStack {
            // Circle with numbers
            ForEach(values, id: \.self) { i in
                Text("\(i)")
                    .font(.caption)
                    .rotationEffect(.degrees(Double(i) / 60.0 * 360))
                    .offset(y: -120) // radius
                    .rotationEffect(-rotation) // keep upright when rotating
            }
        }
        .rotationEffect(rotation) // rotate the whole circle
        .gesture(
            RotationGesture()
                .onChanged { value in
                    rotation = value
                }
        )
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
