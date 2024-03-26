class Statistic {
  final int dailyTrains;
  final DateTime lastUpdate;
  final int circulatingTrains;

  Statistic(
      {required this.dailyTrains,
      required this.lastUpdate,
      required this.circulatingTrains});

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
      dailyTrains: json['treniGiorno'],
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(
        json['ultimoAggiornamento'],
      ),
      circulatingTrains: json['roror']);
}
