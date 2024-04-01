import 'package:binario_m/models/db.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';

class RecentlySolutionsProvider with ChangeNotifier {
  RecentlySolutionsProvider() {
    LocalStorage.getRecentlySolutions()
        .then((value) => recentlySolutions = value);
  }
  List<SolutionDB> _recentlySolutions = [];

  List<SolutionDB> get recentlySolutions => _recentlySolutions;

  set recentlySolutions(List<SolutionDB> value) {
    _recentlySolutions = value;
    notifyListeners();
  }

  Future<bool> addSolution(
    Station departure,
    Station destination,
    DateTime date,
  ) async {
    for (final solution in recentlySolutions) {
      if (solution.departure.id!.toString() == departure.id &&
          solution.destination.id!.toString() == destination.id) {
        return false;
      }
    }

    final destinationId = await LocalStorage.insertStation(destination);
    if (destinationId == null) return false;

    final departureId = await LocalStorage.insertStation(departure);
    if (departureId == null) return false;

    final SolutionDB solution = SolutionDB(
        date: date,
        departure: StationDB(departureId, departure.nomeBreve,
            departure.nomeLungo, departure.id),
        destination: StationDB(destinationId, destination.nomeBreve,
            destination.nomeLungo, destination.id));

    final solutionId = await LocalStorage.insertSolution(solution);
    if (solutionId == null) return false;

    recentlySolutions = await LocalStorage.getRecentlySolutions();
    notifyListeners();
    return true;
  }
}
