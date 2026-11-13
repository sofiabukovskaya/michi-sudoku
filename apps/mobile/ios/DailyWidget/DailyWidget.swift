import SwiftUI
import WidgetKit

private struct Day: TimelineEntry {
    let date: Date
    let difficulty: String?
}

private struct DailyProvider: TimelineProvider {
    func placeholder(in context: Context) -> Day { Day(date: .now, difficulty: nil) }

    private func current() -> Day {
        let shared = UserDefaults(suiteName: "group.com.example.michiSudoku.daily")
        let date = Date.now
        let stamp = shared?.object(forKey: "dailyDate") as? Date
        let fresh = stamp.map { Calendar.current.isDate($0, inSameDayAs: date) } == true
        return Day(date: date, difficulty: fresh ? shared?.string(forKey: "difficulty") : nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (Day) -> Void) {
        completion(current())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Day>) -> Void) {
        let day = current()
        let midnight = Calendar.current.dateInterval(of: .day, for: day.date)!.end
        completion(Timeline(entries: [day, Day(date: midnight, difficulty: nil)], policy: .after(midnight)))
    }
}

private struct DailyFace: View {
    let day: Day
    @Environment(\.widgetFamily) var family
    @Environment(\.widgetRenderingMode) var mode

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if family == .systemSmall {
                Label("MICHI", systemImage: "square.grid.3x3")
                    .font(.caption.bold()).widgetAccentable()
                Spacer()
            }
            Text("Today's Sudoku").font(.system(.headline, design: .serif))
            if let difficulty = day.difficulty {
                Text(LocalizedStringKey(difficulty)).font(.caption)
            }
            Text(day.date, format: .dateTime.weekday().month().day()).font(.caption)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .foregroundStyle(mode == .fullColor ? Color(red: 37/255, green: 39/255, blue: 36/255) : .primary)
        .containerBackground(for: .widget) { Color(red: 247/255, green: 242/255, blue: 232/255) }
        .widgetURL(URL(string: "michi://open/daily"))
    }
}

@main
struct DailyWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MichiDaily", provider: DailyProvider()) { DailyFace(day: $0) }
            .configurationDisplayName("Today's Sudoku")
            .description("Open today's puzzle in MICHI.")
            .supportedFamilies([.systemSmall, .accessoryRectangular])
    }
}
