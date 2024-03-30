import 'dart:async';

import 'package:binario_m/models/db.dart';
import 'package:sqflite/sqflite.dart';

import '../models/station.dart';

const String schemas = """
CREATE TABLE IF NOT EXISTS Stations(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shortName VARCHAR(64),
  longName VARCHAR(64),
  code VARCHAR(10)
);
CREATE TABLE IF NOT EXISTS Solutions(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  departure INTEGER,
  destination INTEGER,
  date DATETIME,
  
  FOREIGN KEY(departure) REFERENCES Stations(id),
  FOREIGN KEY(destination) REFERENCES Stations(id),
  
  UNIQUE(departure, destination)
);
CREATE TABLE IF NOT EXISTS Trains(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  departure INTEGER NOT NULL,
  destination INTEGER NOT NULL,
  trainCode VARCHAR(10) NOT NULL,
  date DATETIME,
  
  FOREIGN KEY(departure) REFERENCES Stations(id),
  FOREIGN KEY(destination) REFERENCES Stations(id),
)
""";

class LocalStorage {
  static late Database db;

  static Future<Database> initDb() async {
    return openDatabase('storage.db',
        version: 1, onCreate: _onDatabaseEvent, onOpen: _onDatabaseEvent);
  }

  static Future<void> _onDatabaseEvent(Database database,
      [int? version]) async {
    // await database.execute('DROP TABLE Stations');
    // await database.delete('DROP TABLE Solutions');
    await Future.any(
        schemas.split(';').map((table) => database.execute(table)));
  }

  static Future<List<SolutionDB>> getRecentlySolutions() async =>
      (await db.rawQuery("""
        SELECT sol.id as id, sol.date as date,
        st.id as departureId, st.shortName as departureShortName, st.longName as departureLongName, st.code as departureCode,
        st2.id as destinationId, st2.shortName as destinationShortName, st2.longName as destinationLongName, st2.code as destinationCode
        FROM Solutions AS sol
        INNER JOIN Stations AS st
        ON st.id=sol.departure
        INNER JOIN Stations AS st2
        ON st2.id=sol.destination
        ORDER BY date DESC""")).map((e) => SolutionDB.fromJson(e)).toList();

  static Future<StationDB> getStationById(int stationId) async =>
      StationDB.fromJson(
          (await db.query('Stations', where: 'id = ?', whereArgs: [stationId]))
              .first);

  static Future<int?> insertStation(Station station) async {
    try {
      return await db.insert('Stations', Station.toJson(station),
          conflictAlgorithm: ConflictAlgorithm.fail);
    } catch (e) {
      return null;
    }
  }

  static Future<int?> insertSolution(SolutionDB solution) async {
    try {
      return await db.insert('Solutions', solution.toJson(),
          conflictAlgorithm: ConflictAlgorithm.fail);
    } catch (e) {
      return null;
    }
  }

  static Future<void> deleteStation(int stationId) async =>
      await db.delete('Stations', where: 'id = ?', whereArgs: [stationId]);

  static Future<void> deleteSolution(int solutionId) async =>
      await db.delete('Solutions', where: 'id = ?', whereArgs: [solutionId]);
}
