import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:local_legends/customerHome.dart';
import 'package:local_legends/customerReserveScreen.dart';

class restaurantDisplay extends StatefulWidget {
  final List resDetails;
  final String email, name;
  const restaurantDisplay({Key key, this.resDetails, this.name, this.email})
      : super(key: key);

  @override
  _restaurantDisplay createState() => _restaurantDisplay();
}

class _restaurantDisplay extends State<restaurantDisplay> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //String name, price, time, delivery, address, number, email, description;

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            title: Text('Restaurant'),
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
                            widget.resDetails[0].values
                                .elementAt(15)
                                .toString(),
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
                              : Text(
                                  'Delivery',
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 25,
                        ),
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
                                    widget.resDetails[0].values.elementAt(2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 35),
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
                      SizedBox(height: 30),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40),
                          child: RaisedButton(
                              color: Colors.blueAccent,
                              child: Text('Reserve a Table'),
                              textColor: Colors.white,
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
                                              name: widget.name,
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
