import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/database/customerdb.dart';
import 'package:local_legends/merchantHome.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class merchantReserve extends StatefulWidget {
  final String email, name;
  final List resDetails, reserveList;
  const merchantReserve(
      {Key key, this.resDetails, this.reserveList, this.name, this.email})
      : super(key: key);

  @override
  _merchantReserve createState() => _merchantReserve();
}

class _merchantReserve extends State<merchantReserve> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _n;
  @override
  Widget build(BuildContext context) {
    if (widget.reserveList?.isEmpty ?? true) {
      _n = 0;
    } else {
      _n = widget.reserveList.length;
    }

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
                  title: Text(
                      widget.reserveList[index].values.elementAt(1).toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.reserveList[index].values
                              .elementAt(3)
                              .toString() +
                          ' Seats'),
                      Text(widget.reserveList[index].values
                              .elementAt(5)
                              .toString() +
                          '    ' +
                          widget.reserveList[index].values
                              .elementAt(4)
                              .toString()
                              .substring(0, 11)),
                    ],
                  ),
                  trailing: RaisedButton(
                    onPressed: () {
                      _acceptedReservation(
                        widget.reserveList[index].values
                            .elementAt(0)
                            .toString(),
                        widget.reserveList[index].values
                            .elementAt(4)
                            .toString(),
                        widget.reserveList[index].values
                            .elementAt(5)
                            .toString(),
                      );
                      acceptedReservation();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => merchantHome(
                                    resDetails: widget.resDetails,
                                    email: widget.email,
                                  )));
                    },
                    child: Text('Accepted'),
                  ),
                );
              },
            )));
  }

  Widget acceptedReservation() {
    //buttons
    Widget button = FlatButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        child: Text('Continue'));

    //words
    AlertDialog message = AlertDialog(
      title: Text('Success'),
      content: Text('Reservation is Accepted'),
      actions: [button],
    );

    //show the box
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return message;
        });
  }

  _acceptedReservation(String name, String date, String time) async {
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
        print('a');
        int remove = await db.rawDelete(
            "DELETE FROM CustomerReservations WHERE RestoName = '$name' AND date = '$date' AND time = '$time'");
        return remove;
      }
    }
  }
}
