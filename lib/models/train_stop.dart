class TrainRoute {
  final int numeroTreno;
  final String? categoria;
  final String? categoriaDescrizione;
  final String? origine;
  final String? codOrigine;
  final bool inStazione;
  final bool haCambiNumero;
  final bool nonPartito;
  final int ritardo;
  final String? compOrarioPartenzaZeroEffettivo;
  final String? compOrarioArrivoZeroEffettivo;
  final String? compOrarioPartenzaZero;
  final String? compOrarioArrivoZero;
  final String? compOrarioArrivo;
  final String? compOrarioPartenza;

  TrainRoute(
      {required this.numeroTreno,
      required this.origine,
      required this.categoria,
      required this.categoriaDescrizione,
      required this.codOrigine,
      required this.haCambiNumero,
      required this.inStazione,
      required this.nonPartito,
      required this.compOrarioArrivo,
      required this.compOrarioArrivoZero,
      required this.compOrarioArrivoZeroEffettivo,
      required this.compOrarioPartenza,
      required this.compOrarioPartenzaZero,
      required this.compOrarioPartenzaZeroEffettivo,
      required this.ritardo});

  factory TrainRoute.fromJson(Map<String, dynamic> json) => TrainRoute(
        numeroTreno: json["numeroTreno"],
        categoria: json["categoria"],
        categoriaDescrizione: json["categoriaDescrizione"],
        origine: json["origine"],
        codOrigine: json["codOrigine"],
        haCambiNumero: json["haCambiNumero"],
        inStazione: json["inStazione"],
        nonPartito: json["nonPartito"],
        compOrarioArrivo: json["compOrarioArrivo"],
        compOrarioArrivoZero: json["compOrarioArrivoZero"],
        compOrarioArrivoZeroEffettivo: json["compOrarioArrivoZeroEffettivo"],
        compOrarioPartenza: json["compOrarioPartenza"],
        compOrarioPartenzaZero: json["compOrarioPartenzaZero"],
        compOrarioPartenzaZeroEffettivo:
            json["compOrarioPartenzaZeroEffettivo"],
        ritardo: json["ritardo"],
      );
}
