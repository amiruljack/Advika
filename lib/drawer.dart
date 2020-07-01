import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'path.dart';

// import 'allcarpage.dart';
// import 'editprofil.dart';
// import 'history.dart';
// import 'main.dart';
// import 'order.dart';
// import 'path.dart';
// import 'twowaybookcar.dart';

class DrawerPage extends StatefulWidget {
  // DrawerPage({this.userid}) ;

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  //Permission permission;
  //requestPermission() async{
  // await SimplePermissions.requestPermission(Permission.Camera);
  //}

  var userid;
  var email = '';
  var number = '';
  var name = '';
  var status = '';
  bool log = false;
  final dataCtrl = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final otpController = TextEditingController();
  // final GoogleSignIn _googleSignIn = new GoogleSignIn();
  @override
  void initState() {
    super.initState();
    getData();
    checkLogin();
  }

  //_DrawerPageState(this.userid);

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          Container(
            height: 250,
            child: new DrawerHeader(
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.jpeg',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'NAME:-$name   ',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'EMAIL:-$email ',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.directions_car),
            title: new Text("ALL CARS"),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AllCarPage(),));
            },
          ),

          new ListTile(
            leading: new Icon(Icons.directions_car),
            title: new Text("BOOK CARS"),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => TwoWayBookPage(),));
            },
          ),
          new ListTile(
            leading: new Icon(Icons.history),
            title: new Text("ORDERS"),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(),));
            },
          ),
          new ListTile(
            leading: new Icon(Icons.history),
            title: new Text("HISTORY"),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(),));
            },
          ),
          new ListTile(
            leading: new Icon(Icons.mode_edit),
            title: new Text("EDIT PROFILE"),
            onTap: () {
              if (log) {
                _showDilog(
                    "Warning", "Edit Profile is Not Working with Google user");
              } else {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(),));
              }
            },
          ),
          // new Divider(),

          //  new Divider(),
          new ListTile(
            leading: new Icon(Icons.close),
            title: new Text("LOGOUT"),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  void _logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
    if (pref.getBool("name1")) {
      pref.setBool("name1", false);
      pref.setBool("log", false);
      pref.setBool("name", false);
      pref.setBool("email", false);
      // await _googleSignIn.signOut();
    }
    // Navigator.push(
    // context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("name1")) {
      setState(() {
        name = pref.getString("name");
        email = pref.getString("email");
      });
    } else {
      email = pref.getString("email");
      var response = await http.post("$api/userdata.php", body: {
        "email": email,
      });
      print(response.body);
      var dataUser = json.decode(response.body);
      if (dataUser.length == 0) {
      } else {
        if (name == '') {
          setState(() {
            name = dataUser[0]['name'];
            email = dataUser[0]['email'];
          });
        }

        //name=dataUser[0]['name'];

      }
    }
  }

  void _showDilog(String title, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ok"))
            ],
          );
        });
  }

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("name1")) {
      setState(() {
        log = true;
      });
    }
  }
}
