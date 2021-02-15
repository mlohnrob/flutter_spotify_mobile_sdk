import 'package:spotify_mobile_sdk/models/spotify_album.dart';
import 'package:spotify_mobile_sdk/models/spotify_artist.dart';

class SpotifyTrack {
  final String name;
  final String uri;
  final SpotifyAlbum album;
  final SpotifyArtist artist;
  final List<SpotifyArtist> artists;
  final int duration;
  final bool isEpisode;
  final bool isPodcast;
  final String imageUri;

  SpotifyTrack(this.name, this.uri, this.album, this.artist, this.artists, this.duration, this.imageUri, this.isEpisode, this.isPodcast);

  SpotifyTrack.fromMap(Map<dynamic, dynamic> map) {
    this.name = map["name"];
    this.uri = map["uri"];
    this.album = SpotifyAlbum.fromMap(map["album"]);
    this.artist = SpotifyArtist.fromMap(map["artist"]);
    for (int i = 0; i < map["artists"].length; i++) {
      map["artists"][i] = SpotifyArtist.fromMap(map["artists"][i]);
    }
    this.artists = List<SpotifyArtist>.from(map["artists"]);
    this.duration = map["duration"];
    this.isEpisode = map["isEpisode"];
    this.isPodcast = map["isPodcast"];
    this.imageUri = map["imageUri"];
  }
}
