import Foundation
import SwiftUI

struct CompositeAppearance: Appearance {
    let colors: AppearanceColors
    
    init(colors: AppearanceColors) {
        self.colors = colors
    }
    
    init(colorScheme: ColorScheme) {
        colors = CompositeAppearance.createColors(colorScheme: colorScheme)
    }
    
    private static func createColors(colorScheme: ColorScheme) -> AppearanceColors {
        switch colorScheme {
            case .light: return LightAppearanceColors()
            case .dark: return DarkAppearanceColors()
            default: return LightAppearanceColors()
        }
    }
}
