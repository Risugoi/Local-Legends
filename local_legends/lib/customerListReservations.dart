import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:local_legends/customerHome.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:local_legends/database/customerdb.dart';

class listOfReserve extends StatefulWidget {
  final String email;
  const listOfReserve({Key key, this.email}) : super(key: key);

  @override
  _listOfReserve createState() => _listOfReserve();
}

class _listOfReserve extends State<listOfReserve> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _reserveList = [];
  int _n = 0;
  @override
  void initState() {
    super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    print(_reserveList);
    print(_n);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => customerHome(
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
                  title: Text(_reserveList[index].values.elementAt(0)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_reserveList[index]
                          .values
                          .elementAt(4)
                          .toString()
                          .substring(0, 11)),
                      Text(_reserveList[index].values.elementAt(5)),
                    ],
                  ),
                  trailing: RaisedButton(
                    onPressed: null,
                    child: Text('Cancel'),
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
        _n = _reserveList.length;
      });
    } catch (e) {
      print('error');
    }
  }

  _getReservationInfo() async {
    String path = p.join(await getDatabasesPath(), customerdb.dbName);
    var db = await openDatabase(path);
    List<Map> numRows = await db.rawQuery(
        "SELECT COUNT (${customerdb.customerEmail}) from ${customerdb.table2}");
    int getNum = numRows[0].values.elementAt(0);
    List<Map> results = await db.rawQuery(
        "SELECT COUNT(*) FROM ${customerdb.table2} WHERE ${customerdb.customerEmail}='${widget.email}'");
    if (getNum == 0) {
    } else {
      int userCount = results[0].values.elementAt(0);
      if (userCount > 0) {
        List<Map> reservationList = await db.rawQuery(
            "SELECT * FROM ${customerdb.table2} WHERE ${customerdb.customerEmail} = '${widget.email}'");
        return reservationList.toList();
      }
    }
  }
}
