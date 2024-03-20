import 'dart:async';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  static late Database db;

  static Future<Database> initDb() async {
    return openDatabase('storage.db',
        version: 1, onCreate: (database, version) async {});
  }
}
