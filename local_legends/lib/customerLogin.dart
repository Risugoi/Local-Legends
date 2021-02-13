import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/openScreen.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:local_legends/database/customerdb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:local_legends/customerHome.dart';

class customerLogin extends StatefulWidget {
  @override
  _customerLogin createState() => _customerLogin();
}

class _customerLogin extends State<customerLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  //controllers
  final _emailCon = new TextEditingController();
  final _passwordCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Colors.white,
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
                        Container(
                          child: Image.asset(
                            'assets/images/finalLogo.png',
                            height: 300,
                            width: 300,
                          ),
                          alignment: Alignment(0, 0),
                        ),
                        Text('CUSTOMER'),
                        SizedBox(height: 50),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  EMAIL ADDRESS'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  PASSWORD'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _passwordCon,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 170,
                          height: 40,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            color: Colors.blueAccent,
                            onPressed: () {
                              _email = _emailCon.text;
                              _password = _passwordCon.text;
                              _verifyInfo();
                            },
                            child: Text('Login'),
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account yet?  "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            customerSignup()));
                              },
                              child: Text(
                                'Create one now',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
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

  Widget loginError() {
    //buttons
    Widget button = FlatButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        child: Text('Continue'));

    //words
    AlertDialog message = AlertDialog(
      title: Text('Login Error'),
      content: Text('Invalid Username/password'),
      actions: [button],
    );

    //show the box
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return message;
        });
  }

  _verifyInfo() async {
    String path = p.join(await getDatabasesPath(), customerdb.dbName);
    var db = await openDatabase(path);
    List<Map> numRows = await db.rawQuery(
        "SELECT COUNT (${customerdb.email}) FROM ${customerdb.table1}");
    int getNum = numRows[0].values.elementAt(0);

    List<Map> results = await db.rawQuery(
        "SELECT COUNT(*) FROM ${customerdb.table1} WHERE ${customerdb.email}='$_email'");
    if (getNum == 0) {
    } else {
      int userCount = results[0].values.elementAt(0);
      if (userCount > 0) {
        List<Map> registeredpassword = await db.rawQuery(
            "SELECT ${customerdb.password} From ${customerdb.table1} WHERE ${customerdb.email}='$_email'");
        String checkPass = registeredpassword[0].values.elementAt(0).toString();

        if (checkPass == _password) {
          //passwordmatch
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => customerHome(
                        email: _email,
                      )));
        } else {
          //password failed
          loginError();
        }
      } else {
        // no emails
        loginError();
      }
    }
  }
}

class customerSignup extends StatefulWidget {
  @override
  _customerSignup createState() => _customerSignup();
}

class _customerSignup extends State<customerSignup> {
  String name;
  String email;
  String contactNumber;
  String bday;
  String password;
  String confirmPassword;

  //controllers
  final _nameCon = new TextEditingController();
  final _emailCon = new TextEditingController();
  final _contactCon = new TextEditingController();
  final _bdayCon = new TextEditingController();
  final _passwordCon = new TextEditingController();
  final _confirmPassCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => customerLogin()));
              }),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: new Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'assets/images/finalLogo.png',
                                height: 200,
                                width: 200,
                              ),
                              alignment: Alignment(0, -0.7),
                            ),
                            Container(
                                child: Column(children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  Name'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _nameCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 2.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ])),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: Column(children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  Contact Number'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _contactCon,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 2.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Contact Number is required';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ])),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: Column(children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  Email'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _emailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ])),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: Column(children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  Birthday'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _bdayCon,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                    hintText: 'MM/DD/YYYY',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Bday is required';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ])),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: Column(children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  Password'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _passwordCon,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ])),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                child: Column(children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  child: Text('  Confirm Password'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: textBox,
                                height: 40,
                                width: 300,
                                child: TextFormField(
                                  controller: _confirmPassCon,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Confirm Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ])),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              width: 170,
                              height: 40,
                              child: RaisedButton(
                                color: Colors.blueAccent,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                onPressed: () {
                                  name = _nameCon.text;
                                  email = _emailCon.text;
                                  bday = _bdayCon.text;
                                  password = _passwordCon.text;
                                  confirmPassword = _confirmPassCon.text;
                                  contactNumber = _contactCon.text;
                                  if (password == confirmPassword) {
                                    _insertAccount();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                customerLogin()));
                                  }
                                },
                              ),
                            ),
                          ],
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

  _insertAccount() async {
    Database db = await customerdb.createInstance().insertInfo();
    Map<String, dynamic> toMap() => {
          "name": name,
          "email": email,
          "bday": bday,
          "password": password,
          "contact": contactNumber,
        };
    return await db.insert(customerdb.table1, toMap());
  }
}
