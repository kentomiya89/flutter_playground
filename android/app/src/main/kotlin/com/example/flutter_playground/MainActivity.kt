package com.example.flutter_playground

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    CustomCalendarHostApi.setUp(
      flutterEngine.dartExecutor.binaryMessenger,
      CustomCalendarEventHandler(applicationContext),
    )
  }
}
