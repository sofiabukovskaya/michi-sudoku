import ActivityKit
import SwiftUI
import WidgetKit

// MARK: - Shared data

private let appGroup = "group.com.example.michiSudoku.daily"

private enum Palette {
    static let paper = Color(red: 247/255, green: 242/255, blue: 232/255)
    static let ink = Color(red: 37/255, green: 39/255, blue: 36/255)
    static let indigo = Color(red: 77/255, green: 98/255, blue: 117/255)
    static let coral = Color(red: 217/255, green: 130/255, blue: 107/255)
    static let line = Color(red: 37/255, green: 39/255, blue: 36/255).opacity(0.18)
}

/// What the app shares (see `lib/core/platform/ios_widgets.dart`).
private struct Snapshot: Codable {
    struct Game: Codable {
        let board: String
        let givens: String
        let filled: Int
        let total: Int
        let daily: Bool
    }

    let day: String
    let difficulty: String?
    let dailyDone: Bool
    let streak: Int
    let week: [Bool]
    let game: Game?

    static func load() -> Snapshot? {
        guard let json = UserDefaults(suiteName: appGroup)?.string(forKey: "snapshot"),
              let data = json.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(Snapshot.self, from: data)
    }

    var dayDate: Date? {
        let parser = DateFormatter()
        parser.locale = Locale(identifier: "en_US_POSIX")
        parser.dateFormat = "yyyy-MM-dd"
        return parser.date(from: day)
    }
}

private struct Entry: TimelineEntry {
    let date: Date
    let snapshot: Snapshot?

    /// The snapshot describes today.
    var isToday: Bool {
        snapshot?.dayDate.map { Calendar.current.isDate($0, inSameDayAs: date) } == true
    }

    /// A streak survives until the end of the day after its last Daily.
    var streak: Int {
        guard let snapshot, let day = snapshot.dayDate else { return 0 }
        if Calendar.current.isDate(day, inSameDayAs: date) { return snapshot.streak }
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        return Calendar.current.isDate(day, inSameDayAs: yesterday) && snapshot.dailyDone
            ? snapshot.streak : 0
    }

    var dailyDone: Bool { isToday && snapshot?.dailyDone == true }
}

private struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Entry { Entry(date: .now, snapshot: nil) }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(Entry(date: .now, snapshot: Snapshot.load()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let now = Date.now
        let snapshot = Snapshot.load()
        let midnight = Calendar.current.dateInterval(of: .day, for: now)!.end
        // A new day changes the Daily and the streak without opening the app.
        completion(Timeline(
            entries: [Entry(date: now, snapshot: snapshot), Entry(date: midnight, snapshot: snapshot)],
            policy: .after(midnight)
        ))
    }
}

// MARK: - Pieces

private struct Paw: View {
    var size: CGFloat = 12
    var body: some View {
        Image(systemName: "pawprint.fill").font(.system(size: size, weight: .semibold))
    }
}

/// A 9×9 board: printed digits in ink, the player's in indigo.
private struct MiniBoard: View {
    let game: Snapshot.Game

    var body: some View {
        GeometryReader { proxy in
            let side = min(proxy.size.width, proxy.size.height)
            let cell = side / 9
            let digits = Array(game.board)
            let givens = Array(game.givens)
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 4).fill(Color.white.opacity(0.7))
                Canvas { context, _ in
                    for i in 0...9 {
                        let p = CGFloat(i) * cell
                        let width: CGFloat = i % 3 == 0 ? 1.2 : 0.5
                        var v = Path(); v.move(to: CGPoint(x: p, y: 0)); v.addLine(to: CGPoint(x: p, y: side))
                        var h = Path(); h.move(to: CGPoint(x: 0, y: p)); h.addLine(to: CGPoint(x: side, y: p))
                        let color = i % 3 == 0 ? Palette.ink.opacity(0.55) : Palette.line
                        context.stroke(v, with: .color(color), lineWidth: width)
                        context.stroke(h, with: .color(color), lineWidth: width)
                    }
                    for index in 0..<min(81, digits.count) where digits[index] != "0" {
                        let given = index < givens.count && givens[index] == "1"
                        let text = Text(String(digits[index]))
                            .font(.system(size: cell * 0.62, weight: given ? .bold : .regular, design: .rounded))
                            .foregroundColor(given ? Palette.ink : Palette.indigo)
                        let x = (CGFloat(index % 9) + 0.5) * cell
                        let y = (CGFloat(index / 9) + 0.5) * cell
                        context.draw(text, at: CGPoint(x: x, y: y))
                    }
                }
            }
            .frame(width: side, height: side)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

private struct WeekDots: View {
    let week: [Bool]
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<7, id: \.self) { day in
                Circle()
                    .fill(day < week.count && week[day] ? Palette.coral : Palette.line)
                    .frame(width: 7, height: 7)
            }
        }
    }
}

// MARK: - Today's Sudoku (small, lock screen)

private struct DailyFace: View {
    let entry: Entry
    @Environment(\.widgetFamily) var family
    @Environment(\.widgetRenderingMode) var mode

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if family == .systemSmall {
                HStack {
                    Label("MICHI", systemImage: "square.grid.3x3").font(.caption.bold()).widgetAccentable()
                    Spacer()
                    if entry.streak > 0 {
                        HStack(spacing: 2) { Paw(size: 10); Text("\(entry.streak)").font(.caption.bold()) }
                            .foregroundStyle(mode == .fullColor ? Palette.coral : .primary)
                    }
                }
                Spacer()
            }
            Text("Today's Sudoku").font(.system(.headline, design: .serif))
            if entry.dailyDone {
                Label("Done", systemImage: "checkmark").font(.caption.bold())
            } else if entry.isToday, let difficulty = entry.snapshot?.difficulty {
                Text(LocalizedStringKey(difficulty)).font(.caption)
            }
            if family == .systemSmall, let week = entry.snapshot?.week, entry.isToday {
                WeekDots(week: week).padding(.top, 2)
            } else {
                Text(entry.date, format: .dateTime.weekday().month().day()).font(.caption)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .foregroundStyle(mode == .fullColor ? Palette.ink : .primary)
        .containerBackground(for: .widget) { Palette.paper }
        .widgetURL(URL(string: "michi://open/daily"))
    }
}

struct DailyWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MichiDaily", provider: Provider()) { DailyFace(entry: $0) }
            .configurationDisplayName("Today's Sudoku")
            .description("Open today's puzzle in MICHI.")
            .supportedFamilies([.systemSmall, .accessoryRectangular])
    }
}

// MARK: - Continue (medium)

private struct ContinueFace: View {
    let entry: Entry

    var body: some View {
        Group {
            if let game = entry.snapshot?.game {
                HStack(spacing: 14) {
                    MiniBoard(game: game)
                    VStack(alignment: .leading, spacing: 6) {
                        Text(game.daily ? "Today's Sudoku" : "Your Sudoku")
                            .font(.system(.headline, design: .serif))
                        ProgressView(value: Double(game.filled), total: Double(max(game.total, 1)))
                            .tint(Palette.indigo)
                        Text("\(game.filled) of \(game.total) cells").font(.caption)
                        Spacer(minLength: 0)
                        Label("Continue", systemImage: "play.fill")
                            .font(.subheadline.bold())
                            .foregroundStyle(Palette.indigo)
                    }
                }
                .widgetURL(URL(string: "michi://open/continue"))
            } else {
                HStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 6) {
                        Label("MICHI", systemImage: "square.grid.3x3").font(.caption.bold())
                        Text(entry.dailyDone ? "Daily done for today" : "Today's Sudoku")
                            .font(.system(.headline, design: .serif))
                        if entry.streak > 0 {
                            HStack(spacing: 4) { Paw(size: 11); Text("\(entry.streak) days in a row") }
                                .font(.caption).foregroundStyle(Palette.coral)
                        }
                        Spacer(minLength: 0)
                        if let week = entry.snapshot?.week, entry.isToday { WeekDots(week: week) }
                    }
                    Spacer()
                    Image(systemName: entry.dailyDone ? "checkmark.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44)).foregroundStyle(Palette.indigo)
                }
                .widgetURL(URL(string: "michi://open/daily"))
            }
        }
        .foregroundStyle(Palette.ink)
        .containerBackground(for: .widget) { Palette.paper }
    }
}

struct ContinueWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MichiContinue", provider: Provider()) { ContinueFace(entry: $0) }
            .configurationDisplayName("Continue Sudoku")
            .description("Your puzzle in progress, one tap away.")
            .supportedFamilies([.systemMedium])
    }
}

// MARK: - Streak (lock screen)

private struct StreakFace: View {
    let entry: Entry
    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(spacing: 0) {
                Paw(size: 13)
                Text("\(entry.streak)").font(.system(.title3, design: .rounded).bold())
            }
        }
        .containerBackground(for: .widget) { Color.clear }
        .widgetURL(URL(string: "michi://open/daily"))
    }
}

struct StreakWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "MichiStreak", provider: Provider()) { StreakFace(entry: $0) }
            .configurationDisplayName("Daily streak")
            .description("Days in a row with today's Sudoku.")
            .supportedFamilies([.accessoryCircular])
    }
}

// MARK: - Live Activity: a game waiting

/// Must match `MichiGameAttributes` in `Runner/AppDelegate.swift`.
struct MichiGameAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var board: String
        var givens: String
        var filled: Int
        var total: Int
        var elapsed: Int
    }

    var daily: Bool
}

private func clock(_ seconds: Int) -> String {
    let h = seconds / 3600, m = (seconds % 3600) / 60, s = seconds % 60
    return h > 0 ? String(format: "%d:%02d:%02d", h, m, s) : String(format: "%d:%02d", m, s)
}

private struct ActivityProgress: View {
    let state: MichiGameAttributes.ContentState
    var body: some View {
        ProgressView(value: Double(state.filled), total: Double(max(state.total, 1)))
            .tint(Palette.coral)
    }
}

struct GameActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MichiGameAttributes.self) { context in
            let state = context.state
            HStack(spacing: 14) {
                MiniBoard(game: .init(board: state.board, givens: state.givens,
                                      filled: state.filled, total: state.total,
                                      daily: context.attributes.daily))
                    .frame(width: 84, height: 84)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Label(context.attributes.daily ? "Today's Sudoku" : "Your Sudoku",
                              systemImage: "pawprint.fill")
                            .font(.headline)
                        Spacer()
                        Text(clock(state.elapsed)).font(.caption.monospacedDigit())
                    }
                    ActivityProgress(state: state)
                    Text("\(state.filled) of \(state.total) cells · Tap to continue")
                        .font(.caption)
                }
            }
            .padding(14)
            .foregroundStyle(Palette.ink)
            .activityBackgroundTint(Palette.paper)
            .widgetURL(URL(string: "michi://open/continue"))
        } dynamicIsland: { context in
            let state = context.state
            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Label("MICHI", systemImage: "pawprint.fill").font(.caption.bold())
                        .foregroundStyle(Palette.coral)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(clock(state.elapsed)).font(.caption.monospacedDigit())
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        ActivityProgress(state: state)
                        Text("\(state.filled) of \(state.total) cells · Tap to continue").font(.caption)
                    }
                }
            } compactLeading: {
                Image(systemName: "pawprint.fill").foregroundStyle(Palette.coral)
            } compactTrailing: {
                Text("\(state.filled)/\(state.total)").font(.caption2.monospacedDigit())
            } minimal: {
                Image(systemName: "pawprint.fill").foregroundStyle(Palette.coral)
            }
            .widgetURL(URL(string: "michi://open/continue"))
        }
    }
}

@main
struct MichiWidgets: WidgetBundle {
    var body: some Widget {
        DailyWidget()
        ContinueWidget()
        StreakWidget()
        GameActivityWidget()
    }
}
