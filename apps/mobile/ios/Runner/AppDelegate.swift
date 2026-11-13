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
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
