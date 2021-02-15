import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/customerHome.dart';
import 'package:custom_switch/custom_switch.dart';

class customerSettings extends StatefulWidget {
  final String email;
  const customerSettings({Key key, this.email}) : super(key: key);

  @override
  _customerSettings createState() => _customerSettings();
}

class _customerSettings extends State<customerSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _notif = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
              title: Text('Settings'),
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
                    child: new Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Row(children: <Widget>[
                            Text(
                              '      Notifications',
                              style: TextStyle(color: Colors.grey),
                            )
                          ]),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text(
                                    '  Notifications',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    height: 25,
                                    child: CustomSwitch(
                                      activeColor: Colors.blueAccent,
                                      value: _notif,
                                      onChanged: (value) {
                                        setState(() {
                                          _notif = value;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5),
                                Row(children: <Widget>[
                                  Text(
                                    '  [Filler Space]',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          Row(children: <Widget>[
                            Text(
                              '      Account',
                              style: TextStyle(color: Colors.grey),
                            )
                          ]),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text(
                                    '  Change Password',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5),
                                Row(children: <Widget>[
                                  Text(
                                    '  Delete Account',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(height: 5),
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
        ));
  }
}
