import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class dbHelper {
  dbHelper.createInstance();

  static final dbName = "generalStorage.db";
  static final table1 = "Accounts";

  //columns inside the table
  static final email = "email";
  static final name = "name";
  static final password = "password";

//create login table
  Future<Database> createAccountStorageTable() async {
    String path = p.join(await getDatabasesPath(), dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db
        .execute("CREATE TABLE IF NOT EXISTS $table1(email, name, password)");
  }

//signup
  Future<Database> insertInfo() async {
    String path = p.join(await getDatabasesPath(), dbName);
    var insertDB = openDatabase(path, version: 1, onOpen: (db) async {});
    return insertDB;
  }
}
