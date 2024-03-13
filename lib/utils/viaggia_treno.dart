import 'dart:convert';

import 'package:binario_m/models/solution.dart';
import 'package:binario_m/models/station.dart';
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
      debugPrint(e.toString());
    }
    debugPrint(solutions.toString());
    return solutions;
  }
}