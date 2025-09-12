import SwiftUI

struct BackTitleNavigationBarScreenView<Content: View>: View {
    
    @Environment(\.appearance) private var appearance
    
    var navigationTitle: String = ""
    var backAction: () -> Void
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            
            content()
                .safeAreaPadding(.top, 44)
            
            NavigationBarView {
                HStack {
                    NavigationBarImageButton(image: appearance.images.chevronLeft, action: backAction)
                        .foregroundStyle(appearance.colors.accent)
                        .frame(width: 54, height: 44)
                    Spacer()
                    Text(navigationTitle)
                        .foregroundStyle(appearance.colors.primaryText)
                        .font(appearance.fonts.headline)
                    Spacer()
                    Spacer()
                        .frame(width: 54, height: 44)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct TitleBackNavigationBarModifier: ViewModifier {
    let title: String
    let backAction: () -> Void
    
    func body(content: Content) -> some View {
        BackTitleNavigationBarScreenView(
            navigationTitle: title,
            backAction: backAction,
            content: { content }
        )
    }
}

extension View {
    func titleBackNavigationBar(
        title: String,
        backAction: @escaping () -> Void
    ) -> some View {
        self.modifier(
            TitleBackNavigationBarModifier(
                title: title,
                backAction: backAction
            )
        )
    }
}

#Preview("View") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    BackTitleNavigationBarScreenView(navigationTitle: "Title") {
        print("Back")
    } content: {
        Text("Content")
    }
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}

#Preview("Modifier") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    let appearance = CompositeAppearance(colorScheme: colorScheme)
    Text("Content")
        .titleBackNavigationBar(title: "Title", backAction: {})
        .background(appearance.colors.primaryBackground)
        .environment(\.appearance, appearance)
}
