import SwiftUI

private struct TitleNavigationBarScreenView<Content: View>: View {
    
    @Environment(\.appearance) private var appearance
    
    var title: String = ""
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            
            content()
                .safeAreaPadding(.top, 44)
            
            NavigationBarView {
                Text(title)
                    .foregroundStyle(appearance.colors.primaryText)
                    .font(appearance.fonts.headline)
            }
        }
    }
}

struct TitleNavigationBarTitleModifier: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        TitleNavigationBarScreenView(title: title, content: { content })
    }
}

extension View {
    func titleNavigationBar(
        title: String
    ) -> some View {
        self.modifier(TitleNavigationBarTitleModifier(title: title))
    }
}

#Preview("Scrollable") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    TitleNavigationBarScreenView(title: "Title") {
        ScrollView {
            ZStack {
                Color.blue
                Text("Scrollable")
            }
        }
    }
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}

#Preview("Content") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let appearance = CompositeAppearance(colorScheme: colorScheme)
    TitleNavigationBarScreenView(title: "Title") {
        Text("Content")
    }
    .background(appearance.colors.primaryBackground)
    .environment(\.appearance, appearance)
}

#Preview("List") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    TitleNavigationBarScreenView(title: "Title") {
        List {
            Text("Item")
                .foregroundStyle(.red)
        }
        .scrollContentBackground(.hidden)
        .background(.blue)
    }
    .background(.blue)
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
