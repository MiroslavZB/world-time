const Map<String, String> headers = {
  'Content-type': 'application/json; charset=UTF-8'
};

const String urlCity = 'https://www.timeapi.io/api/Time/current/zone?timeZone=';

const String urlLocation =
    'https://www.timeapi.io/api/Time/current/coordinate?';

final defaultDateTime = DateTime(1990);

const List<String> monthsText = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> monthsShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec',
];

const List<String> weekday = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const List<String> weekdayShort = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
