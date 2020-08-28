class SpotifyAlbum {
  final String name;
  final String uri;

  SpotifyAlbum(this.name, this.uri);

  SpotifyAlbum.fromMap(Map<dynamic, dynamic> map)
      : name = map["name"],
        uri = map["uri"];
}
