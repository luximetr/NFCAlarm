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
            CircularMinutePicker()
            
            RotatingMinuteDial()
        }
        .background(appearance.colors.primaryBackground)
        .titleBackNavigationBar(title: viewModel.localizer.localizeText("navigationTitle")) {
            viewModel.backButtonTapped()
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

struct CircularMinutePicker: View {
    @State private var selectedMinute: Int = 0
    @State private var selectedHour: Int = 12

    let radius: CGFloat = 150

    var body: some View {
        ZStack {
            // Dial ticks
            ForEach(0..<60) { minute in
                let angle = Angle.degrees(Double(minute) * 6) // 360 / 60
                VStack {
                    Text(String(format: "%02d", minute))
                        .font(.caption)
                        .foregroundColor(minute == selectedMinute ? .white : .gray)
                        .rotationEffect(-angle) // keep upright
                    Spacer()
                }
                .rotationEffect(angle)
            }
            .frame(width: radius * 2, height: radius * 2)

            // Center (Hour + Selected minute)
            HStack {
                Text("\(selectedHour)")
                    .font(.largeTitle)
                Text(String(format: "%02d", selectedMinute))
                    .font(.largeTitle)
            }
            .foregroundColor(.white)
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    let dx = value.location.x - radius
                    let dy = value.location.y - radius
                    let angle = atan2(dy, dx) * 180 / .pi
                    let normalized = (angle < 0 ? angle + 360 : angle)
                    selectedMinute = Int(normalized / 6) % 60
                }
        )
        .frame(width: radius * 2, height: radius * 2)
        .background(Color.black.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct RotatingMinuteDial: View {
    @State private var rotation: Double = 0.0
    @State private var selectedMinute: Int = 0
    @State private var selectedHour: Int = 12

    let radius: CGFloat = 150

    var body: some View {
        ZStack {
            // Circle of minutes
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: radius * 2, height: radius * 2)
                .overlay(
                    ZStack {
                        ForEach(0..<60) { minute in
                            let angle = Angle.degrees(Double(minute) * 6)
                            VStack {
                                Text(String(format: "%02d", minute))
                                    .font(.caption)
                                    .foregroundColor(minute == selectedMinute ? .white : .gray)
                                    .rotationEffect(-angle) // keep upright
                                Spacer()
                            }
                            .rotationEffect(angle)
                        }
                    }
                    .frame(width: radius * 2, height: radius * 2)
                    .rotationEffect(.degrees(rotation)) // whole dial rotates
                )

            // Fixed "selection window" in center
            VStack {
                Text("\(selectedHour)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text(String(format: "%02d", selectedMinute))
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    let dx = value.location.x - radius
                    let dy = value.location.y - radius
                    let angle = atan2(dy, dx) * 180 / .pi
                    rotation = -angle // rotate dial
                    // Map rotation to minute
                    let normalized = (angle < 0 ? angle + 360 : angle)
                    selectedMinute = (Int(normalized / 6) + 15) % 60
                }
        )
        .frame(width: radius * 2, height: radius * 2)
        .background(Color.black.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
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
