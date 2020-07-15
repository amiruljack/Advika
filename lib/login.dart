import 'dart:convert';

import 'package:Advika/main.dart';
import 'package:Advika/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';
import 'drawer.dart';
import 'path.dart';
import 'searchPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final forgetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xFF34a24b);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: new Scaffold(
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
          resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40.0),
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
                Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          autocorrect: false,
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: true,
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            onTap: () {
                              _forgetPassword();
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: FlatButton(
                              onPressed: () {
                                _login();
                              },
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.white,
                            borderOnForeground: true,
                            color: Colors.blue,
                            elevation: 7.0,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'REGISTER',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0),
                        //  Container(
                        //     height: 40.0,
                        //     child: Material(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //       shadowColor: Colors.black,
                        //       borderOnForeground: true,
                        //       color: Colors.redAccent,
                        //       elevation: 7.0,
                        //       child: FlatButton(
                        //         onPressed: () {
                        //           // _signIn();
                        //         },
                        //         child: Center(
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: <Widget>[
                        //               Container(child: Image.asset('assets/google.png') , height: 25, width: 25,),
                        //           SizedBox(width: 10.0),
                        //               Text(
                        //                 'Log in with Google',
                        //                 style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.bold,
                        //                     fontFamily: 'Montserrat'),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    )),
                SizedBox(height: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Copyright \u00a9',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'www.digiblade.in',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
              ],
            ),
          )),
    );
  }

  void _login() async {
    //_askPermission();

    // var result = await Connectivity().checkConnectivity();
    // if (result == ConnectivityResult.none) {
    //   _showDilog('No Internet', "You're not connected to a network");
    //   return null;
    // }
    var response = await http.post("$api/login", body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
    // print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      Fluttertoast.showToast(msg: "register your self");
    } else {
      if (datauser['flag'] == '1') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", emailController.text);
        pref.setBool("isLogin", true);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      } else {
        Fluttertoast.showToast(msg: "register your self");
      }
    }
  }

  void _forgetPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Forget Password"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    autocorrect: true,
                    controller: forgetController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Enter Email',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    //obscureText: true,
                  ),
                  SizedBox(height: 10.0),

                  SizedBox(height: 20.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: FlatButton(
                          onPressed: () async {
                            forgetPass();
                          },
                          child: Center(
                            child: Text(
                              'Forget',
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
                    height: 35.0,
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

                  // ),
                ],
              ),
            ),
          );
        });
  }

  void forgetPass() async {
    if (forgetController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid email");
      return null;
    }

    var response = await http.post("$api/forgetPassword", body: {
      "email": forgetController.text,
    });
    var datauser = json.decode(response.body);
    print(datauser);
    if (datauser.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid credential");
      return null;
    } else {
      if (datauser['flag'] == '1') {
        Fluttertoast.showToast(
            msg:
                "Your Password is successfully updated please visit your email");
      }
    }
  }
}
