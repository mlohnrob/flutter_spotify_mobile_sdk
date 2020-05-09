import Flutter
import UIKit

public class SwiftSpotifyMobileSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "spotify_mobile_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftSpotifyMobileSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
