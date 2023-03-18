// Dart Packages
import 'dart:convert';
import 'dart:typed_data';

// Third Party Packages
import 'package:csv/csv.dart';

// Extensions
import 'package:attendance_tracker/extensions/capitalize_every_word.dart';

// Functions
import 'convert_date_format.dart';

/// Used to get the list of participants who joined the meeting late.
/// Input CSV should be the one exported from Zoom with the following columns:
/// * Name (Original Name)
/// * Join Time
/// * In Waiting Room
///
/// [fileData] is the Uint8List containing the CSV data.
///
/// [filterDateTime] is the DateTime object used to filter the participants.
///
/// Returns a list of late participant's names.
List<String> getLateParticipants({
  required Uint8List fileData,
  required DateTime filterDateTime,
}) {
  // Decode the CSV data from the Uint8List
  final decodedCsv = utf8.decode(fileData);
  // Use the CsvToListConverter from the csv package to parse the CSV data
  const csvConverter = CsvToListConverter();
  final parsedCsv = csvConverter.convert(decodedCsv);

  final nameColumnIndex = parsedCsv[0].indexOf('Name (Original Name)');
  final joinTimeColumnIndex = parsedCsv[0].indexOf('Join Time');
  final waitRoomColumnIndex = parsedCsv[0].indexOf('In Waiting Room');

  parsedCsv.removeAt(0);

  final waitingRoomData = parsedCsv
      .where(
        (row) => row[waitRoomColumnIndex] == 'Yes',
      )
      .toList();

  final onTimeParticipants = waitingRoomData
      .where(
        (row) {
          final formattedDateTime = convertDateFormat(row[joinTimeColumnIndex]);

          return DateTime.parse(formattedDateTime).compareTo(filterDateTime) <=
              0;
        },
      )
      .map((e) => e[nameColumnIndex].toString().toLowerCase().trim())
      .toList();

  final lateParticipants = waitingRoomData
      .where(
        (row) {
          final formattedDateTime = convertDateFormat(row[joinTimeColumnIndex]);

          return DateTime.parse(formattedDateTime).compareTo(filterDateTime) >
              0;
        },
      )
      .map((e) => e[nameColumnIndex].toString().toLowerCase().trim())
      .toList();

  // Remove late participants that are present in onTimeParticipants
  // as they might have joined the meeting before the filter time
  // but got disconnected and reconnected after the filter time
  lateParticipants
    ..removeWhere((element) => onTimeParticipants.contains(element))
    ..sort();

  return lateParticipants.map((e) => e.capitalizeEveryWord()).toSet().toList();
}
