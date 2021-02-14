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

  List _reserveList = [];
  @override
  void initState() {
    super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    String restoName1 = widget.resDetails[0].values
            .elementAt(0)
            .toString()
            .replaceAll(' ', '') +
        '1';
    String restoName2 = widget.resDetails[0].values
            .elementAt(0)
            .toString()
            .replaceAll(' ', '') +
        '2';
    String restoName3 = widget.resDetails[0].values
            .elementAt(0)
            .toString()
            .replaceAll(' ', '') +
        '3';
    String restoName4 = widget.resDetails[0].values
            .elementAt(0)
            .toString()
            .replaceAll(' ', '') +
        '4';
    print(restoName1);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.blue,
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
                              child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/finalLogo.png',
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(height: 10),
                              Text(widget.resDetails[0].values.elementAt(0)),
                            ],
                          )),
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
                  title: Text('Log out'),
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
                        child: Image.asset(
                          'assets/images/$restoName1.png',
                          height: 221,
                          width: 750,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(
                            top: 35, bottom: 10, left: 35, right: 45),
                        alignment: Alignment(-1, -1),
                        child: Text(
                          widget.resDetails[0].values.elementAt(0),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            widget.resDetails[0].values.elementAt(15),
                            style: TextStyle(color: Colors.blue),
                          ),
                          widget.resDetails[0].values
                                      .elementAt(14)
                                      .toString() ==
                                  'Yes'
                              ? Text(
                                  '24 Hours',
                                  style: TextStyle(color: Colors.blue),
                                )
                              : Text(
                                  '24 Hours',
                                  style: TextStyle(color: Colors.grey),
                                ),
                          widget.resDetails[0].values
                                      .elementAt(13)
                                      .toString() ==
                                  'Yes'
                              ? Text(
                                  'Delivery',
                                  style: TextStyle(color: Colors.blue),
                                )
                              : Text('Delivery',
                                  style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 35, bottom: 10, left: 35, right: 45),
                        alignment: Alignment(-1, -1),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/location.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Expanded(
                                child: Text(
                                  widget.resDetails[0].values.elementAt(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/phone.png',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.resDetails[0].values.elementAt(6)),
                              ],
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/email.png',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.resDetails[0].values.elementAt(4)),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: textBox2,
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
                            'assets/images/$restoName2.png',
                            height: 80,
                            width: 80,
                          ),
                          Image.asset(
                            'assets/images/$restoName3.png',
                            height: 80,
                            width: 80,
                          ),
                          Image.asset(
                            'assets/images/$restoName4.png',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40),
                          child: RaisedButton(
                              color: Colors.blueAccent,
                              child: Text('Edit Page'),
                              textColor: Colors.white,
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
