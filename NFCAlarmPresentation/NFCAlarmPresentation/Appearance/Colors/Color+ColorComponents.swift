import SwiftUI

extension Color {
    
    init(_ appearanceColor: ColorComponents) {
        let colorSpace = Color.convertToColorRGBColorSpace(appearanceColor.colorSpace)
        self.init(
            colorSpace,
            red: appearanceColor.red,
            green: appearanceColor.green,
            blue: appearanceColor.blue,
            opacity: appearanceColor.opacity
        )
    }
    
    private static func convertToColorRGBColorSpace(_ colorSpace: ColorComponents.ColorSpace) -> RGBColorSpace {
        switch colorSpace {
            case .sRGB: return .sRGB
            case .sRGBLinear: return .sRGBLinear
            case .displayP3: return .displayP3
        }
    }
}
