import SwiftUI

struct NavigationBarView<TitleView: View>: View {
    
    @Environment(\.appearance) private var appearance
    
    @ViewBuilder var content: () -> TitleView
    
    var body: some View {
        ZStack {
            BlurView(style: .systemUltraThinMaterialLight)
                .ignoresSafeArea(edges: .top)
                
            content()
            
        }
        .frame(height: 44)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview("List") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let appearance = CompositeAppearance(colorScheme: .light)
    List {
        Text("Item")
            .foregroundStyle(.white)
            .listRowBackground(Color.blue)
    }
    .scrollContentBackground(.hidden)
    .background(appearance.colors.primaryBackground)
    .titleNavigationBar(title: "Title")
    .environment(\.appearance, appearance)
}
