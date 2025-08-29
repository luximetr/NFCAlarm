import Foundation

struct ColorComponents {
    
    let colorSpace: ColorSpace
    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double
    
    init(_ colorSpace: ColorSpace = .sRGB, red: Double, green: Double, blue: Double, opacity: Double = 1) {
        self.colorSpace = colorSpace
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
    
    enum ColorSpace {
        case sRGB
        case sRGBLinear
        case displayP3
    }
}
