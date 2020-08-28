class SpotifyPlayerRestrictions {
  final bool canRepeatContext;
  final bool canRepeatTrack;
  final bool canSeek;
  final bool canSkipNext;
  final bool canSkipPrev;
  final bool canToggleShuffle;

  SpotifyPlayerRestrictions(this.canRepeatContext, this.canRepeatTrack, this.canSeek, this.canSkipNext, this.canSkipPrev, this.canToggleShuffle);

  SpotifyPlayerRestrictions.fromMap(Map<dynamic, dynamic> map)
      : canRepeatContext = map["canRepeatContext"],
        canRepeatTrack = map["canRepeatTrack"],
        canSeek = map["canSeek"],
        canSkipNext = map["canSkipNext"],
        canSkipPrev = map["canSkipPrev"],
        canToggleShuffle = map["canToggleShuffle"];
}
