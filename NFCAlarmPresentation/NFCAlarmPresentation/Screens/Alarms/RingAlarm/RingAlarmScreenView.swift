import SwiftUI

struct RingAlarmScreenView: View {
    
    // MARK: - Init
    
    init(viewModel: RingAlarmScreenViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - ViewModel
    
    @StateObject private var viewModel: RingAlarmScreenViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("Tap NFC tag to stop alarm")
            Button {
                viewModel.startNFC()
            } label: {
                Text("NFC tag")
            }
            .buttonStyle(.borderedProminent)

            Button {
                print("Stop")
            } label: {
                Text("Stop")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                print("Snooze")
            } label: {
                Text("Snooze")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    let viewModel = RingAlarmScreenViewModel()
    return RingAlarmScreenView(viewModel: viewModel)
}
