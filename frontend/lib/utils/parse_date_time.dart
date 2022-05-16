DateTime parseDate(String time) {
  return DateTime.parse(time.substring(0, 10) + " " + time.substring(11, 19));
}