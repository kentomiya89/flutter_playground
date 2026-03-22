import EventKitUI
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var calendarHandler: CustomCalendarEventHandler?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "CustomCalendarHostApi")
    else { return }
    let handler = CustomCalendarEventHandler()
    calendarHandler = handler
    CustomCalendarHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: handler)
  }
}
