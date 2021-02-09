import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/merchantListReservation.dart';
import 'package:local_legends/merchantReserveTimeSlot.dart';
import 'package:local_legends/merchantSettings.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:local_legends/customerHome.dart';
import 'package:sqflite/sqflite.dart';
import 'package:local_legends/customerReserveScreen.dart';
import 'package:local_legends/openScreen.dart';
import 'package:local_legends/database/dbHelper.dart';
import 'package:local_legends/database/customerdb.dart';

class merchantHome extends StatefulWidget {
  final List resDetails;
  final String email;
  const merchantHome({Key key, this.resDetails, this.email}) : super(key: key);

  @override
  _merchantHome createState() => _merchantHome();
}

class _merchantHome extends State<merchantHome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //String name, price, time, delivery, address, number, email, description;

  List _reserveList = [];
  @override
  void initState() {
    super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: Text(
                                  widget.resDetails[0].values.elementAt(0))),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Reservation Time Slots'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => reserveTimeSlot(
                                  resDetails: widget.resDetails,
                                  name:
                                      widget.resDetails[0].values.elementAt(0),
                                  email: widget.email,
                                )));
                  },
                ),
                ListTile(
                    title: Text('Reservations'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => merchantReserve(
                                    resDetails: widget.resDetails,
                                    reserveList: _reserveList,
                                    name: widget.resDetails[0].values
                                        .elementAt(0),
                                    email: widget.email,
                                    /*
                                  name: widget.resDetails[0].values
                                      .elementAt(0)
                                      */
                                  )));
                    }),
                ListTile(
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => merchantSettings(
                                resDetails: widget.resDetails,
                                email: widget.email)));
                  },
                ),
                ListTile(
                  title: Text('Signout'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => openScreen()));
                  },
                ),
              ],
            ),
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                      child: new Form(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(
                            top: 35, bottom: 10, left: 35, right: 45),
                        alignment: Alignment(-1, -1),
                        child: Text(widget.resDetails[0].values.elementAt(0)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.resDetails[0].values.elementAt(15)),
                          Text(widget.resDetails[0].values.elementAt(14)),
                          Text(widget.resDetails[0].values.elementAt(13))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 35, bottom: 10, left: 35, right: 45),
                        alignment: Alignment(-1, -1),
                        child: Text(widget.resDetails[0].values.elementAt(2)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.resDetails[0].values.elementAt(6)),
                          Text(widget.resDetails[0].values.elementAt(4)),
                        ],
                      ),
                      SizedBox(height: 50),
                      Container(
                          decoration: textBox,
                          height: 80,
                          width: 300,
                          child:
                              Text(widget.resDetails[0].values.elementAt(5))),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logo.png',
                            height: 55,
                            width: 80,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 55,
                            width: 80,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 55,
                            width: 80,
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          width: 300.0,
                          child: RaisedButton(
                              child: Text('Edit Page'),
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {})),
                    ],
                  ))),
                ),
              ],
            ),
          ),
        ));
  }

  void info() async {
    try {
      List reserveDetails = await _getReservationInfo();
      setState(() {
        _reserveList = reserveDetails;
      });
    } catch (e) {
      print('error');
    }
  }

  _getReservationInfo() async {
    String path = p.join(await getDatabasesPath(), customerdb.dbName);
    var db = await openDatabase(path);
    List<Map> numRows = await db.rawQuery(
        "SELECT COUNT (${customerdb.restoName}) from ${customerdb.table2}");
    int getNum = numRows[0].values.elementAt(0);
    List<Map> results = await db.rawQuery(
        "SELECT COUNT(*) FROM ${customerdb.table2} WHERE ${customerdb.restoName}='${widget.resDetails[0].values.elementAt(0).toString()}'");
    if (getNum == 0) {
    } else {
      int userCount = results[0].values.elementAt(0);
      if (userCount > 0) {
        List<Map> reservationList = await db.rawQuery(
            "SELECT * FROM ${customerdb.table2} WHERE ${customerdb.restoName} = '${widget.resDetails[0].values.elementAt(0).toString()}'");
        return reservationList.toList();
      }
    }
  }
}
