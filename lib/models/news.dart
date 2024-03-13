class News {
  final String title;
  final int date;
  final bool firstLayer;
  final String text;
  News(
      {required this.date,
      required this.firstLayer,
      required this.text,
      required this.title});
  factory News.fromJson(Map<String, dynamic> json) => News(
      date: json['data'],
      title: json['titolo'],
      firstLayer: json['primoPiano'],
      text: json['testo']);
}
