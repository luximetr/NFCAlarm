import SwiftUI

struct RingAlarmScreenView: View {
    
    var body: some View {
        VStack {
            Text("Tap NFC tag to stop alarm")
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
    RingAlarmScreenView()
}
