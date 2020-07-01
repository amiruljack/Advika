import 'dart:convert';
import 'package:Advika/login.dart';
import 'package:Advika/main.dart';
import 'package:Advika/profile.dart';
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
  var isLogin;
  bool log = false;
  // final GoogleSignIn _googleSignIn = new GoogleSignIn();
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  //_DrawerPageState(this.userid);

  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xFF34a24b);
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          Container(
            color: PrimaryColor,
            height: MediaQuery.of(context).size.height / 4,
            child: new Container(
              color: PrimaryColor,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Image.asset(
                      'assets/logo.png',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.stars),
            title: new Text("ALL PRODUCTS"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ));
            },
          ),

          new ListTile(
            leading: new Icon(Icons.category),
            title: new Text("CATEGORIES"),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => TwoWayBookPage(),));
            },
          ),
          new ListTile(
            leading: new Icon(Icons.query_builder),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
          ),
          // new Divider(),
          if (isLogin != 1)
            new ListTile(
              leading: new Icon(Icons.close),
              title: new Text("LOGIN"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            )
          else
            new ListTile(
              leading: new Icon(Icons.close),
              title: new Text("LOGOUT"),
              onTap: () {
                _logout();
              },
            ),
          //  new Divider(),
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
