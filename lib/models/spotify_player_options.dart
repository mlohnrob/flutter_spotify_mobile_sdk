class SpotifyPlayerOptions {
  final bool isShuffling;
  final int repeatMode;

  SpotifyPlayerOptions(this.isShuffling, this.repeatMode);

  SpotifyPlayerOptions.fromMap(Map<dynamic, dynamic> map)
      : isShuffling = map["isShuffling"],
        repeatMode = map["repeatMode"];
}
