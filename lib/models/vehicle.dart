class Vehicle {
  final String origine;
  final String destinazione;
  final DateTime orarioPartenza;
  final DateTime orarioArrivo;
  final String categoria;
  final String categoriaDescrizione;
  final String numeroTreno;
  Vehicle(
      {required this.categoria,
      required this.categoriaDescrizione,
      required this.destinazione,
      required this.numeroTreno,
      required this.orarioArrivo,
      required this.orarioPartenza,
      required this.origine});
  factory Vehicle.fronJson(Map<String, dynamic> json) => Vehicle(
        origine: json['origine'],
        destinazione: json['destinazione'],
        orarioPartenza: DateTime.parse(json['orarioPartenza']),
        orarioArrivo: DateTime.parse(json['orarioArrivo']),
        categoria: json['categoria'],
        categoriaDescrizione: json['categoriaDescrizione'],
        numeroTreno: json['numeroTreno'],
      );
}
