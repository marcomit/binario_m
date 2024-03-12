import 'package:binario_m/models/vehicle.dart';

class Solution {
  final Duration durata;
  final List<Vehicle> vehicles;
  Solution({
    required this.durata,
    required this.vehicles,
  });
  factory Solution.fronJson(Map<String, dynamic> json) {
    List<String> duration = json['durata'].toString().split(':');
    return Solution(
        durata: Duration(
            hours: int.parse(duration[0]), minutes: int.parse(duration[1])),
        vehicles: List<Vehicle>.from(
            json['vehicles'].map((item) => Vehicle.fronJson(item))));
  }
}
