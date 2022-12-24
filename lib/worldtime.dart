import 'package:http/http.dart' as http;
import 'dart:convert';

const Map<String, String> headers = {
  'Content-type': 'application/json; charset=UTF-8'
};
const String urlCity = 'https://www.timeapi.io/api/Time/current/zone?timeZone=';
const String urlLocation =
    'https://www.timeapi.io/api/Time/current/coordinate?';
final defaultDateTime = DateTime(1990);

class Worldtime {
  /// returns current time at a set city in a TZ format.
  /// Examples of TZ format:
  /// Europe/Amsterdam
  /// America/Santiago
  /// Asia/Istanbul
  /// list of all TZ formats: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
  Future<DateTime> timeByCity(String cityTZ) async {
    final String url = urlCity + cityTZ;
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final String data = utf8.decode(response.bodyBytes.toList());
      if (response.statusCode != 200) {
        return defaultDateTime;
      }
      final Map json = jsonDecode(data);
      return DateTime.tryParse(json['dateTime']) ?? defaultDateTime;
    } catch (e) {
      rethrow;
    }
  }

  /// Returns current time by given latitude, longitude.
  Future<DateTime> timeByLocation(
      {required double latitude, required double longitude}) async {
    final String url = '${urlLocation}latitude=$latitude&longitude=$longitude';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final String data = utf8.decode(response.bodyBytes.toList());
      if (response.statusCode != 200) {
        return defaultDateTime;
      }
      final Map json = jsonDecode(data);
      return DateTime.tryParse(json['dateTime']) ?? defaultDateTime;
    } catch (e) {
      rethrow;
    }
  }

  /// Returns a [String] representation of dateTime.
  /// The [formatter] parameter should look like this:
  /// ```dart
  /// formatter = '\\D \\M \\Y \\H \\m \\N \\O';
  /// ```
  /// where:
  /// [D] - day,
  /// [M] - month,
  /// [Y] - year,
  /// [H] - hour,
  /// [m] - minute,      // Note that it is a small 'm' (not capital 'M')
  /// [n] - millisecond,
  /// [o] - microsecond,
  /// Not all parameters must be present, only the ones you want to display.
  /// You can write anything in the formatter to personalize it.
  /// The double \\ is to inform the function that the following character is a functional one instead of a text.
  ///
  /// Examples:
  /// ```dart
  /// DateTime dateTime = DateTime(2022,12,25,14,30);
  /// ```
  ///
  /// Example 1)
  /// ```dart
  /// String formatter = 'today is \\Dth \\H : \\m';
  /// print(format(dateTime, formatter)); // prints -> Today is 25th 14 : 30
  ///```
  ///
  /// Example 2)
  /// ```dart
  /// String formatter = 'time - \\H:\\m, date - \\D/\\M/\\Y';
  /// print(format(dateTime, formatter)); // prints -> time - 14:30, date - 25/12/2022
  /// ```

  String format({required DateTime dateTime, required String formatter}) {
    Map<String, String> keys = {
      '\\D': dateTime.day.toString(),
      '\\M': dateTime.month.toString(),
      '\\Y': dateTime.year.toString(),
      '\\H':
          dateTime.hour >= 10 ? dateTime.hour.toString() : '0${dateTime.hour}',
      '\\m': dateTime.minute >= 10
          ? dateTime.minute.toString()
          : '0${dateTime.minute}',
      '\\N': dateTime.millisecond >= 100
          ? dateTime.millisecond.toString()
          : dateTime.millisecond >= 10
              ? '0${dateTime.millisecond}'
              : '00${dateTime.millisecond}',
      '\\O': dateTime.microsecond >= 100
          ? dateTime.microsecond.toString()
          : dateTime.microsecond >= 10
              ? '0${dateTime.microsecond}'
              : '00${dateTime.microsecond}',
    };

    keys.forEach((key, value) {
      if (formatter.contains(key)) {
        formatter = formatter.replaceAll(key, value.toString());
      }
    });

    return formatter;
  }
}
