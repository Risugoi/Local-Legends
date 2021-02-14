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
                    onPressed: null,
                    child: Text('Accepted'),
                  ),
                );
              },
            )));
  }
}
