import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/database/dbHelper.dart';
import 'package:local_legends/database/feeddb.dart';
import 'package:local_legends/database/indivInfo.dart';
import 'package:local_legends/merchantHome.dart';
import 'package:local_legends/openScreen.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class resLogin extends StatefulWidget {
  @override
  _resLogin createState() => _resLogin();
}

class _resLogin extends State<resLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //strings that will be used
  String _name = '';
  String _email;
  String _password;
  List _restoDetails = [];

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
                                  height: 150,
                                ),
                                Container(
                                  child: Text('logo'),
                                ),
                                SizedBox(
                                  height: 150,
                                ),
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
                                      hintText: 'Email',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Email is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: textBox,
                                  height: 40,
                                  width: 300,
                                  child: TextFormField(
                                    controller: _passwordCon,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 1.0),
                                      hintText: 'Password',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Password is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: RaisedButton(
                                    onPressed: () {
                                      _email = _emailCon.text;
                                      _password = _passwordCon.text;
                                      _verifyInfo();
                                    },
                                    child: Text('Login'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Own a restaurant?  "),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    resSignup1()));
                                      },
                                      child: Text(
                                        'Signup',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )))
                ]))));
  }

  Widget loginError() {
    //buttons
    Widget button = FlatButton(
        onPressed: () => Navigator.pop(context, false),
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
    String path = p.join(await getDatabasesPath(), dbHelper.dbName);
    var db = await openDatabase(path);
    List<Map> numRows = await db
        .rawQuery("SELECT COUNT (${dbHelper.email}) FROM ${dbHelper.table1}");
    int getNum = numRows[0].values.elementAt(0);

    List<Map> results = await db.rawQuery(
        "SELECT COUNT(*) FROM ${dbHelper.table1} WHERE ${dbHelper.email}='$_email'");
    if (getNum == 0) {
    } else {
      int userCount = results[0].values.elementAt(0);
      if (userCount > 0) {
        List<Map> registeredpassword = await db.rawQuery(
            "SELECT ${dbHelper.password} From ${dbHelper.table1} WHERE ${dbHelper.email}='$_email'");
        String checkPass = registeredpassword[0].values.elementAt(0).toString();

        if (checkPass == _password) {
          //passwordmatch
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => merchantHome(
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

class resSignup1 extends StatefulWidget {
  @override
  _resSignup1 createState() => _resSignup1();
}

class _resSignup1 extends State<resSignup1> {
  //string that are used
  String resName;
  String city;
  String address;
  String resConNum;
  String resPrivEmail;
  String password;
  String confirmPassword;

  //controllers
  final _resNameCon = new TextEditingController();
  final _addressCon = new TextEditingController();
  final _resConNumCon = new TextEditingController();
  final _repFNCon = new TextEditingController();
  final _repLNCon = new TextEditingController();
  final _resEmailCon = new TextEditingController();
  final _repConNumCon = new TextEditingController();
  final _passwordCon = new TextEditingController();
  final _confirmPasswordCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            title: Text('Register'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => resLogin()));
              },
            ),
          ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Restaurant Information'),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: textBox,
                                height: 40.0,
                                width: 300.0,
                                child: TextFormField(
                                  controller: _resNameCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                    hintText: 'Restaurant Name*',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Retaurant Name is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, bottom: 2.0, left: 1.0),
                                  child: DropdownButton<String>(
                                    hint: Text('Select City*'),
                                    value: city,
                                    isExpanded: true,
                                    onChanged: (String value) {
                                      setState(() {
                                        city = value;
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Makati City',
                                        child: Text('Makati City'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Taguig',
                                        child: Text('Taguig'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Manila',
                                        child: Text('Manila'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: textBox,
                                height: 100.0,
                                width: 300.0,
                                child: TextFormField(
                                  controller: _addressCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                    hintText: 'Restaurant Complete Address*',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Retaurant Address is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: textBox,
                                height: 40.0,
                                width: 300.0,
                                child: TextFormField(
                                  controller: _resEmailCon,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                    hintText: 'Private Email*',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: textBox,
                                height: 40.0,
                                width: 300.0,
                                child: TextFormField(
                                  controller: _passwordCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                    hintText: 'Password*',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: textBox,
                                height: 40.0,
                                width: 300.0,
                                child: TextFormField(
                                  controller: _confirmPasswordCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                    hintText: 'Confirm Password*',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Confirm Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                ),
                                width: 300.0,
                                child: RaisedButton(
                                    child: Text(
                                      "Next",
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onPressed: () {
                                      password = _passwordCon.text;
                                      confirmPassword =
                                          _confirmPasswordCon.text;
                                      resName = _resNameCon.text;
                                      address = _addressCon.text;
                                      resPrivEmail = _resEmailCon.text;
                                      if (password == confirmPassword) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    resSignup2(
                                                        restaurantName: resName,
                                                        city: city,
                                                        add: address,
                                                        privateEmail:
                                                            resPrivEmail,
                                                        pw: password)));
                                      }
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class resSignup2 extends StatefulWidget {
  //get info
  final String restaurantName;
  final String city;
  final String add;
  final String privateEmail;
  final String pw;

  const resSignup2(
      {Key key,
      this.restaurantName,
      this.city,
      this.add,
      this.privateEmail,
      this.pw})
      : super(key: key);

  @override
  _resSignup2 createState() => _resSignup2();
}

enum Delivery { Yes, No }
enum OpenTime { Yes, No }
enum PriceRange { P, PP, PPP }

class _resSignup2 extends State<resSignup2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _resName;
  String _city;
  String _address;
  String _privEmail;
  String _password;

  String description;
  String email2;
  String contactNum;
  String cuisine1;
  String cuisine2;
  String cuisine3;
  String cuisine4;
  String cuisine5;
  String cuisine6;
  String delivery;
  String time;
  String price;

  //for checkbox
  bool filipino = false;
  bool chinese = false;
  bool japanese = false;
  bool korean = false;
  bool american = false;
  bool others = false;

  Delivery _delivery = Delivery.Yes;
  OpenTime _timeAvailable = OpenTime.Yes;
  PriceRange _price = PriceRange.P;
  var _cuisine = [];

  final _desCon = new TextEditingController();
  final _email2Con = new TextEditingController();
  final _contactNumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            title: Text('Account Information'),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => resSignup1()));
              },
            ),
          ),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Image'),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    decoration: textBox,
                                    height: 40,
                                    width: 300,
                                    child: TextFormField(
                                      controller: _desCon,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: 2.0, bottom: 2.0, left: 1.0),
                                        hintText: 'Restaurant Description',
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Restaurant Description is Required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    decoration: textBox,
                                    height: 40,
                                    width: 300,
                                    child: TextFormField(
                                      controller: _email2Con,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top: 2.0, bottom: 2.0, left: 1.0),
                                          hintText: 'Public Email'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Email is Reqeuired';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    decoration: textBox,
                                    height: 40,
                                    width: 300,
                                    child: TextFormField(
                                      controller: _contactNumber,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            top: 2.0, bottom: 2.0, left: 1.0),
                                        hintText: 'Contact Number',
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Contact Number is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Type of Cuisine'),
                                      CheckboxListTile(
                                        title: const Text('Filipino'),
                                        value: this.filipino,
                                        onChanged: (bool value) {
                                          setState(() {
                                            this.filipino = value;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Chinese'),
                                        value: this.chinese,
                                        onChanged: (bool value) {
                                          setState(() {
                                            this.chinese = value;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Japanese'),
                                        value: this.japanese,
                                        onChanged: (bool value) {
                                          setState(() {
                                            this.japanese = value;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Korean'),
                                        value: this.korean,
                                        onChanged: (bool value) {
                                          setState(() {
                                            this.korean = value;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: const Text('American'),
                                        value: this.american,
                                        onChanged: (bool value) {
                                          setState(() {
                                            this.american = value;
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: const Text('Others'),
                                        value: this.others,
                                        onChanged: (bool value) {
                                          setState(() {
                                            this.others = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Delivery Available?'),
                                      RadioListTile(
                                        title: const Text('Yes'),
                                        value: Delivery.Yes,
                                        groupValue: _delivery,
                                        onChanged: (Delivery value) {
                                          setState(() {
                                            _delivery = value;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('No'),
                                        value: Delivery.No,
                                        groupValue: _delivery,
                                        onChanged: (Delivery value) {
                                          setState(() {
                                            _delivery = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Open 24 Hours?'),
                                      RadioListTile(
                                        title: const Text('Yes'),
                                        value: OpenTime.Yes,
                                        groupValue: _timeAvailable,
                                        onChanged: (OpenTime value) {
                                          setState(() {
                                            _timeAvailable = value;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('No'),
                                        value: OpenTime.No,
                                        groupValue: _timeAvailable,
                                        onChanged: (OpenTime value) {
                                          setState(() {
                                            _timeAvailable = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Price Range'),
                                      RadioListTile(
                                        title: const Text('P'),
                                        value: PriceRange.P,
                                        groupValue: _price,
                                        onChanged: (PriceRange value) {
                                          setState(() {
                                            _price = value;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('PP'),
                                        value: PriceRange.PP,
                                        groupValue: _price,
                                        onChanged: (PriceRange value) {
                                          setState(() {
                                            _price = value;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('PPP'),
                                        value: PriceRange.PPP,
                                        groupValue: _price,
                                        onChanged: (PriceRange value) {
                                          setState(() {
                                            _price = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    width: 300,
                                    child: RaisedButton(
                                        child: Text('Upload Photos'),
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        onPressed: () {
                                          //upload at least 3 images if possible
                                        }),
                                  ),
                                  SizedBox(height: 50),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    width: 300,
                                    child: RaisedButton(
                                      child: Text('Next'),
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      onPressed: () {
                                        if (filipino == true) {
                                          _cuisine.add('Filipino');
                                        } else {
                                          _cuisine.add(null);
                                        }

                                        if (chinese == true) {
                                          _cuisine.add('Chinese');
                                        } else {
                                          _cuisine.add(null);
                                        }

                                        if (japanese == true) {
                                          _cuisine.add('Japanese');
                                        } else {
                                          _cuisine.add(null);
                                        }

                                        if (korean == true) {
                                          _cuisine.add('Korean');
                                        } else {
                                          _cuisine.add(null);
                                        }

                                        if (american == true) {
                                          _cuisine.add('American');
                                        } else {
                                          _cuisine.add(null);
                                        }

                                        if (others == true) {
                                          _cuisine.add('Others');
                                        } else {
                                          _cuisine.add(null);
                                        }
                                        _resName =
                                            widget.restaurantName.toString();
                                        _city = widget.city.toString();
                                        _address = widget.add.toString();
                                        _privEmail =
                                            widget.privateEmail.toString();
                                        _password = widget.pw.toString();
                                        description = _desCon.text;
                                        email2 = _email2Con.text;
                                        contactNum = _contactNumber.text;

                                        if (_cuisine[0] != null) {
                                          cuisine1 = _cuisine[0];
                                        } else {
                                          cuisine1 = null;
                                        }

                                        if (_cuisine[1] != null) {
                                          cuisine2 = _cuisine[1];
                                        } else {
                                          cuisine2 = null;
                                        }
                                        if (_cuisine[2] != null) {
                                          cuisine3 = _cuisine[2];
                                        } else {
                                          cuisine3 = null;
                                        }

                                        if (_cuisine[3] != null) {
                                          cuisine4 = _cuisine[3];
                                        } else {
                                          cuisine4 = null;
                                        }

                                        if (_cuisine[4] != null) {
                                          cuisine5 = _cuisine[4];
                                        } else {
                                          cuisine5 = null;
                                        }

                                        if (_cuisine[5] != null) {
                                          cuisine6 = _cuisine[5];
                                        } else {
                                          cuisine6 = null;
                                        }

                                        if (_delivery == Delivery.Yes) {
                                          delivery = 'Yes';
                                        } else {
                                          delivery = 'No';
                                        }

                                        if (_timeAvailable == OpenTime.Yes) {
                                          time = 'Yes';
                                        } else {
                                          time = 'No';
                                        }

                                        if (_price == PriceRange.P) {
                                          price = 'P';
                                        } else if (_price == PriceRange.PP) {
                                          price = 'PP';
                                        } else {
                                          price = 'PPP';
                                        }
                                        /*
                                        print(_resName);
                                        print(_city);
                                        print(_address);
                                        print(_privEmail);
                                        print(email2);
                                        print(_password);
                                        print(description);
                                        print(contactNum);
                                        print(cuisine1);
                                        print(cuisine2);
                                        print(cuisine3);
                                        print(cuisine4);
                                        print(cuisine5);
                                        print(cuisine6);
                                        print(delivery);
                                        print(time);
                                        print(price);
                                        */
                                        _createRestaurantPageTable();
                                        _insertAccount();
                                        _insertFeed();
                                        _insertIndivInfo();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    openScreen()));
                                      },
                                    ),
                                  ),
                                ],
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
        ));
  }

  _insertAccount() async {
    Database db = await dbHelper.createInstance().insertInfo();
    Map<String, dynamic> toMap() =>
        {"email": _privEmail, "password": _password};
    return await db.insert(dbHelper.table1, toMap());
  }

  _insertFeed() async {
    Database db = await feeddb.createInstance().insertFeed();
    Map<String, dynamic> toMap() => {
          "restaurantName": _resName,
          "priceRange": _price.toString(),
          "city": _city
        };
    return await db.insert(feeddb.table1, toMap());
  }

  _insertIndivInfo() async {
    Database db = await indivInfo
        .createInstance()
        .insertInfo(widget.restaurantName.toString());
    Map<String, dynamic> toMap() => {
          "restaurantName": _resName,
          "city": _city,
          "address": _address,
          "privateEmail": _privEmail,
          "publicEmail": email2,
          "description": description,
          "contactNum": contactNum,
          "cuisine1": cuisine1,
          "cuisine2": cuisine2,
          "cuisine3": cuisine3,
          "cuisine4": cuisine4,
          "cuisine5": cuisine5,
          "cuisine6": cuisine6,
          "delivery": delivery,
          "timeOpen": time,
          "price": price
        };
    return await db.insert(indivInfo.table, toMap());
  }

  Future<Database> _createRestaurantPageTable() async {
    String path = p.join(await getDatabasesPath(), "$_resName.db");
    return openDatabase(path, version: 1, onCreate: _restaurantPage);
  }

  void _restaurantPage(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS RestaurantInfo(restaurantName, city, address, privateEmail, publicEmail, description, contactNum, cuisine1, cuisine2, cuisine3, cuisine4, cuisine5, cuisine6, delivery, timeOpen, price)");
  }
}
