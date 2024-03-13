import 'package:binario_m/models/vehicle.dart';

class Solution {
  final Duration duration;
  final List<Vehicle> vehicles;
  Solution({
    required this.duration,
    required this.vehicles,
  });
  factory Solution.fronJson(Map<String, dynamic> json) {
    List<int?> duration = json['durata'] == null
        ? [null, null]
        : json['durata']
            .toString()
            .split(':')
            .map((e) => int.parse(e))
            .toList();
    return Solution(
        duration: Duration(hours: duration[0]!, minutes: duration[1]!),
        vehicles: List<Vehicle>.from(
            json['vehicles'].map((item) => Vehicle.fronJson(item))));
  }
}
