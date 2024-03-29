import 'package:binario_m/models/db.dart';
import 'package:binario_m/models/station.dart';
import 'package:binario_m/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';

class RecentlySolutionsProvider with ChangeNotifier {
  List<SolutionDB> _recentlySolutions = [];

  List<SolutionDB> get recentlySolutions => _recentlySolutions;
  
  set recentlySolutions(List<SolutionDB> value) {
    _recentlySolutions = value;
    notifyListeners();
  }
  
  Future<void> addSolution(Station departure, Station destination, DateTime date, ) async {
    final destinationId = await LocalStorage.insertStation(departure);
    if(destinationId == null) return;
    
    final departureId = await LocalStorage.insertStation(destination);
    if(departureId == null) return;
    
    final solution = await LocalStorage.insertSolution(SolutionDB(departure: departureId, destination: destinationId, date: date));
    if(solution == null) return;
    
    recentlySolutions.add(SolutionDB(departure: departure, destination: destination, date: date))
  }
}
