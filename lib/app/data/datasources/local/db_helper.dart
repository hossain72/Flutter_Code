import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  Database? db;

  static const String dbName = "userDB.db";
  static const int dbVersion = 1;

  static const String tableUser = "user";
  static const String columnUserId = "user_id";
  static const String columnUserName = "user_name";
  static const String columnUserGender = "user_gender";

  // Create table user
  static const String createTableUser =
      "create table $tableUser ($columnUserId integer primary key autoincrement, $columnUserName text, $columnUserGender text)";

  Future<Database?> getDB() async {
    db ??= await openDB(dbName);
    return db;
  }

  Future<Database> openDB(String dbName) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, dbName);
    return await openDatabase(
      dbPath,
      onCreate: (database, dbVersion) {
        database.execute(createTableUser);
      },
      version: dbVersion,
    );
  }
}
