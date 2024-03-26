class RecentlySolution {
  final int? id;
  final String departureStation;
  final String departureStationCode;
  final String arrivalStation;
  final String arrivalStationCode;
  final DateTime date;

  RecentlySolution(
      {required this.arrivalStation,
      required this.arrivalStationCode,
      required this.date,
      required this.departureStation,
      required this.departureStationCode,
      this.id});

  factory RecentlySolution.fromJson(Map<String, dynamic> json) =>
      RecentlySolution(
          arrivalStation: json['ArrivalStation'],
          arrivalStationCode: json['ArrivalStationCode'],
          date: json['Date'],
          departureStation: json['DepartureStation'],
          departureStationCode: json['DepartureStationCode'],
          id: json['Id']);

  Map<String, dynamic> toJson() => {
        'Id': id,
        'ArrivalStation': arrivalStation,
        'ArrivalStationCode': arrivalStationCode,
        'Date': date,
        'DepartureStation': departureStation,
        'DepartureStationCode': departureStationCode
      };

  @override
  String toString() => 'RecentlySolution{'
      'id: $id, '
      'departureStation: $departureStation, '
      'departureStationCode: $departureStationCode, '
      'arrivalStation: $arrivalStation, '
      'arrivalStationCode: $arrivalStationCode, '
      'date: $date}';
}
