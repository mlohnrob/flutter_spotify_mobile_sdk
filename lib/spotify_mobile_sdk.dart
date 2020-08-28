import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:spotify_mobile_sdk/models/spotify_crossfade_state.dart';
import 'package:spotify_mobile_sdk/models/spotify_player_context.dart';
import 'package:spotify_mobile_sdk/models/spotify_player_state.dart';
import 'package:spotify_mobile_sdk/enums/spotify_image_dimension.dart';

export 'package:spotify_mobile_sdk/models/spotify_crossfade_state.dart';
export 'package:spotify_mobile_sdk/models/spotify_player_context.dart';
export 'package:spotify_mobile_sdk/models/spotify_player_state.dart';
export 'package:spotify_mobile_sdk/enums/spotify_image_dimension.dart';

extension on SpotifyImageDimension {
  static const Map<SpotifyImageDimension, int> dimensionValues = <SpotifyImageDimension, int>{
    SpotifyImageDimension.LARGE: 720,
    SpotifyImageDimension.MEDIUM: 480,
    SpotifyImageDimension.SMALL: 360,
    SpotifyImageDimension.X_SMALL: 240,
    SpotifyImageDimension.THUMBNAIL: 144,
  };

  int get value => dimensionValues[this];
}

class SpotifyMobileSdk {
  static const MethodChannel _methodChannel = const MethodChannel('spotify_mobile_sdk');
  static const EventChannel _playerStateChannel = const EventChannel('player_state_events');
  static const EventChannel _playerContextChannel = const EventChannel('player_context_events');

  // Stream<SpotifyPlayerState> _playerStateEvents;

  Future<bool> get isConnected async {
    try {
      return await _methodChannel.invokeMethod("getIsConnected");
    } on PlatformException catch (e) {
      print("$e");
      return false;
    }
  }

  Future<SpotifyCrossfadeState> get crossfadeState async {
    try {
      final Map<String, dynamic> crossfadeStateMap = Map<String, dynamic>.from(await _methodChannel.invokeMethod("getCrossfadeState"));
      final SpotifyCrossfadeState crossfadeState = SpotifyCrossfadeState.fromMap(crossfadeStateMap);
      return crossfadeState;
    } on PlatformException catch (e) {
      print("$e");
      return null;
    }
  }

  Future<SpotifyPlayerState> get playerState async {
    try {
      final Map<String, dynamic> playerStateMap = Map<String, dynamic>.from(await _methodChannel.invokeMethod("getPlayerState"));
      final SpotifyPlayerState playerState = SpotifyPlayerState.fromMap(playerStateMap);
      return playerState;
    } on PlatformException catch (e) {
      print("$e");
      return null;
    }
  }

  Stream<SpotifyPlayerState> get playerStateEvents {
    // TODO: Make [artists] list not get infinitely big
    try {
      return _playerStateChannel.receiveBroadcastStream().asyncMap((dynamic playerStateHashMap) => SpotifyPlayerState.fromMap(Map<String, dynamic>.from(playerStateHashMap)));
    } on PlatformException catch (e) {
      print("$e");
      return null;
    }
  }

  Stream<SpotifyPlayerContext> get playerContextEvents {
    try {
      return _playerContextChannel.receiveBroadcastStream().asyncMap((dynamic playerContextHashMap) => SpotifyPlayerContext.fromMap(Map<String, String>.from(playerContextHashMap)));
    } on PlatformException catch (e) {
      print("$e");
      return null;
    }
  }

  Future<bool> init({@required String clientId, @required String redirectUri}) async {
    try {
      return await _methodChannel.invokeMethod("initialize", {"clientId": clientId, "redirectUri": redirectUri});
    } on PlatformException catch (e) {
      print("$e");
      return false;
    }
  }

  // possible rename of function
  Future<bool> terminate() async {
    try {
      return await _methodChannel.invokeMethod("terminate");
    } on PlatformException catch (e) {
      print("$e");
      return false;
    }
  }

  Future<void> play({@required String spotifyUri}) async {
    try {
      await _methodChannel.invokeMethod("play", {"spotifyUri": spotifyUri});
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> queue({@required String spotifyUri}) async {
    try {
      await _methodChannel.invokeMethod("queue", {"spotifyUri": spotifyUri});
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> pause() async {
    try {
      await _methodChannel.invokeMethod("pause");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> resume() async {
    try {
      await _methodChannel.invokeMethod("resume");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> skipNext() async {
    try {
      await _methodChannel.invokeMethod("skipNext");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> skipPrev() async {
    try {
      await _methodChannel.invokeMethod("skipPrev");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> toggleRepeat() async {
    try {
      await _methodChannel.invokeMethod("toggleRepeat");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> toggleShuffle() async {
    try {
      await _methodChannel.invokeMethod("toggleShuffle");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> seekTo({@required int positionMs}) async {
    try {
      await _methodChannel.invokeMethod("seekTo", {"positionMs": positionMs});
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> seekToRelativePosition({@required int milliseconds}) async {
    try {
      await _methodChannel.invokeMethod("seekToRelativePosition", {"milliseconds": milliseconds});
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<void> switchToLocalDevice() async {
    try {
      await _methodChannel.invokeMethod("switchToLocalDevice");
    } on PlatformException catch (e) {
      print("$e");
    }
  }

  Future<Uint8List> getImage({@required String imageUri, SpotifyImageDimension dimension = SpotifyImageDimension.MEDIUM}) async {
    try {
      return await _methodChannel.invokeMethod("getImage", {"imageUri": imageUri, "dimension": dimension.value});
    } on PlatformException catch (e) {
      print("$e");
      return null;
    }
  }
}
