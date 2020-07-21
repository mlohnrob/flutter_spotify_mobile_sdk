class CrossFadeState {
  final bool isEnabled;
  final int duration;

  CrossFadeState(this.isEnabled, this.duration);

  CrossFadeState.fromMap(Map<String, dynamic> map)
      : isEnabled = map["isEnabled"],
        duration = map["duration"];
}
