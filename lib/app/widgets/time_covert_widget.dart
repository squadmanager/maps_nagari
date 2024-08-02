class TimeConvertWidget {
  String to24hours(hourNya, minuteNya) {
    final hour = hourNya.toString().padLeft(2, "0");
    final min = minuteNya.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}