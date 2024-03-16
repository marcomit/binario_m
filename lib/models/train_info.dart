class TrainInfo {
  final String numeroTreno;
  final String codLocOrig;
  final String descLocOrig;
  final String dataPartenza;
  final String corsa;
  final bool h24;

  const TrainInfo(
      {required this.numeroTreno,
      required this.codLocOrig,
      required this.descLocOrig,
      required this.dataPartenza,
      required this.corsa,
      required this.h24});

  factory TrainInfo.fromJson(Map<String, dynamic> json) {
    return TrainInfo(
        numeroTreno: json['numeroTreno'],
        codLocOrig: json['codLocOrig'],
        descLocOrig: json['descLocOrig'],
        dataPartenza: json['dataPartenza'],
        corsa: json['corsa'],
        h24: json['h24'] == 'true');
  }
}
