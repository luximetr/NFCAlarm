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
            SleepPicker()
                .frame(width: 300, height: 300)
        }
        .background(appearance.colors.primaryBackground)
        .titleBackNavigationBar(title: viewModel.localizer.localizeText("navigationTitle")) {
            viewModel.backButtonTapped()
        }
    }
}

struct SleepPicker: View {
    @State private var startAngle: Angle = .degrees(0)    // midnight
    @State private var endAngle: Angle = .degrees(90)     // 3 am
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size / 2
            
            ZStack {
                // Base circle
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                
                // Selected arc
                Circle()
                    .trim(from: startTrim, to: endTrim)
                    .stroke(Color.blue, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                
                // Start handle
                handle(at: startAngle, radius: radius)
                    .gesture(dragGesture(for: .start, radius: radius))
                
                // End handle
                handle(at: endAngle, radius: radius)
                    .gesture(dragGesture(for: .end, radius: radius))
            }
            .frame(width: size, height: size)
        }
    }
    
    // Convert angle to trim value (0...1)
    private var startTrim: CGFloat {
        CGFloat(startAngle.degrees / 360)
    }
    private var endTrim: CGFloat {
        CGFloat(endAngle.degrees / 360)
    }
    
    // Handle circle
    private func handle(at angle: Angle, radius: CGFloat) -> some View {
        let x = cos(angle.radians - .pi/2) * radius
        let y = sin(angle.radians - .pi/2) * radius
        
        return Circle()
            .fill(Color.blue)
            .frame(width: 30, height: 30)
            .offset(x: x, y: y)
    }
    
    // Drag gesture
    private func dragGesture(for type: HandleType, radius: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                let vector = CGVector(dx: value.location.x - radius,
                                      dy: value.location.y - radius)
                let angle = atan2(vector.dy, vector.dx) + .pi/2
                let degrees = (angle * 180 / .pi).truncatingRemainder(dividingBy: 360)
                
                if type == .start {
                    startAngle = .degrees(degrees < 0 ? degrees + 360 : degrees)
                } else {
                    endAngle = .degrees(degrees < 0 ? degrees + 360 : degrees)
                }
            }
    }
    
    enum HandleType {
        case start, end
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
