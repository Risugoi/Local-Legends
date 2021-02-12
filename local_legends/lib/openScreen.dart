import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/customerLogin.dart';
import 'package:local_legends/merchantLogin.dart';

class openScreen extends StatefulWidget {
  @override
  _openScreen createState() => _openScreen();
}

class _openScreen extends State<openScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            backgroundColor: Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(children: <Widget>[
                  Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 50.0),
                          child: new Form(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                SizedBox(
                                    height:
                                        40), // height of logo from top of the screen
                                //logo image
                                Container(
                                  child: Image.asset(
                                    'assets/images/finalLogo.png',
                                    height: 300,
                                    width: 300,
                                  ),
                                  alignment: Alignment(0, -0.8),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  width: 250,
                                  height: 50,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  customerLogin()));
                                    },
                                    child: Text("I'M A CUSTOMER"),
                                    textColor: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                    width: 250,
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    resLogin()));
                                      },
                                      child: Text("I'M A RESTAURANT OWNER"),
                                      textColor: Colors.white,
                                    ))
                              ]))))
                ]))));
  }
}
