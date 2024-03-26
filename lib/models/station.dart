class Station {
  final String nomeLungo;
  final String nomeBreve;
  final String? label;
  final String id;
  final int? region;
  String get idStation => id.substring(2);
  Station(
      {required this.nomeLungo,
      required this.nomeBreve,
      required this.label,
      required this.id,
      this.region});
  factory Station.fromJson(Map<String, dynamic> json) => Station(
      nomeLungo: json['nomeLungo'],
      nomeBreve: json['nomeBreve'],
      label: json['label'],
      id: json['id']);
}
