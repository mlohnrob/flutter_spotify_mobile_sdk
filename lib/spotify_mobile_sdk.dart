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

  static Future<SpotifyCrossfadeState> get crossfadeState async {
    try {
      final Map<String, dynamic> crossfadeStateMap = Map<String, dynamic>.from(await _channel.invokeMethod("getCrossFadeState"));
      final SpotifyCrossfadeState crossfadeState = SpotifyCrossfadeState.fromMap(crossfadeStateMap);
      return crossfadeState;
    } on PlatformException catch (e) {
      print("$e");
      return null;
    }
  }

  static Future<SpotifyPlayerState> get playerState async {
    try {
      final Map<String, dynamic> playerStateMap = Map<String, dynamic>.from(await _channel.invokeMethod("getPlayerState"));
      final SpotifyPlayerState playerState = SpotifyPlayerState.fromMap(playerStateMap);
      return playerState;
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

class SpotifyCrossfadeState {
  final bool isEnabled;
  final int duration;

  SpotifyCrossfadeState(this.isEnabled, this.duration);

  SpotifyCrossfadeState.fromMap(Map<String, dynamic> map)
      : isEnabled = map["isEnabled"],
        duration = map["duration"];
}

class SpotifyPlayerState {
  final SpotifyTrack track;
  final bool isPaused;
  final double playbackSpeed;
  final int playbackPosition;
  final SpotifyPlayerOptions playbackOptions;
  final SpotifyPlayerRestrictions playbackRestrictions;

  SpotifyPlayerState(this.track, this.isPaused, this.playbackSpeed, this.playbackPosition, this.playbackOptions, this.playbackRestrictions);

  SpotifyPlayerState.fromMap(Map<String, dynamic> map)
      : track = map["track"],
        isPaused = map["isPaused"],
        playbackSpeed = map["playbackSpeed"],
        playbackPosition = map["playbackPosition"],
        playbackOptions = map["playbackOptions"],
        playbackRestrictions = map["playbackRestrictions"];
}

class SpotifyTrack {
  final String name;
  final String uri;
  final SpotifyAlbum album;
  final SpotifyArtist artist;
  final List<SpotifyArtist> artists;
  final int duration;
  final bool isEpisode;
  final bool isPodcast;
  final String imageUri;

  SpotifyTrack(this.name, this.uri, this.album, this.artist, this.artists, this.duration, this.imageUri, this.isEpisode, this.isPodcast);

  SpotifyTrack.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        uri = map["uri"],
        album = map["album"],
        artist = map["artist"],
        artists = map["artists"],
        duration = map["duration"],
        isEpisode = map["isEpisode"],
        isPodcast = map["isPodcast"],
        imageUri = map["imageUri"];
}

class SpotifyAlbum {
  final String name;
  final String uri;

  SpotifyAlbum(this.name, this.uri);

  SpotifyAlbum.fromMap(Map<String, String> map)
      : name = map["name"],
        uri = map["uri"];
}

class SpotifyArtist {
  final String name;
  final String uri;

  SpotifyArtist(this.name, this.uri);

  SpotifyArtist.fromMap(Map<String, String> map)
      : name = map["name"],
        uri = map["uri"];
}

class SpotifyPlayerOptions {
  final bool isShuffling;
  final int repeatMode;

  SpotifyPlayerOptions(this.isShuffling, this.repeatMode);

  SpotifyPlayerOptions.fromMap(Map<String, dynamic> map)
      : isShuffling = map["isShuffling"],
        repeatMode = map["repeatMode"];
}

class SpotifyPlayerRestrictions {
  final bool canRepeatContext;
  final bool canRepeatTrack;
  final bool canSeek;
  final bool canSkipNext;
  final bool canSkipPrev;
  final bool canToggleShuffle;

  SpotifyPlayerRestrictions(this.canRepeatContext, this.canRepeatTrack, this.canSeek, this.canSkipNext, this.canSkipPrev, this.canToggleShuffle);

  SpotifyPlayerRestrictions.fromMap(Map<String, bool> map)
      : canRepeatContext = map["canRepeatContext"],
        canRepeatTrack = map["canRepeatTrack"],
        canSeek = map["canSeek"],
        canSkipNext = map["canSkipNext"],
        canSkipPrev = map["canSkipPrev"],
        canToggleShuffle = map["canToggleShuffle"];
}
