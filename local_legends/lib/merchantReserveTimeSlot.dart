import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/merchantHome.dart';
import 'package:local_legends/styles/styles.dart';

class reserveTimeSlot extends StatefulWidget {
  final String email, name;
  final List resDetails;
  const reserveTimeSlot({Key key, this.resDetails, this.name, this.email})
      : super(key: key);

  @override
  _reserveTimeSlot createState() => _reserveTimeSlot();
}

class _reserveTimeSlot extends State<reserveTimeSlot> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Text('Reservation System'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => merchantHome(
                              resDetails: widget.resDetails,
                              email: widget.email)));
                })),
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            widget.name.toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '  Mon',
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(children: <Widget>[
                                Text('10AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('11AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('1PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('3PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4PM'),
                              ]),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'assets/images/edit.png',
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '  Tue ',
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(children: <Widget>[
                                Text('10AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('11AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('1PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('3PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4PM'),
                              ]),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'assets/images/edit.png',
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '  Wed',
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(children: <Widget>[
                                Text('10AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('11AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('1PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('3PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4PM'),
                              ]),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'assets/images/edit.png',
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '  Thu ',
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(children: <Widget>[
                                Text('10AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('11AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('1PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('3PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4PM'),
                              ]),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'assets/images/edit.png',
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '  Fri   ',
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(children: <Widget>[
                                Text('10AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('11AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('1PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('3PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4PM'),
                              ]),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'assets/images/edit.png',
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '  Sat ',
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(children: <Widget>[
                                Text('10AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('11AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('1PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('3PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4PM'),
                              ]),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'assets/images/edit.png',
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '  Sun',
                                style: TextStyle(fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Row(children: <Widget>[
                                Text('10AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('11AM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('1PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('2PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('3PM'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('4PM'),
                              ]),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                'assets/images/edit.png',
                                height: 20,
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          onPressed: () {},
                          child: Text(
                            'Save Changes',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blueAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
