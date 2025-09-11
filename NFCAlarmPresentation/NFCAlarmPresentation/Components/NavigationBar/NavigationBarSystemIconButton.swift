import SwiftUI

struct NavigationBarSystemIconButton: View {
    
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}
