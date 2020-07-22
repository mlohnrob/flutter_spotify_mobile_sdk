import 'package:flutter/material.dart';
import 'package:spotify_mobile_sdk/spotify_mobile_sdk.dart';

class PlayerStatePage extends StatefulWidget {
  @override
  _PlayerStatePageState createState() => _PlayerStatePageState();
}

class _PlayerStatePageState extends State<PlayerStatePage> {
  SpotifyPlayerState _playerState;

  @override
  void initState() {
    super.initState();
    getPlayerStateNow();
  }

  Future<void> getPlayerStateNow() async {
    _playerState = await SpotifyMobileSdk.playerState;
    print(_playerState as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Player State")),
      body: Column(
        children: <Widget>[
          Text("Track: ${_playerState.track.name} by ${_playerState.track.artist} from ${_playerState.track.album}"),
          Text(
              "Uri: ${_playerState.track.uri}, Artists: ${_playerState.track.artists}, Duration: ${_playerState.track.duration}, isEpisode: ${_playerState.track.isEpisode}, isPodcast: ${_playerState.track.isPodcast}"),
          Divider(),
          Text("isPaused: ${_playerState.isPaused}"),
          Text("Playback Speed: ${_playerState.playbackSpeed}"),
          Text("Playback Position: ${_playerState.playbackPosition}"),
          Divider(),
          Text("Playback Options:\nisShuffling: ${_playerState.playbackOptions.isShuffling}, Repeat Mode: ${_playerState.playbackOptions.repeatMode}"),
          Divider(),
          Text("Playback Restrictions:"),
          Text("canRepeatContext: ${_playerState.playbackRestrictions.canRepeatContext}"),
          Text("canRepeatTrack: ${_playerState.playbackRestrictions.canRepeatTrack}"),
          Text("canSeek: ${_playerState.playbackRestrictions.canSeek}"),
          Text("canSkipNext: ${_playerState.playbackRestrictions.canSkipNext}"),
          Text("canSkipPrev: ${_playerState.playbackRestrictions.canSkipPrev}"),
          Text("canToggleShuffle: ${_playerState.playbackRestrictions.canToggleShuffle}"),
        ],
      ),
    );
  }
}
