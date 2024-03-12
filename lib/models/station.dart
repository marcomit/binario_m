class Station {
  final String nomeLungo;
  final String nomeBreve;
  final String? label;
  final String id;
  String get idStation => id.substring(2);
  Station({
    required this.nomeLungo,
    required this.nomeBreve,
    required this.label,
    required this.id,
  });
  factory Station.fromJson({required Map<String, dynamic> json}) => Station(
      nomeLungo: json['nomeLungo'],
      nomeBreve: json['nomeBreve'],
      label: json['label'],
      id: json['id']);
}
