import 'spotify_track.dart';
import 'spotify_player_options.dart';
import 'spotify_player_restrictions.dart';

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
