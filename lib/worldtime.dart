import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

class Worldtime {
  /// returns current time at a set city in a TZ format.
  /// Examples of TZ format:
  /// Europe/Amsterdam
  /// America/Santiago
  /// Asia/Istanbul
  ///
  /// list of all TZ formats:
  /// https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List

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
  Future<DateTime> timeByLocation({
    required double latitude,
    required double longitude,
  }) async {
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
  /// formatter = '\\D \\M \\Y \\h \\m \\N \\O';
  /// ```
  /// where:
  /// [W] - weekday, [w] - weekday short
  /// [D] - day,
  /// [M] - month, [K] - month in String form, [L] - month in String form but shortened
  /// [Y] - year,
  /// [h] - hour,
  /// [m] - minute,      // Note that it is a small 'm' (not capital 'M' for month)
  /// [s] - second,
  /// [n] - millisecond,
  /// [o] - microsecond,
  /// Not all parameters must be present, only the ones you want to display.
  /// You can write anything in the formatter to personalize it.
  /// The double \\ is to inform the function
  /// that the character after is a functional one instead of a text.
  ///
  /// Examples:
  /// ```dart
  /// DateTime dateTime = DateTime(2022,12,25,14,30);
  /// ```
  ///
  /// Example 1)
  /// ```dart
  /// String formatter = 'today is \\Dth \\h : \\m';
  /// print(format(dateTime, formatter)); // prints -> Today is 25th 14 : 30
  ///```
  ///
  /// Example 2)
  /// ```dart
  /// String formatter = 'time - \\h:\\m, date - \\D/\\M/\\Y';
  /// print(format(dateTime, formatter)); // prints -> time - 14:30, date - 25/12/2022
  /// ```

  String format({
    required DateTime dateTime,
    required String formatter,
  }) {
    Map<String, String> keys = {
      '\\W': dateTime.weekday > 7 ? 'NAN' : weekday[dateTime.weekday - 1],
      '\\w': dateTime.weekday > 7 ? 'NAN' : weekdayShort[dateTime.weekday - 1],
      '\\D': dateTime.day >= 10 ? dateTime.day.toString() : '0${dateTime.day}',
      '\\d': getOrdinalDateSuffix(dateTime.day),
      '\\M': dateTime.month >= 10
          ? dateTime.month.toString()
          : '0${dateTime.month}',
      '\\K': dateTime.month > 12 ? 'NAN' : monthsText[dateTime.month - 1],
      '\\L': dateTime.month > 12 ? 'NAN' : monthsShort[dateTime.month - 1],
      '\\Y': dateTime.year.toString(),
      '\\h':
          dateTime.hour >= 10 ? dateTime.hour.toString() : '0${dateTime.hour}',
      '\\m': dateTime.minute >= 10
          ? dateTime.minute.toString()
          : '0${dateTime.minute}',
      '\\s': dateTime.second >= 10
          ? dateTime.second.toString()
          : '0${dateTime.second}',
      '\\n': dateTime.millisecond >= 100
          ? dateTime.millisecond.toString()
          : dateTime.millisecond >= 10
              ? '0${dateTime.millisecond}'
              : '00${dateTime.millisecond}',
      '\\o': dateTime.microsecond >= 100
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

  String getOrdinalDateSuffix(int day) {
    if (day == 0 || day > 31) return '';
    final lastNum = day % 10;
    if (lastNum == 1) return 'st';
    if (lastNum == 2) return 'nd';
    if (lastNum == 3) return 'rd';
    return 'th';
  }
}
