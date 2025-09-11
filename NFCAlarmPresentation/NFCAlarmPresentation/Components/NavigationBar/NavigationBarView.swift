import SwiftUI

struct NavigationBarView<TitleView: View>: View {
    
    @ViewBuilder var content: () -> TitleView
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
            
            content()
            
        }
        .frame(height: 44)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ZStack {
        ScrollView {
            VStack {
                Text("Text")
                Text("Text 2")
                Text("Text 3")
                Text("Text 4")
            }
            .padding(.top, 44)
        }
        NavigationBarView {
            Text("Title")
        }
    }
}
