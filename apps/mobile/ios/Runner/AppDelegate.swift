import ActivityKit
import Flutter
import UIKit
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    FlutterMethodChannel(name: "michi/daily", binaryMessenger: engineBridge.applicationRegistrar.messenger())
      .setMethodCallHandler { call, result in
        if call.method == "snapshot" {
          Self.storeSnapshot(call.arguments as? String)
          result(nil)
          return
        }
        guard call.method == "publish", let data = call.arguments as? [String: String],
              let day = data["day"], let difficulty = data["difficulty"],
              let defaults = UserDefaults(suiteName: "group.com.example.michiSudoku.daily") else {
          result(FlutterMethodNotImplemented)
          return
        }
        let parser = DateFormatter()
        parser.locale = Locale(identifier: "en_US_POSIX")
        parser.dateFormat = "yyyy-MM-dd"
        if let date = parser.date(from: day),
           (defaults.object(forKey: "dailyDate") as? Date != date ||
            defaults.string(forKey: "difficulty") != difficulty) {
          defaults.set(date, forKey: "dailyDate")
          defaults.set(difficulty, forKey: "difficulty")
          WidgetCenter.shared.reloadTimelines(ofKind: "MichiDaily")
        }
        result(nil)
      }
    FlutterMethodChannel(name: "michi/activity", binaryMessenger: engineBridge.applicationRegistrar.messenger())
      .setMethodCallHandler { call, result in
        if #available(iOS 16.2, *) {
          switch call.method {
          case "show": GameActivity.show(json: call.arguments as? String)
          case "end": GameActivity.end()
          default: break
          }
        }
        result(nil)
      }
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  /// Widgets read the snapshot from the app group; unchanged data does not
  /// spend a widget reload.
  private static func storeSnapshot(_ json: String?) {
    guard let json, let defaults = UserDefaults(suiteName: "group.com.example.michiSudoku.daily"),
          defaults.string(forKey: "snapshot") != json else { return }
    defaults.set(json, forKey: "snapshot")
    if let data = json.data(using: .utf8),
       let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
       let day = object["day"] as? String {
      // Kept for widgets installed before the snapshot existed.
      let parser = DateFormatter()
      parser.locale = Locale(identifier: "en_US_POSIX")
      parser.dateFormat = "yyyy-MM-dd"
      if let date = parser.date(from: day) { defaults.set(date, forKey: "dailyDate") }
      defaults.set(object["difficulty"] as? String, forKey: "difficulty")
    }
    WidgetCenter.shared.reloadAllTimelines()
  }
}

/// Must match `MichiGameAttributes` in `DailyWidget/DailyWidget.swift`.
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

/// One "game waiting" activity at a time: shown when the player leaves an
/// unfinished game, ended when they return or finish. Stale after 8 hours.
@available(iOS 16.2, *)
enum GameActivity {
  private struct Payload: Decodable {
    let board: String
    let givens: String
    let filled: Int
    let total: Int
    let daily: Bool
    let elapsed: Int
  }

  static func show(json: String?) {
    guard ActivityAuthorizationInfo().areActivitiesEnabled,
          let data = json?.data(using: .utf8),
          let payload = try? JSONDecoder().decode(Payload.self, from: data) else { return }
    let state = MichiGameAttributes.ContentState(
      board: payload.board, givens: payload.givens,
      filled: payload.filled, total: payload.total, elapsed: payload.elapsed)
    let content = ActivityContent(state: state, staleDate: Date().addingTimeInterval(8 * 3600))
    if let current = Activity<MichiGameAttributes>.activities.first,
       current.attributes.daily == payload.daily {
      Task { await current.update(content) }
      return
    }
    end()
    _ = try? Activity.request(attributes: MichiGameAttributes(daily: payload.daily), content: content)
  }

  static func end() {
    for activity in Activity<MichiGameAttributes>.activities {
      Task { await activity.end(nil, dismissalPolicy: .immediate) }
    }
  }
}
