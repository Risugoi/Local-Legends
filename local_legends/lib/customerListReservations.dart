import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_legends/styles/styles.dart';
import 'package:local_legends/customerHome.dart';

class listOfReserve extends StatefulWidget {
  final String email;
  const listOfReserve({Key key, this.email}) : super(key: key);

  @override
  _listOfReserve createState() => _listOfReserve();
}

class _listOfReserve extends State<listOfReserve> {
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
                  }),
              title: Text('List of Reservations'),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
                  leading: Image.asset('assets/images/logo.png'),
                  title: Text('Resto Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('City'),
                      Text('Date'),
                      Text('Time'),
                    ],
                  ),
                );
              },
            )));
  }
}
