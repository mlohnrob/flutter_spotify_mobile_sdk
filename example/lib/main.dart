import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:spotify_mobile_sdk/spotify_mobile_sdk.dart';
import 'player_state_page.dart';
// import 'package:spotify_mobile_sdk/models/crossfade_state_model.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // SpotifyMobileSdk _spotsdk = SpotifyMobileSdk();

  bool _connected = false;
  bool _init = false;

  bool _crossfadeEnabled;
  int _crossfadeDuration;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool connected;
    bool init;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      init = await SpotifyMobileSdk.init(clientId: "e2e3774bb3224432b7161b7680538458", redirectUri: "spotify-sdk://auth");
    } on PlatformException {
      print("PLATFORM EXCEPTION INIT");
    }

    try {
      connected = await SpotifyMobileSdk.isConnected;
    } on PlatformException {
      print("PLATFORM EXCEPTION 2");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _init = init;
      _connected = connected;
    });
  }

  Future<void> getCrossfadeStateNow() async {
    SpotifyCrossfadeState crossfadeState;
    bool crossfadeEnabled;
    int crossfadeDuration;

    try {
      crossfadeState = await SpotifyMobileSdk.crossfadeState;
      crossfadeEnabled = crossfadeState.isEnabled;
      crossfadeDuration = crossfadeState.duration;
    } on PlatformException {
      print("PLATFORM EXCEPTION 3");
    }

    setState(() {
      _crossfadeEnabled = crossfadeEnabled;
      _crossfadeDuration = crossfadeDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify SDK Plugin Example APP'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("Player State"),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerStatePage())),
          ),
          Divider(),
          Text("Initialized: $_init", style: TextStyle(fontSize: 25.0)),
          Divider(),
          Text("Is Connected: $_connected", style: TextStyle(fontSize: 25.0)),
          Divider(),
          RaisedButton(
            child: Text("Get Crossfade State"),
            onPressed: () async {
              await getCrossfadeStateNow();
            },
          ),
          Row(
            children: <Widget>[
              Text("Is Enabled: $_crossfadeEnabled", style: TextStyle(fontSize: 25.0)),
              Text("Duration: $_crossfadeDuration", style: TextStyle(fontSize: 25.0)),
            ],
          ),
          Divider(),
          RaisedButton(
            child: Text("Play Lyriske 9mm"),
            onPressed: () async {
              try {
                await SpotifyMobileSdk.play(spotifyUri: "spotify:track:5jgxQsZq6njAFQm4V2EUzZ");
              } catch (e) {
                print("$e");
              }
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Queue Congratulations"),
            onPressed: () async {
              try {
                await SpotifyMobileSdk.queue(spotifyUri: "spotify:track:3a1lNhkSLSkpJE4MSHpDu9");
              } catch (e) {
                print("$e");
              }
            },
          ),
          RaisedButton(
            child: Text("Queue SAD!"),
            onPressed: () async {
              try {
                await SpotifyMobileSdk.queue(spotifyUri: "spotify:track:3ee8Jmje8o58CHK66QrVC2");
              } catch (e) {
                print("$e");
              }
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Toggle Repeat"),
            onPressed: () async {
              try {
                await SpotifyMobileSdk.toggleRepeat();
              } catch (e) {
                print("$e");
              }
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Toggle Shuffle"),
            onPressed: () async {
              try {
                await SpotifyMobileSdk.toggleShuffle();
              } catch (e) {
                print("$e");
              }
            },
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("PAUSE"),
                onPressed: () async {
                  try {
                    await SpotifyMobileSdk.pause();
                  } catch (e) {
                    print("$e");
                  }
                },
              ),
              RaisedButton(
                child: Text("RESUME"),
                onPressed: () async {
                  try {
                    await SpotifyMobileSdk.resume();
                  } catch (e) {
                    print("$e");
                  }
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Skip Prev"),
                onPressed: () async {
                  try {
                    await SpotifyMobileSdk.skipPrev();
                  } catch (e) {
                    print("$e");
                  }
                },
              ),
              RaisedButton(
                child: Text("Skip Next"),
                onPressed: () async {
                  try {
                    await SpotifyMobileSdk.skipNext();
                  } catch (e) {
                    print("$e");
                  }
                },
              ),
            ],
          ),
          Divider(),
          RaisedButton(
            child: Text("Seek to 2.5 minutes"),
            onPressed: () async {
              try {
                await SpotifyMobileSdk.seekTo(positionMs: 150000);
              } catch (e) {
                print("$e");
              }
            },
          ),
          Divider(),
          RaisedButton(
            child: Text("Seek 10 seconds ahead"),
            onPressed: () async {
              try {
                await SpotifyMobileSdk.seekToRelativePosition(milliseconds: 10000);
              } catch (e) {
                print("$e");
              }
            },
          ),
        ],
      ),
    );
  }
}
