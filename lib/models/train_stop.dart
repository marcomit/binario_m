class TrainStop {
  final int? numeroTreno;
  final String? categoria;
  final String? categoriaDescrizione;
  final String? origine;
  final String? codOrigine;
  final String destinazione;
  final String? codDestinazione;
  final String? origineEstera;
  final String? destinazioneEstera;
  final String? oraPartenzaEstera;
  final String? oraArrivoEstera;
  final String? binarioEffettivoArrivoCodice;
  final String? binarioEffettivoArrivoDescrizione;
  final String? binarioEffettivoArrivoTipo;
  final String? binarioProgrammatoArrivoCodice;
  final String? binarioProgrammatoArrivoDescrizione;
  final String? binarioEffettivoPartenzaCodice;
  final String? binarioEffettivoPartenzaDescrizione;
  final String? binarioEffettivoPartenzaTipo;
  final String? binarioProgrammatoPartenzaCodice;
  final String binarioProgrammatoPartenzaDescrizione;
  final bool nonPartito;
  final int provvedimento;
  final String riprogrammazione;
  final int orarioPartenza;
  final String? orarioArrivo;
  final String? stazionePartenza;
  final String? stazioneArrivo;
  final String? statoTreno;
  final String? corrispondenze;
  final String? servizi;
  final int ritardo;
  final int dataPartenzaTreno;

  TrainStop({
    required this.nonPartito,
    required this.provvedimento,
    required this.riprogrammazione,
    required this.orarioPartenza,
    this.orarioArrivo,
    this.stazionePartenza,
    this.stazioneArrivo,
    this.statoTreno,
    this.corrispondenze,
    this.servizi,
    required this.ritardo,
    required this.dataPartenzaTreno,
    this.numeroTreno,
    this.categoria,
    required this.destinazione,
    this.categoriaDescrizione,
    this.origine,
    this.codOrigine,
    this.codDestinazione,
    this.origineEstera,
    this.destinazioneEstera,
    this.oraPartenzaEstera,
    this.oraArrivoEstera,
    this.binarioEffettivoArrivoCodice,
    this.binarioEffettivoArrivoDescrizione,
    this.binarioEffettivoArrivoTipo,
    this.binarioProgrammatoArrivoCodice,
    this.binarioProgrammatoArrivoDescrizione,
    this.binarioEffettivoPartenzaCodice,
    this.binarioEffettivoPartenzaDescrizione,
    this.binarioEffettivoPartenzaTipo,
    this.binarioProgrammatoPartenzaCodice,
    this.binarioProgrammatoPartenzaDescrizione = "2",
  });

  factory TrainStop.fromJson(Map<String, dynamic> json) => TrainStop(
        nonPartito: json['nonPartito'],
        provvedimento: json['provvedimento'],
        riprogrammazione: json['riprogrammazione'],
        orarioPartenza: json['orarioPartenza'],
        orarioArrivo: json['orarioArrivo'],
        stazionePartenza: json['stazionePartenza'],
        stazioneArrivo: json['stazioneArrivo'],
        statoTreno: json['statoTreno'],
        corrispondenze: json['corrispondenze'],
        servizi: json['servizi'],
        ritardo: json['ritardo'],
        dataPartenzaTreno: json['dataPartenzaTreno'],
        numeroTreno: json['numeroTreno'],
        categoria: json['categoria'],
        destinazione: json['destinazione'],
        categoriaDescrizione: json['categoriaDescrizione'],
        origine: json['origine'],
        codOrigine: json['codOrigine'],
        codDestinazione: json['codDestinazione'],
        origineEstera: json['origineEstera'],
        destinazioneEstera: json['destinazioneEstera'],
        oraPartenzaEstera: json['oraPartenzaEstera'],
        oraArrivoEstera: json['oraArrivoEstera'],
        binarioEffettivoArrivoDescrizione:
            json['binarioEffettivoArrivoDescrizione'],
        binarioEffettivoArrivoTipo: json['binarioEffettivoArrivoTipo'],
        binarioProgrammatoArrivoCodice: json['binarioProgrammatoArrivoCodice'],
        binarioProgrammatoArrivoDescrizione:
            json['binarioProgrammatoArrivoDescrizione'],
        binarioEffettivoPartenzaCodice: json['binarioEffettivoPartenzaCodice'],
        binarioEffettivoPartenzaDescrizione:
            json['binarioEffettivoPartenzaDescrizione'],
        binarioEffettivoPartenzaTipo: json['binarioEffettivoPartenzaTipo'],
        binarioProgrammatoPartenzaCodice:
            json['binarioProgrammatoPartenzaCodice'],
        binarioProgrammatoPartenzaDescrizione:
            json['binarioProgrammatoPartenzaDescrizione'],
      );
}
