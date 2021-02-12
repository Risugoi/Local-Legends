import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/customerListReservations.dart';
import 'package:local_legends/openScreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:local_legends/database/customerdb.dart';
import 'package:local_legends/database/feeddb.dart';
import 'package:local_legends/restaurant.dart';
import 'package:local_legends/customerProfile.dart';
import 'package:local_legends/customerSettings.dart';

class customerHome extends StatefulWidget {
  final String email;
  const customerHome({Key key, this.email}) : super(key: key);

  @override
  _customerHome createState() => _customerHome();
}

class _customerHome extends State<customerHome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  int _numRes;
  List _restaurantInfo = [];
  List _restoDetails = [];
  List _userInfo = [];
  List<String> _restaurantList = [];
  @override
  void initState() {
    super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    _numRes = _restaurantInfo.length;
    for (int i = 0; i < _numRes; i++) {
      _restaurantList.add(_restaurantInfo[i].values.elementAt(0).toString());
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  final List<String> list = _restaurantList;
                  showSearch(
                      context: context,
                      delegate: search(list, widget.email.toString()));
                })
          ],
          title: Text(
            "Restaurants",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/finalLogo.png',
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(height: 10),
                            Text('Welcome, ' + _name),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => customerProfile(
                                userInfo: _userInfo,
                                email: widget.email,
                              )));
                },
              ),
              ListTile(
                  title: Text('Reservations'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => listOfReserve(
                                  email: widget.email,
                                )));
                  }),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => customerSettings(
                                email: widget.email,
                              )));
                },
              ),
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => openScreen()));
                },
              ),
            ],
          ),
        ),
        body: new ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: _numRes,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
              leading: Image.asset('assets/images/logo.png'),
              title: Text(_restaurantInfo[index].values.elementAt(0)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_restaurantInfo[index]
                      .values
                      .elementAt(1)
                      .toString()
                      .substring(11)),
                  Text(_restaurantInfo[index].values.elementAt(2)),
                ],
              ),
              onTap: () {
                info2(_restaurantInfo[index].values.elementAt(0).toString());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => restaurantDisplay(
                            resDetails: _restoDetails,
                            name: _name,
                            email: widget.email)));
              },
            );
          },
        ),
      ),
    );
  }

  void info() async {
    try {
      String n = await _getName();
      List r = await _getResInfo();
      List u = await _getUserInfo();
      setState(() {
        _name = n;
        _userInfo = u;
        _restaurantInfo = r;
      });
    } catch (e) {
      print('error');
    }
  }

  void info2(String name) async {
    try {
      List resto = await _getRestaurantInfo(name);
      setState(() {
        _restoDetails = resto;
      });
    } catch (e) {
      print('error');
    }
  }

  _getName() async {
    String path = p.join(await getDatabasesPath(), customerdb.dbName);
    var db = await openDatabase(path);
    List<Map> name = await db.rawQuery(
        "SELECT ${customerdb.name} FROM ${customerdb.table1} WHERE ${customerdb.email} = '${widget.email}'");
    return name[0].values.toList()[0];
  }

  _getUserInfo() async {
    String path = p.join(await getDatabasesPath(), customerdb.dbName);
    var db = await openDatabase(path);
    List<Map> name = await db.rawQuery(
        "SELECT * FROM ${customerdb.table1} WHERE ${customerdb.email} = '${widget.email}'");
    return name.toList();
  }

  _getResInfo() async {
    String path = p.join(await getDatabasesPath(), feeddb.dbName);
    var db = await openDatabase(path);
    List<Map> res = await db.rawQuery("SELECT * FROM ${feeddb.table1}");
    return res.toList();
  }

  _getRestaurantInfo(String restoName) async {
    String path = p.join(await getDatabasesPath(), '$restoName.db');
    var db = await openDatabase(path);
    List<Map> info = await db.rawQuery("SELECT * FROM RestaurantInfo");
    return info.toList();
  }
}

class search extends SearchDelegate {
  String select;
  final List<String> suggest;
  final String email;
  search(this.suggest, this.email);
  List<String> recent = [];
  List _restoDetails = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    info(select.toString()).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  restaurantDisplay(resDetails: value, email: email)));
    });
    return Container(
      child: Text(select),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recent
        : suggestionList
            .addAll(suggest.where((element) => element.contains(query)));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            select = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }

  info(String name) async {
    try {
      List resto = await _getRestaurantInfo(name);
      return resto.toList();
    } catch (e) {
      print('error');
    }
  }

  _getRestaurantInfo(String restoName) async {
    String path = p.join(await getDatabasesPath(), '$restoName.db');
    var db = await openDatabase(path);
    List<Map> info = await db.rawQuery("SELECT * FROM RestaurantInfo");
    return info.toList();
  }
}
