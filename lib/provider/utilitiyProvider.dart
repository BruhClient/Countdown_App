class UtilityProvider {
  String formatDateTime(DateTime value) {
    String month =
        value.month < 10 ? "0${value.month}" : value.month.toString();
    String days = value.day < 10 ? "0${value.day}" : value.day.toString();
    return "${value.year}-$month-$days";
  }

  DateTime getCurrentTime() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  String getDuration(int seconds) {
    if (seconds % 60 < 10) {
      return "${seconds ~/ 60}:0${seconds % 60}";
    }
    return "${seconds ~/ 60}:${seconds % 60}";
  }
}
