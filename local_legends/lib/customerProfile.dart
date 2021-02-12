import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/customerHome.dart';

class customerProfile extends StatefulWidget {
  final String email;
  final List userInfo;
  const customerProfile({Key key, this.userInfo, this.email}) : super(key: key);

  @override
  _customerProfile createState() => _customerProfile();
}

class _customerProfile extends State<customerProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
              title: Text('Profile'),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => customerHome(
                                  email: widget.email,
                                )));
                  })),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: Image.asset(
                            'assets/images/logo.png',
                            height: 50,
                            width: 50,
                          )),
                          SizedBox(height: 30),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text(
                                    widget.userInfo[0].values
                                        .elementAt(0)
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(children: <Widget>[
                                  Text(
                                    widget.userInfo[0].values
                                        .elementAt(4)
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ]),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(children: <Widget>[
                                  Text(
                                    widget.userInfo[0].values
                                        .elementAt(1)
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: <Widget>[
                                  Text(
                                    widget.userInfo[0].values
                                        .elementAt(2)
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  )
                                ])
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            onPressed: () {},
                            child: Text('Edit Profile'),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
