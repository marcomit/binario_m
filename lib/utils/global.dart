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

String formatDate(DateTime? date) {
  if (date == null) return '--:--';
  return '${formatNumber(date.hour)}:${formatNumber(date.minute)}';
}

enum TrainState { done, inProgress, todo }

bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.day == now.day &&
      date.month == now.month &&
      date.year == now.year;
}

T replaceOn<T>(T? from, T? onValue, T to) {
  if (from == onValue) return to;
  if (from != null) return from;
  return to;
}
