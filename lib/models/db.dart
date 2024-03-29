class StationDB{
  final int? id;
  final String shortName;
  final String longName;
  final String code;

  StationDB(this.id, this.shortName, this.longName, this.code);

  Map<String, dynamic> toJson() => {
    'id': id,
    'shortName': shortName,
    'longName': longName,
    'code': code
  };

  factory StationDB.fromJson(Map<String, dynamic> json) => StationDB(
    json['id'],
    json['shortName'],
    json['longName'],
    json['code']
  );
}

class SolutionDB{
  final int? id;
  final int departure;
  final int destination;
  final DateTime date;

  SolutionDB({this.id, required this.departure, required this.destination, required this.date});

  factory SolutionDB.fromJson(Map<String, dynamic> json) => SolutionDB(
    id: json['id'],
    departure: json['departure'],
    destination: json['destination'],
    date: DateTime.parse(json['date'])
  );

  Map<String, dynamic> toJson() => {
    'departure': departure,
    'destination': destination,
    'date': date.toIso8601String()
  };

}