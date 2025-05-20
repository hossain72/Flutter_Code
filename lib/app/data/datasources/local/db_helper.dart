import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_code/app/core/extensions/collections/list_extension.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/user_model.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  Database? myDb;

  static const String dbName = "userDB.db";
  static const int dbVersion = 1;

  static const String tableUser = "user";
  static const String columnUserId = "user_id";
  static const String columnUserName = "user_name";
  static const String columnUserGender = "user_gender";
  static const String columnUserMobileNumber = "user_mobile";
  static const String columnUserEmail = "user_email";

  // Create table user
  /*  static const String createTableUser =
      "create table $tableUser ($columnUserId integer primary key autoincrement, $columnUserName text, $columnUserGender text, )";*/
  static const String createTableUser = '''
    CREATE TABLE $tableUser (
      $columnUserId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnUserName TEXT,
      $columnUserGender TEXT,
      $columnUserMobileNumber TEXT UNIQUE,
      $columnUserEmail TEXT UNIQUE
    )
  ''';

  Future<Database?> getDB() async {
    myDb ??= await openDB(dbName);
    return myDb;
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
