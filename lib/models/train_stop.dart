class TrainStop {
  final bool last;
  final bool first;
  final String id;
  final bool arrivoReale;
  final bool partenzaReale;
  final StopInfo fermata;
  final String stazione;
  final bool stazioneCorrente;

  TrainStop(
      {required this.first,
      required this.id,
      required this.last,
      required this.arrivoReale,
      required this.partenzaReale,
      required this.fermata,
      required this.stazioneCorrente,
      required this.stazione});
  factory TrainStop.fromJson(Map<String, dynamic> json) => TrainStop(
      first: json['first'],
      id: json['id'],
      last: json['last'],
      arrivoReale: json['arrivoReale'],
      partenzaReale: json['partenzaReale'],
      stazione: json['stazione'],
      stazioneCorrente: json['stazioneCorrente'],
      fermata: StopInfo.formJson(json['fermata']));
}

class StopInfo {
  final int? ritardoPartenza;
  final int? ritardoArrivo;
  final int? arrivoTeorico;
  final int? partenzaTeorica;
  final int? arrivoReale;
  final int? partenzaReale;
  final String? binarioEffettivoArrivoDescrizione;
  final String? binarioProgrammatoArrivoDescrizione;
  final String? binarioEffettivoPartenzaDescrizione;
  final String? binarioProgrammatoPartenzaDescrizione;

  StopInfo(
      {required this.ritardoArrivo,
      required this.ritardoPartenza,
      required this.arrivoTeorico,
      required this.partenzaTeorica,
      required this.arrivoReale,
      required this.partenzaReale,
      required this.binarioEffettivoArrivoDescrizione,
      required this.binarioEffettivoPartenzaDescrizione,
      required this.binarioProgrammatoArrivoDescrizione,
      required this.binarioProgrammatoPartenzaDescrizione});
  factory StopInfo.formJson(Map<String, dynamic> json) => StopInfo(
      ritardoArrivo: json['ritardoArrivo'],
      ritardoPartenza: json['ritardoPartenza'],
      arrivoTeorico: json['arrivo_teorico'],
      partenzaTeorica: json['partenza_teorica'],
      arrivoReale: json['arrivoReale'],
      partenzaReale: json['partenzaReale'],
      binarioEffettivoArrivoDescrizione:
          json['binarioEffettivoArrivoDescrizione'],
      binarioEffettivoPartenzaDescrizione:
          json['binarioEffettivoPartenzaDescrizione'],
      binarioProgrammatoArrivoDescrizione:
          json['binarioProgrammatoArrivoDescrizione'],
      binarioProgrammatoPartenzaDescrizione:
          json['binarioProgrammatoPartenzaDescrizione']);
}
