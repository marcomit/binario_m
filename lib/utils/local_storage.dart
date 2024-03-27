import 'dart:async';
import 'package:binario_m/models/recently_solution.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  static late Database db;

  static Future<Database> initDb() async {
    return openDatabase('storage.db',
        version: 1, onCreate: _onDatabaseEvent, onOpen: _onDatabaseEvent);
  }

  static Future<dynamic> getRecentlySolutions() async =>
      await db.query("RecentlySolutions");

  static Future<dynamic> getNotificationScheduled() async =>
      await db.query('NotificationScheduled');

  static Future<dynamic> getFavouritesRoutes() async =>
      await db.query('FavouritesRoute', orderBy: 'Date DESC');

  static Future<dynamic> insertRecentlySolutions(
          RecentlySolution solution) async =>
      await db.insert('RecentlySolutions', solution.toJson());

  static Future<void> _onDatabaseEvent(Database database,
      [int? version]) async {
    await database.execute("""
        CREATE TABLE IF NOT EXISTS RecentlySolutions(
          Id INTEGER PRIMARY KEY AUTOINCREMENT,
          DepartureStation VARCHAR(50),
          DepartureStationCode VARCHAR(10),
          ArrivalStation VARCHAR(50),
          ArrivalStationCode VARCHAR(10),
          Date VARCHAR(15)
        );
      """);
    await database.execute("""
        CREATE TABLE IF NOT EXISTS NotificationScheduled(
          Id INTEGER PRIMARY KEY AUTOINCREMENT,
          Time DATETIME NOT NULL,
          TrainNumber VARCHAR(10),
          DepartureStation VARCHAR(10),
          TimeDeparture VARCHAR(15)
        );
      """);
    await database.execute("""
        CREATE TABLE IF NOT EXISTS FavouritesRoute(
          Id INTEGER PRIMARY KEY AUTOINCREMENT,
          DepartureStation VARCHAR(10),
          ArrivalStation VARCHAR(10),
          Date VARCHAR(15)
        );
      """);
  }

  static Future<List<dynamic>> getAllData(String table) async =>
      await db.query(table);

  static Future<List<RecentlySolution>> getAllRecentlySolutions() async =>
      (await getAllData('RecentlySolutions'))
          .map((e) => RecentlySolution.fromJson(e))
          .toList();
}
