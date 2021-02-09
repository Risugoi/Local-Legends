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
                        Container(
                          child: Text(widget.name.toString()),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text('Reservation System'),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: borders,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text('Mon'),
                              SizedBox(
                                width: 25,
                              ),
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
                            ],
                          ),
                        ),
                        Container(
                          decoration: borders,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text('Tue'),
                              SizedBox(
                                width: 25,
                              ),
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
                            ],
                          ),
                        ),
                        Container(
                          decoration: borders,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text('Wed'),
                              SizedBox(
                                width: 25,
                              ),
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
                            ],
                          ),
                        ),
                        Container(
                          decoration: borders,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text('Thu'),
                              SizedBox(
                                width: 25,
                              ),
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
                            ],
                          ),
                        ),
                        Container(
                          decoration: borders,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text('Fri'),
                              SizedBox(
                                width: 25,
                              ),
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
                            ],
                          ),
                        ),
                        Container(
                          decoration: borders,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text('Sat'),
                              SizedBox(
                                width: 25,
                              ),
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
                            ],
                          ),
                        ),
                        Container(
                          decoration: borders,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Text('Sun'),
                              SizedBox(
                                width: 25,
                              ),
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
                            ],
                          ),
                        ),
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
