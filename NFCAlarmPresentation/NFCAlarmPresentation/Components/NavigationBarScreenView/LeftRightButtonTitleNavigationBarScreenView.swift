import SwiftUI

struct LeftRightButtonTitleNavigationBarScreenView<Content: View, NavigationLeft: View, NavigationRight: View>: View {
    
    @Environment(\.appearance) private var appearance
    
    var navigationTitle: String = ""
    @ViewBuilder var navigationLeadingView: () -> NavigationLeft
    @ViewBuilder var navigationTrailingView: () -> NavigationRight
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            
            content()
                .safeAreaPadding(.top, 44)
            
            NavigationBarView {
                HStack {
                    navigationLeadingView()
                        .foregroundStyle(appearance.colors.accent)
                        .frame(width: 54, height: 44)
                    Spacer()
                    Text(navigationTitle)
                        .foregroundStyle(appearance.colors.primaryText)
                        .font(appearance.fonts.headline)
                    Spacer()
                    navigationTrailingView()
                        .foregroundStyle(appearance.colors.accent)
                        .frame(width: 54, height: 44)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct TitleLeadingTrailingViewNavigationBarTitleModifier<NavigationLeftIcon: View, NavigationRightIcon: View>: ViewModifier {
    
    let title: String
    @ViewBuilder var leadingView: () -> NavigationLeftIcon
    @ViewBuilder var trailingView: () -> NavigationRightIcon
    
    func body(content: Content) -> some View {
        LeftRightButtonTitleNavigationBarScreenView(
            navigationTitle: title,
            navigationLeadingView: leadingView,
            navigationTrailingView: trailingView,
            content: { content }
        )
    }
}

extension View {
    func titleLeadingTrailingViewNavigationBar(
        title: String,
        leadingView: @escaping () -> some View,
        trailingView: @escaping () -> some View
    ) -> some View {
        self.modifier(
            TitleLeadingTrailingViewNavigationBarTitleModifier(
                title: title,
                leadingView: leadingView,
                trailingView: trailingView
            )
        )
    }
}

#Preview("View") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    LeftRightButtonTitleNavigationBarScreenView(
        navigationTitle: "Title",
        navigationLeadingView: {
            NavigationBarSystemIconButton(iconName: "chevron.left", action: {})
        },
        navigationTrailingView: {
            NavigationBarSystemIconButton(iconName: "gear", action: {})
        },
        content: {
            Text("Content")
        }
    )
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}

#Preview("Modifier") {
    @Previewable @Environment(\.colorScheme) var colorScheme
    Text("Content")
    .titleLeadingTrailingViewNavigationBar(
        title: "Title",
        leadingView: { NavigationBarSystemIconButton(iconName: "chevron.left", action: {}) },
        trailingView: { NavigationBarSystemIconButton(iconName: "gear", action: {}) }
    )
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
