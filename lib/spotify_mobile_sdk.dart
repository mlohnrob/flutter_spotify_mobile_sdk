import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

// import 'models/crossfade_state_model.dart';

class SpotifyMobileSdk {
  static const MethodChannel _channel = const MethodChannel('spotify_mobile_sdk');
  static const EventChannel _playerStateChannel = const EventChannel('player_state_events');
  static const EventChannel _playerContextChannel = const EventChannel('player_context_events');

  // Stream<SpotifyPlayerState> _playerStateEvents;

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
      final Map<String, dynamic> crossfadeStateMap = Map<String, dynamic>.from(await _channel.invokeMethod("getCrossfadeState"));
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
      : track = SpotifyTrack.fromMap(map["track"]),
        isPaused = map["isPaused"],
        playbackSpeed = map["playbackSpeed"],
        playbackPosition = map["playbackPosition"],
        playbackOptions = SpotifyPlayerOptions.fromMap(map["playbackOptions"]),
        playbackRestrictions = SpotifyPlayerRestrictions.fromMap(map["playbackRestrictions"]);
}

class SpotifyPlayerContext {
  final String title;
  final String subtitle;
  final String type;
  final String uri;

  SpotifyPlayerContext(this.title, this.subtitle, this.type, this.uri);

  SpotifyPlayerContext.fromMap(Map<String, String> map)
      : title = map["title"],
        subtitle = map["subtitle"],
        type = map["type"],
        uri = map["uri"];
}

class SpotifyTrack {
  String name;
  String uri;
  SpotifyAlbum album;
  SpotifyArtist artist;
  List<SpotifyArtist> artists;
  int duration;
  bool isEpisode;
  bool isPodcast;
  String imageUri;

  SpotifyTrack(this.name, this.uri, this.album, this.artist, this.artists, this.duration, this.imageUri, this.isEpisode, this.isPodcast);

  SpotifyTrack.fromMap(Map<dynamic, dynamic> map) {
    this.name = map["name"];
    this.uri = map["uri"];
    this.album = SpotifyAlbum.fromMap(map["album"]);
    this.artist = SpotifyArtist.fromMap(map["artist"]);
    for (int i = 0; i < map["artists"].length; i++) {
      map["artists"][i] = SpotifyArtist.fromMap(map["artists"][i]);
    }
    this.artists = List<SpotifyArtist>.from(map["artists"]);
    this.duration = map["duration"];
    this.isEpisode = map["isEpisode"];
    this.isPodcast = map["isPodcast"];
    this.imageUri = map["imageUri"];
  }
}

class SpotifyAlbum {
  final String name;
  final String uri;

  SpotifyAlbum(this.name, this.uri);

  SpotifyAlbum.fromMap(Map<dynamic, dynamic> map)
      : name = map["name"],
        uri = map["uri"];
}

class SpotifyArtist {
  final String name;
  final String uri;

  SpotifyArtist(this.name, this.uri);

  SpotifyArtist.fromMap(Map<dynamic, dynamic> map)
      : name = map["name"],
        uri = map["uri"];
}

class SpotifyPlayerOptions {
  final bool isShuffling;
  final int repeatMode;

  SpotifyPlayerOptions(this.isShuffling, this.repeatMode);

  SpotifyPlayerOptions.fromMap(Map<dynamic, dynamic> map)
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

  SpotifyPlayerRestrictions.fromMap(Map<dynamic, dynamic> map)
      : canRepeatContext = map["canRepeatContext"],
        canRepeatTrack = map["canRepeatTrack"],
        canSeek = map["canSeek"],
        canSkipNext = map["canSkipNext"],
        canSkipPrev = map["canSkipPrev"],
        canToggleShuffle = map["canToggleShuffle"];
}
