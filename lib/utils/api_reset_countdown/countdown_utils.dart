int setCountdownToNext2AM(int countdown) {
  DateTime now = DateTime.now();
  DateTime next2AM = DateTime(now.year, now.month, now.day + 1, 2, 0, 0);
  return countdown = next2AM.difference(now).inSeconds;
}

String formatTime(int seconds) {
  int hours = Duration(seconds: seconds).inHours;
  int minutes = Duration(seconds: seconds).inMinutes.remainder(60);
  int secs = seconds.remainder(60);

  String formattedHours = hours.toString().padLeft(2, '0');
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = secs.toString().padLeft(2, '0');

  return '$formattedHours:$formattedMinutes:$formattedSeconds';
}
