class SpotifyPlayerContext {
  final String title;
  final String subtitle;
  final String type;
  final String uri;

  SpotifyPlayerContext(this.title, this.subtitle, this.type, this.uri);

  SpotifyPlayerContext.fromMap(Map<String, String> map)
      : title = map["title"],
        subtitle = map["subtitle"],
        type = map["type"],
        uri = map["uri"];
}
