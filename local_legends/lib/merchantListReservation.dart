import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/database/customerdb.dart';
import 'package:local_legends/merchantHome.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class merchantReserve extends StatefulWidget {
  final String email, name;
  final List resDetails;
  const merchantReserve({Key key, this.resDetails, this.name, this.email})
      : super(key: key);

  @override
  _merchantReserve createState() => _merchantReserve();
}

class _merchantReserve extends State<merchantReserve> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _reserveList = [];
  int _n;
  @override
  void initState() {
    super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    _n = _reserveList.length;
    print(_reserveList);
    print(_n);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => merchantHome(
                                  resDetails: widget.resDetails,
                                  email: widget.email,
                                )));
                  }),
              title: Text('List of Reservations'),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _n,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
                  leading: Image.asset('assets/images/logo.png'),
                  title: Text(_reserveList[index].values.elementAt(1)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_reserveList[index].values.elementAt(3) + ' Seats'),
                      Text(_reserveList[index].values.elementAt(5) +
                          '    ' +
                          _reserveList[index]
                              .values
                              .elementAt(4)
                              .toString()
                              .substring(0, 11)),
                    ],
                  ),
                  trailing: RaisedButton(
                    onPressed: null,
                    child: Text('Accepted'),
                  ),
                );
              },
            )));
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
        "SELECT COUNT(*) FROM ${customerdb.table2} WHERE ${customerdb.restoName}='${widget.name}'");
    if (getNum == 0) {
    } else {
      int userCount = results[0].values.elementAt(0);
      if (userCount > 0) {
        List<Map> reservationList = await db.rawQuery(
            "SELECT * FROM ${customerdb.table2} WHERE ${customerdb.restoName} = '${widget.name}'");
        return reservationList.toList();
      }
    }
  }
}
