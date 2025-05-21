import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  static const String columnUserMobileNumber = "user_mobile";
  static const String columnUserEmail = "user_email";

  // Create table user
  /*  static const String createTableUser =
      "create table $tableUser ($columnUserId integer primary key autoincrement, $columnUserName text, $columnUserGender text, )";*/
  static const String createTableUser = '''
    CREATE TABLE $tableUser (
      $columnUserId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnUserName TEXT,
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

  Future<bool> createUser({
    required String name,
    required String mobile,
    required String email,
  }) async {
    var db = await getDB();

    try {
      int rowsAffected =
          await db?.insert(tableUser, {
            columnUserName: name,
            columnUserMobileNumber: mobile,
            columnUserEmail: email,
          }) ??
          0;

      return rowsAffected > 0;
    } catch (e) {
      debugPrint("Error inserting user: $e");
      return false;
    }
  }

  Future<UserModel> getAllUser() async {
    var db = await getDB();

    List<Map<String, dynamic>> users = await db?.query(tableUser) ?? [];

    if (users.isEmpty) {
      return UserModel(status: true, message: "succeeded", data: []);
    }

    List<User> userList = users.map((user) => User.fromJson(user)).toList();
    // Return the UserMode object
    return UserModel(status: true, message: "succeeded", data: userList);
  }
}
