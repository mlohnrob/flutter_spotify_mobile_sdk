import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

// import 'models/crossfade_state_model.dart';

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

  static Future<CrossFadeState> get crossFadeState async {
    try {
      final Map<String, dynamic> crossFadeStateMap = await _channel.invokeMethod("getCrossFadeState");
      final CrossFadeState crossFadeState = CrossFadeState.fromMap(crossFadeStateMap);
      return crossFadeState;
    } on PlatformException catch (e) {
      print("$e");
      return null;
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

  static Future<void> skipNext() async {
    try {
      await _channel.invokeMethod("skipNext");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> skipPrev() async {
    try {
      await _channel.invokeMethod("skipPrev");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> toggleRepeat() async {
    try {
      await _channel.invokeMethod("toggleRepeat");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> toggleShuffle() async {
    try {
      await _channel.invokeMethod("toggleShuffle");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> seekTo({@required int positionMs}) async {
    try {
      await _channel.invokeMethod("seekTo", {"positionMs": positionMs});
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  static Future<void> seekToRelativePosition({@required int milliseconds}) async {
    try {
      await _channel.invokeMethod("seekToRelativePosition", {"milliseconds": milliseconds});
    } on PlatformException catch (e) {
      print("$e");
    }
  }
}

class SpotifyCrossFadeState {
  final bool isEnabled;
  final int duration;

  SpotifyCrossFadeState(this.isEnabled, this.duration);

  SpotifyCrossFadeState.fromMap(Map<String, dynamic> map)
      : isEnabled = map["isEnabled"],
        duration = map["duration"];
}
