import SwiftUI

struct NavigationBarImageButton: View {
    
    var image: Image
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}
