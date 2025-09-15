import SwiftUI

@available(iOS 18, *)
struct WheelPickerView<Label: View>: View {
    var range: ClosedRange<Int>
    @Binding var selectedValue: Int
    var config: WheelPickerConfig = .init()
    @ViewBuilder var label: (Int) -> Label
    @State private var activePosition: Int?
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let width = size.width - (config.strokeStyle.lineWidth)
            let dia = min(max(width, size.height), width)
            let radius = dia / 2
            
            WheelPath(size, radius: radius)
                .stroke(config.strokeColor, style: config.strokeStyle)
                .overlay {
                    wheelPickerScrollView(size: size, radius: radius)
                }
                .compositingGroup()
                .offset(y: -config.strokeStyle.lineWidth / 2)
        }
        .frame(height: config.height)
        .task {
            guard activePosition == nil else { return }
            activePosition = selectedValue
        }
        .onChange(of: activePosition) { oldValue, newValue in
            if let newValue, selectedValue != newValue {
                selectedValue = newValue
            }
        }
        .onChange(of: selectedValue) { oldValue, newValue in
            if activePosition != newValue {
                activePosition = newValue
            }
        }
    }
    
    func wheelPickerScrollView(size: CGSize, radius: CGFloat) -> some View {
        let wheelShape = WheelPath(size, radius: radius)
            .strokedPath(config.strokeStyle)
        
        return ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(ticks, id: \.self) { tick in
                    TickView(tick, size: size, radius: radius)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled(true)
        .safeAreaPadding(.horizontal, (size.width - 8) / 2)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
        .scrollPosition(id: $activePosition, anchor: .center)
        .clipShape(wheelShape)
        .contentShape(wheelShape)
        .background(.red)
        .overlay(alignment: .bottom) {
            let strokeWidth = config.strokeStyle.lineWidth
            let halfStrokeWidth = strokeWidth / 2
            
            VStack(spacing: -5) {
                Capsule()
                    .fill(config.activeTint)
                    .frame(width: 5, height: strokeWidth)
                
                Circle()
                    .fill(config.activeTint)
                    .frame(width: 10, height: 10)
            }
            .offset(y: -radius + halfStrokeWidth)
        }
        .overlay(alignment: .bottom) {
            if let activePosition {
                label(activePosition)
            }
        }
    }
    
    @ViewBuilder
    func TickView(_ value: Int, size: CGSize, radius: CGFloat) -> some View {
        let strokeWidth = config.strokeStyle.lineWidth
        let halfStrokeWidth = strokeWidth / 2
        let isLargeTick = (ticks.firstIndex(of: value) ?? 0) % config.largeTickFrequency == 0
        
        GeometryReader { proxy in
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            let midX = proxy.frame(in: .scrollView(axis: .horizontal)).midX
            let halfWidth = size.width / 2
            
            let progress = max(min(midX / halfWidth, 1), -1)
            let rotation = Angle(degrees: progress * 100)
            
            Capsule()
                .fill(config.inactiveTint)
                .offset(y: -radius + halfStrokeWidth)
                .rotationEffect(rotation, anchor: .bottom)
                .offset(x: -minX)
        }
        .frame(width: 3, height: isLargeTick ? (strokeWidth - 10) : halfStrokeWidth)
        .frame(width: 8, alignment: .leading)
    }
    
    func WheelPath(_ size: CGSize, radius: CGFloat) -> Path {
        return Path { path in
            path.addArc(
                center: .init(x: size.width / 2, y: size.height),
                radius: radius,
                startAngle: .degrees(180),
                endAngle: .degrees(0),
                clockwise: false
            )
        }
    }
    
    var ticks: [Int] {
        stride(from: range.lowerBound, through: range.upperBound + 1, by: 1).compactMap({ $0 })
    }
    
    struct WheelPickerConfig {
        var activeTint: Color = .primary
        var inactiveTint: Color = Color.gray
        var largeTickFrequency: Int = 10
        var strokeStyle: StrokeStyle = .init(
            lineWidth: 50,
            lineCap: .round,
            lineJoin: .round
        )
        var strokeColor: Color = .black.opacity(0.1)
        var height: CGFloat = 200
    }
}

struct MinutePickerView: View {
    
    var minutes = Array(1...60)
    @State private var scrollOffset: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    @State private var scrollViewHeight: CGFloat = 0

//    @State private var angle: Double = 0
    
    var body: some View {
        GeometryReader { bodyGeometry in
            let size = bodyGeometry.size
            let width = size.width
            let height = size.height
            let midY = height / 2
            let dia = min(max(width, size.height), width)
            let radius: CGFloat = 200
            let radiusOffset: CGFloat = 100
            let circleCenterY = height / 2
//            let shape = shapePath(size: size, radius: radius)
            
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(minutes, id: \.self) { minute in
                        GeometryReader { proxy in
                            let size = proxy.size
                            let midY = proxy.frame(in: .scrollView(axis: .vertical)).midY
                            
                            let positionY = midY - circleCenterY
                            // horizontal offset based on sine
                            let xOffset = sqrt(pow(radius, 2) - pow(positionY, 2)) - radiusOffset
                            let asin1 = asin((circleCenterY - positionY) / radius)
                            
                            let rotationAngle = Angle(degrees: asin1)
                            
                            return Text("- \(minute)")
                                .background(Color.blue.opacity(0.3))
                                .cornerRadius(8)
                                .rotationEffect(rotationAngle)
                                .offset(x: xOffset)
                        }
                    }
                }
                .padding(.vertical, circleCenterY)
            }
            .frame(width: width)
            .scrollIndicators(.hidden)
//            .clipShape(shape)
//            .contentShape(shape)
        }
        .background(.gray)
    }
        
    func shapePath(size: CGSize, radius: CGFloat) -> Path {
        return Path { path in
            path.addArc(
                center: .init(x: size.width / 2, y: size.height / 2),
                radius: radius,
                startAngle: .degrees(180),
                endAngle: .degrees(0),
                clockwise: false
            )
        }
    }
}

struct CircularLayout: Layout {
    var radius: CGFloat = 100
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        // Stack size = max width × total height
        let width = proposal.width ?? 200
        let height = subviews.reduce(0) { $0 + ($1.sizeThatFits(.unspecified).height) }
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        var y: CGFloat = bounds.minY
        
        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            
            // Map index to angle
            let angle = CGFloat(index) * .pi / 8   // adjust divisor for curve density
            
            // Horizontal offset using sine
            let xOffset = sin(angle) * radius
            
            let point = CGPoint(
                x: bounds.midX - size.width / 2 + xOffset,
                y: y
            )
            
            subview.place(
                at: point,
                proposal: ProposedViewSize(width: size.width, height: size.height)
            )
            
            y += size.height
        }
    }
}

struct CircularStack: View {
    var range: ClosedRange<Int>
    private var count: Int { range.upperBound - range.lowerBound + 1 }
    let radius: CGFloat
    
    @GestureState private var gestureState: CGFloat = 0
    @State private var rotation: Angle = .zero
    @State private var lastDragAngle: Angle = .zero
    @State private var lastDragTime: Date = .now
    @State private var lastDragValue: CGFloat = 0
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            ForEach(range, id: \.self) { index in
                let baseAngle = Double(index) / Double(count) * 360
                let totalAngle = baseAngle + rotation.degrees
                let normalized = (totalAngle.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
                
                let isSelected = abs(normalized - 0) < (360 / Double(count)) / 2 // nearest to right side
                
                Text("\(index)")
                    .font(.body)
                    .rotationEffect(.degrees(-90))
                    .offset(y: -radius)
                    .rotationEffect(.degrees(-baseAngle))
                    .foregroundStyle(index == 0 ? Color.red : Color.black)
            }
        }
        .frame(width: radius * 2, height: radius * 2)
        .padding()
        .rotationEffect(rotation)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let vector = CGVector(dx: value.location.x - radius,
                                          dy: value.location.y - radius)
                    let angle = atan2(vector.dy, vector.dx)
                    
                    let startVector = CGVector(dx: value.startLocation.x - radius,
                                               dy: value.startLocation.y - radius)
                    let startAngle = atan2(startVector.dy, startVector.dx)
                    
                    let delta = Angle(radians: Double(angle - startAngle))
                    rotation = lastDragAngle + delta
                    
                    lastDragTime = .now
                    lastDragValue = angle
                }
                .onEnded { value in
                    let vectorDx = value.predictedEndLocation.x + value.velocity.width - radius
                    let vectorDy = value.predictedEndLocation.y + value.velocity.height - radius
                    let vector = CGVector(dx: vectorDx, dy: vectorDy)
                    let angle = atan2(vector.dy, vector.dx)
                    
                    let startVector = CGVector(
                        dx: value.startLocation.x - radius,
                        dy: value.startLocation.y - radius
                    )
                    let startAngle = atan2(startVector.dy, startVector.dx)
                    
                    let delta = Angle(radians: Double(angle - startAngle))
                    
                    withAnimation(.easeOut(duration: 1)) {
                        rotation = lastDragAngle + delta
                    }

                    lastDragAngle = rotation
                    updateSelection()
                }
        )
    }
    
    private func updateSelection() {
        var closestIndex = 0
        var minDistance = Double.greatestFiniteMagnitude
        
        for i in range {
            let baseAngle = Double(i) / Double(count) * 360
            let totalAngle = baseAngle + rotation.degrees
            let normalized = (totalAngle.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
            
            let distance = min(abs(normalized - 0), 360 - abs(normalized - 0)) // distance to right side
            if distance < minDistance {
                minDistance = distance
                closestIndex = i
            }
        }
        
        selectedIndex = closestIndex
//        print("Selected:", selectedIndex)
    }
}

struct DragScrollView<Content: View>: View {
    let content: Content
    @GestureState private var dragOffset: CGFloat = 0
    @State private var position: CGFloat = 0
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
                .offset(y: position + dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.height
                        }
                        .onEnded { value in
                            position += value.translation.height
                            
                            // simple "inertia" effect
                            withAnimation(.easeOut(duration: 1.5)) {
                                position += value.predictedEndTranslation.height - value.translation.height
                            }
                        }
                )
        }
    }
}

/// Helper to run CADisplayLink in SwiftUI
class DisplayLinkProxy {
    private let callback: (Double) -> Void
    private var lastTimestamp: CFTimeInterval?
    
    init(_ callback: @escaping (Double) -> Void) {
        self.callback = callback
    }
    
    @objc func tick(_ link: CADisplayLink) {
        if let last = lastTimestamp {
            let dt = link.timestamp - last
            callback(dt)
        }
        lastTimestamp = link.timestamp
    }
}

#Preview {
    @Previewable @State var selectedValue: Int = 50
    GeometryReader { geometry in
        ZStack {
            CircularStack(range: 1...60, radius: 180)
            CircularStack(range: 1...12, radius: 90)
        }
        .position(x: 0, y: geometry.size.height / 2)
    }
    
}
