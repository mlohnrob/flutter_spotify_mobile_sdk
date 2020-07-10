import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class SpotifyMobileSdk {
  static const MethodChannel _channel = const MethodChannel('spotify_mobile_sdk');

  static Future<bool> get isConnected async {
    try {
      return await _channel.invokeMethod("getIsConnected");
    } on PlatformException catch (e) {
      print("$e");
      return false;
    }
  }

  static Future<bool> init({@required String clientId, @required String redirectUri}) async {
    try {
      return await _channel.invokeMethod("initialize", {"clientId": clientId, "redirectUri": redirectUri});
    } on PlatformException catch (e) {
      print("$e");
      return false;
    }
  }

  static Future<void> play({@required String spotifyUri}) async {
    try {
      await _channel.invokeMethod("play", {"spotifyUri": spotifyUri});
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> queue({@required String spotifyUri}) async {
    try {
      await _channel.invokeMethod("queue", {"spotifyUri": spotifyUri});
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> pause() async {
    try {
      await _channel.invokeMethod("pause");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> resume() async {
    try {
      await _channel.invokeMethod("resume");
    } on PlatformException catch (e) {
      print("$e");
    }
  }
}
