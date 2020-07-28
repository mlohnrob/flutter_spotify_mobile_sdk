import 'package:flutter/material.dart';

import 'package:spotify_mobile_sdk/spotify_mobile_sdk.dart';

class GetImagePage extends StatefulWidget {
  GetImagePage({Key key}) : super(key: key);

  @override
  _GetImagePageState createState() => _GetImagePageState();
}

class _GetImagePageState extends State<GetImagePage> {
  SpotifyMobileSdk _spotsdk = SpotifyMobileSdk();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _spotsdk.getImage(imageUri: "spotify:image:3269971d34d3f17f16efc2dfa95e302cc961a36c", dimension: SpotifyImageDimension.LARGE),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: AppBar(title: Text("Get Image")),
          body: Center(child: Image.memory(snapshot.data)),
        );
      },
    );
  }
}
