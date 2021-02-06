import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:local_legends/customerHome.dart';
import 'package:sqflite/sqflite.dart';
import 'package:local_legends/customerReserveScreen.dart';

class restaurantDisplay extends StatefulWidget {
  final List resDetails;
  final String email;
  const restaurantDisplay({Key key, this.resDetails, this.email})
      : super(key: key);

  @override
  _restaurantDisplay createState() => _restaurantDisplay();
}

class _restaurantDisplay extends State<restaurantDisplay> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //String name, price, time, delivery, address, number, email, description;

  @override
  Widget build(BuildContext context) {
    if (widget.resDetails[0].values.elementAt(14).toString() == 'Yes') {
      print('24 hours time');
    } else {
      print(widget.resDetails[0].values.elementAt(0));
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: AppBar(
              flexibleSpace: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.fill,
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                customerHome(email: widget.email)));
                  }),
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
                              child: Text('Reserve a Table'),
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => restoReservation(
                                              restoName: widget
                                                  .resDetails[0].values
                                                  .elementAt(0),
                                              restoDetails: widget.resDetails,
                                              email: widget.email,
                                            )));
                              })),
                    ],
                  ))),
                ),
              ],
            ),
          ),
        ));
  }
}
