class TrainRoute {
  final int numeroTreno;
  final String? categoria;
  final String? categoriaDescrizione;
  final String? origine;
  final String? codOrigine;
  final bool inStazione;
  final bool haCambiNumero;
  final bool nonPartito;
  final DateTime? orarioPartenza;
  final DateTime? orarioArrivo;
  final String? destionazione;
  final int ritardo;
  final String? binarioProgrammatoArrivo;
  final String? binarioEffettivoArrivo;
  final String? binarioProgrammatoPartenza;
  final String? binarioEffettivoPartenza;
  final String compNumeroTreno;

  TrainRoute(
      {required this.numeroTreno,
      required this.origine,
      required this.categoria,
      required this.categoriaDescrizione,
      required this.codOrigine,
      required this.haCambiNumero,
      required this.inStazione,
      required this.nonPartito,
      required this.orarioArrivo,
      required this.orarioPartenza,
      required this.destionazione,
      required this.ritardo,
      required this.binarioEffettivoArrivo,
      required this.binarioEffettivoPartenza,
      required this.binarioProgrammatoArrivo,
      required this.binarioProgrammatoPartenza,
      required this.compNumeroTreno});

  factory TrainRoute.fromJson(Map<String, dynamic> json) => TrainRoute(
        numeroTreno: json["numeroTreno"],
        categoria: json["categoria"],
        categoriaDescrizione: json["categoriaDescrizione"],
        origine: json["origine"],
        destionazione: json["destinazione"],
        codOrigine: json["codOrigine"],
        haCambiNumero: json["haCambiNumero"],
        inStazione: json["inStazione"],
        nonPartito: json["nonPartito"],
        compNumeroTreno: json['compNumeroTreno'],
        orarioArrivo: json['orarioArrivo'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['orarioArrivo']),
        orarioPartenza: json['orarioPartenza'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['orarioPartenza']),
        ritardo: json["ritardo"],
        binarioEffettivoArrivo: json['binarioEffettivoArrivoDescrizione'],
        binarioEffettivoPartenza: json['binarioEffettivoPartenzaDescrizione'],
        binarioProgrammatoArrivo: json['binarioProgrammatoArrivoDescrizione'],
        binarioProgrammatoPartenza:
            json['binarioProgrammatoPartenzaDescrizione'],
      );
}
