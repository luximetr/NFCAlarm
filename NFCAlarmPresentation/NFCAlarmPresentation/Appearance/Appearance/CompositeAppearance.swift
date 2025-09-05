import Foundation
import SwiftUI

struct CompositeAppearance: Appearance {
    
    let colors: AppearanceColors
    let fonts: AppearanceFonts
    
    init(colors: any AppearanceColors, fonts: any AppearanceFonts) {
        self.colors = colors
        self.fonts = fonts
    }
    
    init(colorScheme: ColorScheme, fonts: any AppearanceFonts) {
        self.colors = CompositeAppearance.createColors(colorScheme: colorScheme)
        self.fonts = fonts
    }
    
    init(colorScheme: ColorScheme) {
        self.init(colorScheme: colorScheme, fonts: DefaultAppearanceFonts())
    }
    
    init(appearanceSetting: AppearanceSetting, colorScheme: ColorScheme) {
        switch appearanceSetting {
        case .light:
            self.init(colorScheme: .light)
        case .dark:
            self.init(colorScheme: .dark)
        case .system:
            self.init(colorScheme: colorScheme)
        }
    }
    
    private static func createColors(colorScheme: ColorScheme) -> AppearanceColors {
        switch colorScheme {
            case .light: return LightAppearanceColors()
            case .dark: return DarkAppearanceColors()
            default: return LightAppearanceColors()
        }
    }
}
