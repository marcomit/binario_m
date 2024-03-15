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
  final int tratta;
  final int regione;
  final String? origineZero;
  final String? destinazioneZero;
  final String? orarioPartenzaZero;
  final String? orarioArrivoZero;
  final bool circolante;
  final int codiceCliente;
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
  final String? subTitle;
  final String? esisteCorsaZero;
  final String? orientamento;
  final bool inStazione;
  final bool haCambiNumero;
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
  final String tipoProdotto;
  final String compOrarioPartenzaZeroEffettivo;
  final String? compOrarioArrivoZeroEffettivo;
  final String compOrarioPartenzaZero;
  final String? compOrarioArrivoZero;
  final String? compOrarioArrivo;
  final String compOrarioPartenza;
  final String compNumeroTreno;
  final List<String> compOrientamento;
  final String compTipologiaTreno;
  final String compClassRitardoTxt;
  final String compClassRitardoLine;
  final String compImgRitardo2;
  final String compImgRitardo;
  final List<String> compRitardo;
  final List<String> compRitardoAndamento;
  final List<String> compInStazionePartenza;
  final List<String> compInStazioneArrivo;
  final String? compOrarioEffettivoArrivo;
  final String compDurata;
  final String compImgCambiNumerazione;
  final String? materiale_label;
  final int dataPartenzaTreno;

  TrainStop(
      {required this.inStazione,
      required this.haCambiNumero,
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
      required this.tipoProdotto,
      required this.compOrarioPartenzaZeroEffettivo,
      this.compOrarioArrivoZeroEffettivo,
      required this.compOrarioPartenzaZero,
      this.compOrarioArrivoZero,
      this.compOrarioArrivo,
      required this.compOrarioPartenza,
      required this.compNumeroTreno,
      required this.compOrientamento,
      required this.compTipologiaTreno,
      required this.compClassRitardoTxt,
      required this.compClassRitardoLine,
      required this.compImgRitardo2,
      required this.compImgRitardo,
      required this.compRitardo,
      required this.compRitardoAndamento,
      required this.compInStazionePartenza,
      required this.compInStazioneArrivo,
      this.compOrarioEffettivoArrivo,
      required this.compDurata,
      required this.compImgCambiNumerazione,
      this.materiale_label,
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
      this.tratta = 0,
      this.regione = 0,
      this.origineZero,
      this.destinazioneZero,
      this.orarioPartenzaZero,
      this.orarioArrivoZero,
      this.circolante = true,
      this.codiceCliente = 2,
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
      this.subTitle,
      this.esisteCorsaZero,
      this.orientamento});
}
