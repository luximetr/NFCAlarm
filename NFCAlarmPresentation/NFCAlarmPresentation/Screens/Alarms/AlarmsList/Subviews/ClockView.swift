import SwiftUI

struct ClockView: View {
    
    // MARK: - Time
    
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MARK: - Appearance
    
    @Environment(\.appearance) private var appearance
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size / 2
            
            ZStack {
                // Background ring
                Circle()
                    .stroke(appearance.colors.tertiaryText, lineWidth: size * 0.015)
                
                // Hour ticks
                ForEach(0..<12) { tick in
                    Rectangle()
                        .fill(appearance.colors.secondaryText)
                        .frame(width: 2, height: size * 0.08)
                        .offset(y: -radius + size * 0.02)
                        .rotationEffect(.degrees(Double(tick) / 12 * 360))
                }
                
                // Hour hand
                RoundedRectangle(cornerRadius: size * 0.02)
                    .fill(appearance.colors.primaryText)
                    .frame(width: size * 0.04, height: radius * 0.5)
                    .offset(y: -radius * 0.25)
                    .rotationEffect(hourAngle)
                    .shadow(radius: 2)
                
                // Minute hand
                RoundedRectangle(cornerRadius: size * 0.02)
                    .fill(appearance.colors.primaryText)
                    .frame(width: size * 0.03, height: radius * 0.7)
                    .offset(y: -radius * 0.35)
                    .rotationEffect(minuteAngle)
                    .shadow(radius: 2)
                
                // Second hand
                RoundedRectangle(cornerRadius: size * 0.01)
                    .fill(appearance.colors.accent)
                    .frame(width: size * 0.015, height: radius * 0.9)
                    .offset(y: -radius * 0.45)
                    .rotationEffect(secondAngle)
                
                // Center dot
                Circle()
                    .fill(appearance.colors.primaryText)
                    .frame(width: size * 0.06, height: size * 0.06)
                    .shadow(radius: 1)
            }
            .frame(width: size, height: size)
            .onReceive(timer) { input in
                now = input
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private var hourAngle: Angle {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: now)
        let hours = Double(comps.hour ?? 0) + Double(comps.minute ?? 0) / 60
        return .degrees(hours / 12 * 360)
    }
    
    private var minuteAngle: Angle {
        let comps = Calendar.current.dateComponents([.minute, .second], from: now)
        let minutes = Double(comps.minute ?? 0) + Double(comps.second ?? 0) / 60
        return .degrees(minutes / 60 * 360)
    }
    
    private var secondAngle: Angle {
        let comps = Calendar.current.dateComponents([.second], from: now)
        let seconds = Double(comps.second ?? 0)
        return .degrees(seconds / 60 * 360)
    }
}

// Helper: round Date to nearest multiple of interval
extension Date {
    func rounded(to interval: TimeInterval) -> Date {
        Date(timeIntervalSince1970: (timeIntervalSince1970 / interval).rounded(.down) * interval)
    }
}

#Preview {
    @Previewable @Environment(\.colorScheme) var colorScheme
    VStack(spacing: 20) {
        ClockView()
            .frame(width: 200, height: 200)
            .background(ignoresSafeAreaEdges: .all)
        Spacer()
            .frame(height: 20)
        ClockView()
            .frame(width: 50, height: 50)
            .background(ignoresSafeAreaEdges: .all)
    }
    .environment(\.appearance, CompositeAppearance(colorScheme: colorScheme))
}
