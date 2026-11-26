package com.example.michi_sudoku

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "michi/device")
            .setMethodCallHandler { call, result ->
                if (call.method == "model") result.success(Build.MODEL)
                else result.notImplemented()
            }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // The first Flutter frame draws the same indigo disc at the same
            // size, so the system splash leaves instantly instead of
            // cross-fading over it and showing two discs.
            splashScreen.setOnExitAnimationListener { view ->
                view.remove()
                notifyLaunchScreenRemoved()
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                "michi_daily", "Daily Sudoku", NotificationManager.IMPORTANCE_DEFAULT
            )
            getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
        }
    }

    override fun onFlutterUiDisplayed() {
        super.onFlutterUiDisplayed()
        // Before Android 12 the launch theme simply gives way to Flutter.
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) notifyLaunchScreenRemoved()
    }

    /** Lets the Flutter splash begin its entrance exactly when it is seen. */
    private fun notifyLaunchScreenRemoved() {
        val messenger = flutterEngine?.dartExecutor?.binaryMessenger ?: return
        MethodChannel(messenger, "michi/launch").invokeMethod("launchScreenRemoved", null)
    }
}
