class SpotifyArtist {
  final String name;
  final String uri;

  SpotifyArtist(this.name, this.uri);

  SpotifyArtist.fromMap(Map<dynamic, dynamic> map)
      : name = map["name"],
        uri = map["uri"];
}
