class SpotifyCrossfadeState {
  final bool isEnabled;
  final int duration;

  SpotifyCrossfadeState(this.isEnabled, this.duration);

  SpotifyCrossfadeState.fromMap(Map<String, dynamic> map)
      : isEnabled = map["isEnabled"],
        duration = map["duration"];
}
