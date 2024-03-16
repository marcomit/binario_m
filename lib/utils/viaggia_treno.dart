import 'dart:convert';

import 'package:binario_m/models/news.dart';
import 'package:binario_m/models/solution.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/models/train_stop.dart';
import 'package:binario_m/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ViaggiaTreno {
  static const String baseUrl =
      "http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno";
  static Future<List<Station>> searchStations(String query) async {
    List<Station> stations = [];
    try {
      final response = await get(Uri.parse("$baseUrl/cercaStazione/$query"));
      if (response.statusCode == 200) {
        for (var item
            in (jsonDecode(response.body.toString()) as List<dynamic>)) {
          stations.add(Station.fromJson(json: item));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return stations;
  }

  static Future<List<Solution>> getSolutions(
      Station departure, Station destination, DateTime date) async {
    List<Solution> solutions = [];
    try {
      final Response response = await get(Uri.parse(
          '$baseUrl/soluzioniViaggioNew/${departure.idStation}/${destination.idStation}/${DateFormat('yyyy-MM-ddTHH:mm:ss').format(date)}'));
      for (final solution in jsonDecode(response.body.toString())['soluzioni']
          as List<dynamic>) {
        solutions.add(Solution.fronJson(solution));
      }
    } catch (e) {
      debugPrint('Errore ${e.toString()}');
    }
    debugPrint(solutions.length.toString());
    return solutions;
  }

  static Future<List<News>> getNews() async {
    final Response response = await get(Uri.parse('$baseUrl/news/0/it'));
    final news = (jsonDecode(response.body) as List<dynamic>)
        .map((e) => News.fromJson(e))
        .toList();
    debugPrint(news.length.toString());
    if (news.isNotEmpty) {
      debugPrint(news[0].text);
    }
    return news;
  }

  static Future<List<TrainStop>> getDepartures(Station station) async {
    final now = DateTime.now();
    final formattedTimezoneString =
        "GMT${now.timeZoneOffset.inHours.abs().toString().padLeft(2, '0').replaceAll('-', '+')} (${now.timeZoneName})";
    try {
      final Response response = await get(Uri.parse(
          '$baseUrl/partenze/${station.id}/${days[now.weekday - 1].substring(0, 3)} ${months[now.month - 1].substring(0, 3)} ${now.day} ${now.year} $formattedTimezoneString'));
      debugPrint(response.body);
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => TrainStop.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
