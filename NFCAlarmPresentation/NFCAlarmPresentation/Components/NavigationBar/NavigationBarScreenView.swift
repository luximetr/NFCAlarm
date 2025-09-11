import SwiftUI

struct NavigationBarScreenView<Content: View>: View {
    
    @Environment(\.appearance) private var appearance
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            content()
                .safeAreaPadding(.top, 44)
            
            NavigationBarView {
            }
        }
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    NavigationBarScreenView {
        Text("Content")
    }
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
