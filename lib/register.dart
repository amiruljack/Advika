import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'drawer.dart';
import 'login.dart';
import 'main.dart';
import 'path.dart';
import 'searchPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  String name = '';
  String email = '';
  String number = '';
  String password = '';
  String msg = '';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xFF34a24b);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: Scaffold(
          drawer: DrawerPage(),
          appBar: AppBar(
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  icon: Icon(Icons.add_shopping_cart))
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Advika"),
              ],
            ),
          ),
          body: Form(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Image.asset(
                                  'assets/logo.png',
                                  width: 100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: nameController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  // hintText: 'EMAIL',
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  // hintText: 'EMAIL',
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD ',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              obscureText: true,
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: numberController,
                              decoration: InputDecoration(
                                  labelText: 'Contact Number ',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(height: 50.0),
                            Container(
                                height: 40.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.greenAccent,
                                  color: Colors.green,
                                  elevation: 7.0,
                                  child: FlatButton(
                                    onPressed: () {
                                      _signup();
                                      // _signup();
                                    },
                                    child: Center(
                                      child: Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(height: 20.0),
                            Container(
                              height: 40.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: Text('Go Back',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat')),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    // SizedBox(height: 15.0),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       'New to Spotify?',
                    //       style: TextStyle(
                    //         fontFamily: 'Montserrat',
                    //       ),
                    //     ),
                    //     SizedBox(width: 5.0),
                    //     InkWell(
                    //       child: Text('Register',
                    //           style: TextStyle(
                    //               color: Colors.green,
                    //               fontFamily: 'Montserrat',
                    //               fontWeight: FontWeight.bold,
                    //               decoration: TextDecoration.underline)),
                    //     )
                    //   ],
                    // )
                    SizedBox(height: 30.0),
                  ]),
            ),
          )),
    );
  }

  void _signup() async {
    if (nameController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Name");
      return null;
    }
    if (emailController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Email");
      return null;
    }
    if (passwordController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Password ");
      return null;
    }
    if (numberController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Number");
      return null;
    }

    var response = await http.post("$api/register", body: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "mobile": numberController.text,
    });
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid credential");
      return null;
    } else {
      if (datauser['flag'] == '1') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", emailController.text);
        pref.setString("number", numberController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      }
    }
  }

  // void _showDilog(String title, String text) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(title),
  //           content: Text(text),
  //           actions: <Widget>[
  //             FlatButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text("ok"))
  //           ],
  //         );
  //       });
  // }
}
