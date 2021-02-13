import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/customerLogin.dart';
import 'package:local_legends/database/customerdb.dart';
import 'package:local_legends/database/dbHelper.dart';
import 'package:local_legends/database/feeddb.dart';
import 'package:local_legends/openScreen.dart';
import 'package:local_legends/merchantLogin.dart';
import 'package:local_legends/customerHome.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    // account login - signup table
    WidgetsBinding.instance.addPersistentFrameCallback(
        (_) => dbHelper.createInstance().createAccountStorageTable());
    //feed table
    WidgetsBinding.instance.addPersistentFrameCallback(
        (_) => feeddb.createInstance().createFeedTable());
    //customer accounts table
    WidgetsBinding.instance.addPersistentFrameCallback(
        (_) => customerdb.createInstance().createAccountStorageTable());

    return openScreen();
    //return resSignup1();
    //return customerLogin();
    //return resLogin();
  }
}
