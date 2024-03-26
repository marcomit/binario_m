import 'dart:convert';

import 'package:binario_m/models/news.dart';
import 'package:binario_m/models/solution.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/models/statistic.dart';
import 'package:binario_m/models/train_info.dart';
import 'package:binario_m/models/train_route.dart';
import 'package:binario_m/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ViaggiaTreno {
  static Future<List<Station>?> searchStations(String stationName) async {
    try {
      return (jsonDecode(
                  (await _baseRequest(['cercaStazione', stationName])).body)
              as List<dynamic>)
          .map((json) => Station.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("searchStations$e");
      return null;
    }
  }

  static Future<List<Solution>?> getSolutions(
      Station departure, Station destination, DateTime date) async {
    try {
      return (jsonDecode((await _baseRequest([
        'soluzioniViaggioNew',
        departure.idStation,
        destination.idStation,
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(date)
      ]))
              .body)['soluzioni'] as List<dynamic>)
          .map((e) => Solution.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('getSolutions ${e.toString()}');
      return null;
    }
  }

  static Future<List<News>?> getNews() async {
    try {
      return (jsonDecode((await _baseRequest(['news', '0', 'it'])).body)
              as List<dynamic>)
          .map((e) => News.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint('getNews ${e.toString()}');
      return null;
    }
  }

  static Future<List<TrainRoute>> getTable(Station station,
      [bool isArrival = true]) async {
    final now = DateTime.now();
    try {
      return (jsonDecode((await _baseRequest([
        isArrival ? 'arrivi' : 'partenze',
        station.id,
        '${days[now.weekday - 1].substring(0, 3)} '
            '${months[now.month - 1].substring(0, 3)} '
            '${now.day} '
            '${now.year} '
            '${now.hour}:'
            '${now.minute}:'
            '${now.second}'
      ]))
              .body) as List<dynamic>)
          .map((e) => TrainRoute.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint("get table error$e");
      return [];
    }
  }

  /// **Cerca il numero del treno per ottenere le informazioni**
  ///
  ///
  static Future<TrainInfo?> searchTrainNumber(String trainNumber) async {
    try {
      final response = await _baseRequest(['cercaNumeroTreno', trainNumber]);
      return TrainInfo.fromJson(jsonDecode(response.body));
    } catch (e) {
      debugPrint("searchTrainNumber: $trainNumber");
      return null;
    }
  }

  static Future<List<dynamic>> getTrainDetailsFromTrainInfo(
      TrainInfo trainInfo) async {
    try {
      final response = await _baseRequest([
        'tratteCanvas',
        trainInfo.codLocOrig,
        trainInfo.numeroTreno,
        trainInfo.dataPartenza
      ]);
      if (response.statusCode == 204) {
        debugPrint('Treno cancellato');
      }
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => e)
          .toList();
    } catch (e) {
      debugPrint("getTrainDetails$e");
      return [];
    }
  }

  static Future<Statistic> getStats() async =>
      Statistic.fromJson(jsonDecode((await _baseRequest(
              ['statistiche', DateTime.now().millisecondsSinceEpoch]))
          .body));

  static Future<int?> getRgionByStationCode(String stationCode) async {
    try {
      final response = await _baseRequest(['regione', stationCode]);
      return int.parse(response.body);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Station?> getStationDetails(String stationCode) async {
    try {
      final region = await ViaggiaTreno.getRgionByStationCode(stationCode);
      if (region == null) return null;
      return Station.fromJson(jsonDecode(
          (await _baseRequest(['dettaglioStazione', stationCode, region]))
              .body)['localita']);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response> _baseRequest(List<dynamic> params) async =>
      await get(Uri.parse(
          'http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno/${params.join('/')}'));
}
