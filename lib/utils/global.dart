import 'dart:ui';

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
  'Lunedì',
  'Martedì',
  'Mercoledì',
  'Giovedì',
  'Venerdì',
  'Sabato',
  'Domenica'
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

Color increaseColor(Color color, [int r = 0, int g = 0, int b = 0]) {
  return Color.fromARGB(255, color.red + r, color.green + g, color.blue + b);
}

Color increaseColorFromPercentage(Color color, double percentage) {
  final tot = color.red + color.green + color.blue;
  return Color.fromARGB(
      255,
      color.red + (color.red / tot * percentage).toInt(),
      color.green + (color.green / tot * percentage).toInt(),
      color.blue + (color.blue / tot * percentage).toInt());
}
