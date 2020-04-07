
String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

String durationFormat(Duration duration) {
  int inMinutes = duration.inMinutes.remainder(Duration.minutesPerHour);
  int inSeconds = duration.inSeconds.remainder(Duration.secondsPerMinute);

  return (inMinutes > 0 ? "$inMinutes:" : "") + (inMinutes > 0 ? twoDigits(inSeconds) : "$inSeconds");
}