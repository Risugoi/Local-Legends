import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/merchantHome.dart';

class merchantSettings extends StatefulWidget {
  final String email;
  final List resDetails;
  const merchantSettings({Key key, this.resDetails, this.email})
      : super(key: key);

  @override
  _merchantSettings createState() => _merchantSettings();
}

class _merchantSettings extends State<merchantSettings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                            builder: (context) => merchantHome(
                                  resDetails: widget.resDetails,
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
                          Container(child: Text('Settings')),
                          SizedBox(
                            height: 20,
                          ),
                          Container(child: Text('Notifications')),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text('Notifications'),
                                Text('[Filter Space]'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(child: Text('Account')),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text('Change Password'),
                                Text('Delete Account'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: null,
                            child: Text('Save Changes'),
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
