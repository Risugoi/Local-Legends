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
                          Container(child: Text('Profile')),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: Image.asset('assets/images/logo.png')),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(widget.userInfo[0].values
                                    .elementAt(0)
                                    .toString()),
                                Text(widget.userInfo[0].values
                                    .elementAt(4)
                                    .toString()),
                                Text(widget.userInfo[0].values
                                    .elementAt(1)
                                    .toString()),
                                Text(widget.userInfo[0].values
                                    .elementAt(2)
                                    .toString())
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: null,
                            child: Text('Edit Profile'),
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
