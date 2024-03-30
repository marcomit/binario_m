class TrainInfo {
  final String numeroTreno;
  final String codLocOrig;
  final String descLocOrig;
  final String dataPartenza;

  const TrainInfo(
      {required this.numeroTreno,
      required this.codLocOrig,
      required this.descLocOrig,
      required this.dataPartenza});

  factory TrainInfo.fromJson(Map<String, dynamic> json) {
    return TrainInfo(
        numeroTreno: json['numeroTreno'],
        codLocOrig: json['codLocOrig'],
        descLocOrig: json['descLocOrig'],
        dataPartenza: json['dataPartenza'].toString());
  }
}
