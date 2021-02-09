import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class customerdb {
  customerdb.createInstance();

  static final dbName = "customerdb.db";
  static final table1 = "CustomerAccounts";
  static final table2 = "CustomerReservations";

  //columns inside the table
  static final name = "name";
  static final email = "email";
  static final contact = "contact";
  static final bday = "bday";
  static final password = "password";

  //columns inside the reserve table
  static final restoName = 'restoName';
  static final customerName = 'customerName';
  static final customerEmail = 'customerEmail';
  static final seats = 'seats';
  static final date = 'date';
  static final time = 'time';

//create login table
  Future<Database> createAccountStorageTable() async {
    String path = p.join(await getDatabasesPath(), dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $table1(name, email, bday, password, contact)");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $table2(RestoName, customerName, customerEmail, seats, date, time)");
  }

//insert to database
  Future<Database> insertInfo() async {
    String path = p.join(await getDatabasesPath(), dbName);
    var insertDB = openDatabase(path, version: 1, onOpen: (db) async {});
    return insertDB;
  }
}
