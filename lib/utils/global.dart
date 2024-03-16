enum Tabs { route, train, station }

const List<String> months = [
  'Genuary',
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
  'December'
];

const List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

String formatNumber(int number) {
  if (number < 10) return '0$number';
  return '$number';
}
