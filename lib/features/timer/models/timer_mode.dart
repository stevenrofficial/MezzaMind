enum TimerType {
  countdown,
  countUp,
}

enum TimerStatus {
  idle,
  running,
  paused,
  completed,
}

class FocusPreset {
  final String label;
  final int minutes;
  final String tag;

  const FocusPreset({
    required this.label,
    required this.minutes,
    required this.tag,
  });

  Duration get duration => Duration(minutes: minutes);
}

