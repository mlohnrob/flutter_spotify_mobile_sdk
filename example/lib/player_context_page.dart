import 'package:flutter/material.dart';
import 'package:spotify_mobile_sdk/spotify_mobile_sdk.dart';

class PlayerContextPage extends StatefulWidget {
  PlayerContextPage({Key key}) : super(key: key);

  @override
  _PlayerContextPageState createState() => _PlayerContextPageState();
}

class _PlayerContextPageState extends State<PlayerContextPage> {
  SpotifyMobileSdk _spotsdk = SpotifyMobileSdk();

  Stream<SpotifyPlayerContext> _playerContextStream;

  @override
  void initState() {
    super.initState();
    _playerContextStream = _spotsdk.playerContextEvents;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _playerContextStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: AppBar(title: Text("Player Context")),
          body: Column(
            children: <Widget>[
              Text("${snapshot.data.title}"),
              Text("${snapshot.data.subtitle}"),
              Text("${snapshot.data.type}"),
              Text("${snapshot.data.uri}"),
            ],
          ),
        );
      },
    );
  }
}
