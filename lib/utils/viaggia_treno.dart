import 'dart:convert';

import 'package:binario_m/models/station.dart';
import 'package:http/http.dart' as http;

class ViaggiaTreno {
  static const String baseUrl =
      "http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno";
  static Future<List<Station>> searchStations(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/cercaStazione/$query"));
    if (response.statusCode == 200) {
      List<Station> stations = [];
      jsonDecode(response.body.toString())
          .forEach((item) => stations.add(Station.fromJson(json: item)));
    }
    return [];
  }
}
