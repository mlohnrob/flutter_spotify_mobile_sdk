import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class SpotifyMobileSdk {
  static const MethodChannel _channel = const MethodChannel('spotify_mobile_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> init({@required String clientId, @required String redirectUri}) async {
    try {
      return await _channel.invokeMethod("initialize", {"clientId": clientId, "redirectUri": redirectUri});
    } on Exception catch (e) {
      print("Failed to init: $e");
    }
  }

  // static Future<bool> play({@required String itemId}) async {
  //   final bool success = await _channel.invokeMethod("play", {"itemId": itemId});
  //   return success;
  // }
}
