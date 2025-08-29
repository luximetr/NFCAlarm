import SwiftUI

public struct PresentationView: View {
    
    var viewModel: PresentationViewModel
    
    public init(viewModel: PresentationViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        return AlarmsListScreenView()
    }
}

#Preview {
    PresentationView(viewModel: PresentationViewModel())
}
