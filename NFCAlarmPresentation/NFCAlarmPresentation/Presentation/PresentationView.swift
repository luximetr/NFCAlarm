import SwiftUI

public struct PresentationView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var viewModel: PresentationViewModel
    
    public init(viewModel: PresentationViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        let appearance = CompositeAppearance(colorScheme: colorScheme)
        return AlarmsListScreenView(appearance: appearance)
    }
}

#Preview {
    PresentationView(viewModel: PresentationViewModel())
}
