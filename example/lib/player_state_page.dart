import 'package:flutter/material.dart';
import 'package:spotify_mobile_sdk/spotify_mobile_sdk.dart';

class PlayerStatePage extends StatefulWidget {
  @override
  _PlayerStatePageState createState() => _PlayerStatePageState();
}

class _PlayerStatePageState extends State<PlayerStatePage> {
  SpotifyMobileSdk _spotsdk = SpotifyMobileSdk();

  Stream _stream;

  @override
  void initState() {
    super.initState();
    _stream = _spotsdk.playerStateEvents;
  }

  @override
  Widget build(BuildContext context) {
    return true
        ? Scaffold()
        : StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(title: Text("Player State")),
                body: Column(
                  children: <Widget>[
                    Text("Track: ${snapshot.data.track.name} by ${snapshot.data.track.artist.name} from ${snapshot.data.track.album.name}"),
                    Text("Artists: "),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.track.artists.length,
                        itemBuilder: (BuildContext cntxt, int index) {
                          return Text("Artist: ${snapshot.data.track.artists[index].name}");
                        }),
                    // for (SpotifyArtist i in snapshot.data.track.artists) {Text("Artist: ${i.name}")},
                    Text("Uri: ${snapshot.data.track.uri}, Duration: ${snapshot.data.track.duration}, isEpisode: ${snapshot.data.track.isEpisode}, isPodcast: ${snapshot.data.track.isPodcast}"),
                    Divider(),
                    Text("isPaused: ${snapshot.data.isPaused}"),
                    Text("Playback Speed: ${snapshot.data.playbackSpeed}"),
                    Text("Playback Position: ${snapshot.data.playbackPosition}"),
                    Divider(),
                    Text("Playback Options:\nisShuffling: ${snapshot.data.playbackOptions.isShuffling}, Repeat Mode: ${snapshot.data.playbackOptions.repeatMode}"),
                    Divider(),
                    Text("Playback Restrictions:"),
                    Text("canRepeatContext: ${snapshot.data.playbackRestrictions.canRepeatContext}"),
                    Text("canRepeatTrack: ${snapshot.data.playbackRestrictions.canRepeatTrack}"),
                    Text("canSeek: ${snapshot.data.playbackRestrictions.canSeek}"),
                    Text("canSkipNext: ${snapshot.data.playbackRestrictions.canSkipNext}"),
                    Text("canSkipPrev: ${snapshot.data.playbackRestrictions.canSkipPrev}"),
                    Text("canToggleShuffle: ${snapshot.data.playbackRestrictions.canToggleShuffle}"),
                  ],
                ),
              );
            });
  }
}
