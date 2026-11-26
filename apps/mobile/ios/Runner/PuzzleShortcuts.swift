import AppIntents
import UIKit

@available(iOS 16.0, *)
struct ScanSudoku: AppIntent {
    static let title: LocalizedStringResource = "Scan Sudoku"
    static let openAppWhenRun = true
    @MainActor func perform() async throws -> some IntentResult {
        await UIApplication.shared.open(URL(string: "michi://open/scan")!)
        return .result()
    }
}

@available(iOS 16.0, *)
struct ContinueSudoku: AppIntent {
    static let title: LocalizedStringResource = "Continue Sudoku"
    static let openAppWhenRun = true
    @MainActor func perform() async throws -> some IntentResult {
        await UIApplication.shared.open(URL(string: "michi://open/continue")!)
        return .result()
    }
}

@available(iOS 16.0, *)
struct TodaySudoku: AppIntent {
    static let title: LocalizedStringResource = "Today's Sudoku"
    static let openAppWhenRun = true
    @MainActor func perform() async throws -> some IntentResult {
        await UIApplication.shared.open(URL(string: "michi://open/daily")!)
        return .result()
    }
}

@available(iOS 16.0, *)
struct PuzzleShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: ScanSudoku(), phrases: ["Scan a Sudoku with \(.applicationName)"], shortTitle: "Scan Sudoku", systemImageName: "viewfinder")
        AppShortcut(intent: ContinueSudoku(), phrases: ["Continue Sudoku in \(.applicationName)"], shortTitle: "Continue Sudoku", systemImageName: "play")
        AppShortcut(intent: TodaySudoku(), phrases: ["Open today's Sudoku in \(.applicationName)"], shortTitle: "Today's Sudoku", systemImageName: "calendar")
    }
}
