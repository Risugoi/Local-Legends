import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:local_legends/restaurant.dart';

class restoReservation extends StatefulWidget {
  final List restoDetails;
  final String restoName, email;
  const restoReservation(
      {Key key, this.restoName, this.restoDetails, this.email})
      : super(key: key);

  @override
  _restoReservation createState() => _restoReservation();
}

class _restoReservation extends State<restoReservation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _num = 0;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
                          builder: (context) => restaurantDisplay(
                                resDetails: widget.restoDetails,
                                email: widget.email,
                              )));
                })),
        backgroundColor: Colors.white,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
                  child: new Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text('Resto Name'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Seats'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _createIncrementDicrementButton(
                                    Icons.remove, () => _dicrement()),
                                Text(_num.toString()),
                                _createIncrementDicrementButton(
                                    Icons.add, () => _increment()),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Date'),
                            Row(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () => selectDate(context),
                                  child: Text('Choose Date'),
                                ),
                                Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Time'),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: null,
                                      child: Text('10AM'),
                                    ),
                                    RaisedButton(
                                      onPressed: null,
                                      child: Text('11AM'),
                                    ),
                                    RaisedButton(
                                      onPressed: null,
                                      child: Text('1PM'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: null,
                                      child: Text('2PM'),
                                    ),
                                    RaisedButton(
                                      onPressed: null,
                                      child: Text('3PM'),
                                    ),
                                    RaisedButton(
                                      onPressed: null,
                                      child: Text('4PM'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: textBox,
                              height: 100,
                              width: 300,
                              child: TextFormField(
                                //controller:
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      top: 2.0, bottom: 2.0, left: 1.0),
                                  hintText: 'Add Notes...',
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: RaisedButton(
                                onPressed: null,
                                child: Text('Reserve a Table'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _increment() {
    setState(() {
      _num++;
    });
  }

  void _dicrement() {
    setState(() {
      if (_num > 0) {
        _num--;
      }
    });
  }

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.grey,
      child: Icon(
        icon,
        color: Colors.black,
        size: 12.0,
      ),
      shape: CircleBorder(),
    );
  }
}
