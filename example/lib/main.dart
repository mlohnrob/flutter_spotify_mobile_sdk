import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:spotify_mobile_sdk/spotify_mobile_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _connected = false;
  bool _init = false;

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
      print("PLATFORM EXCEPTION INIT");
    }

    // try {
    //   await SpotifyMobileSdk.playPlaylist(playlistId: "37i9dQZF1DX2sUQwD7tbmL");
    // } on PlatformException {
    //   print("PLATFORM EXCEPTION PLAY PLAYLIST");
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _init = init;
      _connected = connected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Spotify SDK Plugin Example APP'),
        ),
        body: Column(
          children: <Widget>[
            Text("Initialized: $_init", style: TextStyle(fontSize: 25.0)),
            Divider(),
            Text("Is Connected: $_connected", style: TextStyle(fontSize: 25.0)),
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
      ),
    );
  }
}
