import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class indivInfo {
  indivInfo.createInstance();
  //table name
  static final table = "RestaurantInfo";
  static final table2 = "Reservation";

  //columns inside the table
  static final restaurantName = "restaurantName";
  static final city = "city";
  static final address = "address";
  static final privateEmail = "privateEmail";
  static final publicEmail = "publicEmail";
  static final description = "description";
  static final contactNum = "contactNum";
  static final cuisine1 = "cuisine1";
  static final cuisine2 = "cuisine2";
  static final cuisine3 = "cuisine3";
  static final cuisine4 = "cuisine4";
  static final cuisine5 = "cuisine5";
  static final cuisine6 = "cuisine6";
  static final delivery = "delivery";
  static final timeOpen = "timeOpen";
  static final price = "price";

  //columns inside reserve table

  Future<Database> insertInfo(String resName) async {
    String path = p.join(await getDatabasesPath(), '$resName.db');
    var insertDB = openDatabase(path, version: 1, onOpen: (db) async {});
    return insertDB;
  }
}
