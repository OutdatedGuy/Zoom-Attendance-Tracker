/// Used to convert date-time string to a UTC format.
///
/// [time] format must be MM/dd/yyyy hh:mm:ss AM/PM
///
/// Returns a string in format yyyy-MM-dd HH:mm:ss
String convertDateFormat(String time) {
  // Split the input string into date and time components
  List<String> dateTimeParts = time.split(" ");
  String datePart = dateTimeParts[0];
  String timePart = dateTimeParts[1];

  // Split the date component into day, month, and year
  List<String> dateParts = datePart.split("/");
  String day = dateParts[1].padLeft(2, '0');
  String month = dateParts[0].padLeft(2, '0');
  String year = dateParts[2].padLeft(4, '0');

  String formattedDate = "$year-$month-$day";

  // Convert the time component to 24-hour format
  List<String> timeParts = timePart.split(":");
  int hour = int.parse(timeParts[0]);
  String minute = timeParts[1].padLeft(2, '0');
  String second = timeParts[2].padLeft(2, '0');

  bool isAM = time.contains('AM');
  if (!isAM && hour != 12) {
    hour += 12;
  } else if (isAM && hour == 12) {
    hour -= 12;
  }

  String formattedTime = "${hour.toString().padLeft(2, '0')}:$minute:$second";

  // Return the formatted date and time
  return "$formattedDate $formattedTime";
}
