import SwiftUI
import Charts

struct SleepPart: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
    let color: Color
}

struct SleepChartView: View {
    // Example: sleep from 23:00 to 07:00 → 8h
    let startHour: Double = 23
    let endHour: Double = 7
        
    var body: some View {
        let sleepDuration = (endHour >= startHour)
            ? endHour - startHour
            : (24 - startHour + endHour)   // wrap across midnight
        
        let data = [
            SleepPart(label: "Sleep", value: sleepDuration, color: .blue),
            SleepPart(label: "Awake", value: 24 - sleepDuration, color: .gray.opacity(0.2))
        ]
        
        Chart(data) { part in
            SectorMark(
                angle: .value("Hours", part.value),
                innerRadius: .ratio(0.6),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(part.color)
        }
        .frame(width: 50, height: 50)
        .rotationEffect(.degrees((startHour / 24) * 360)) // ⬅️ rotates so arc begins at start time
    }
}
