import SwiftUI

class DefaultAppearanceFonts: AppearanceFonts {
    
    var title1: Font {
        return .system(.title, design: .default)
    }
    
    var title2: Font {
        return .system(.title2, design: .default)
    }
    
    var title3: Font {
        return .system(.title3, design: .default)
    }
    
    var body: Font {
        return .system(.body, design: .default)
    }
    
}
