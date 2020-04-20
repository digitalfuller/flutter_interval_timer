class DurationFormat {
  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  static String minutesAndSeconds(Duration duration) {
    int inMinutes = duration.inMinutes.remainder(Duration.minutesPerHour);
    int inSeconds = duration.inSeconds.remainder(Duration.secondsPerMinute);

    return "${_twoDigits(inMinutes)}:${_twoDigits(inSeconds)}";
  }
}
