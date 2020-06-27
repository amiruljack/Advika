import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'main.dart';
import 'package/bottomNav.dart';
import 'path.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4;
    PageController _pageController;
    var isLogin;
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final numberController = TextEditingController();
    final passwordController = TextEditingController();
    @override
  void initState() {
    super.initState();
    getProfile();
   _isLogin();
    _pageController = PageController();
  }
  
  @override
  Widget build(BuildContext context) {
    
    const PrimaryColor = const Color(0xFF34a24b);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Advika"),
            ],
          ),
        ),
        body: SingleChildScrollView(
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
                    padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
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
                                  borderSide: BorderSide(color: Colors.green))),
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
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'NEW PASSWORD ',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
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
                                  borderSide: BorderSide(color: Colors.green))),
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
                                  _updateprofile();
                                },
                                child: Center(
                                  child: Text(
                                    'EDIT',
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
                    )
                  ),
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
        
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            if(_currentIndex==0){
              print("order.dart");
            }
            if(_currentIndex==1){
              print("search.dart");
            }
            if(_currentIndex==2){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
            }
            if(_currentIndex==3){
              print("cart.dart");
            }
            
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.assignment),
              title: Text('Orders'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              activeColor: Colors.yellow,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(
                'Cart',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
   getProfile() async {
     SharedPreferences pref = await SharedPreferences.getInstance();
     var $email = pref.getString("email");
    var response = await http.post("$api/getProfile",body: {
      "email":$email,
    });
    var dataUser = await json.decode(utf8.decode(response.bodyBytes));
    nameController.text= dataUser[0]['customer_name'];
    emailController.text = dataUser[0]['customer_email'];
    numberController.text= dataUser[0]['customer_mobile'];
  }
  void _updateprofile() async {
    
    if (nameController.text.length == 0) {
      _showDilog('Error', "Enter valid Name");
      return null;
    }
    if (emailController.text.length == 0) {
      _showDilog('Error', "Enter valid Email");
      return null;
    }
   
    if (numberController.text.length == 0) {
      _showDilog('Error', "Enter valid Number");
      return null;
    }
   
    
      SharedPreferences pref = await SharedPreferences.getInstance();
     var $email = pref.getString("email");

    var response = await http.post("$api/updateprofile", body: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "mobile": numberController.text,
      "oldemail":$email,
     
    });
    var datauser = json.decode(response.body);
    if(datauser["flag"]=="1"){
      setState(() {
        getProfile();
        pref.setString("email",emailController.text);
      });
      _showDilog("Success", "Succeefully updated your profile");
    }
  
    
  }
  Future _isLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
  bool login = pref.getBool("isLogin")??false;
  
    if (login) {
     setState(() {
        isLogin = 1 ;
      });
    }
  }
  logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin",false);
    setState(() {
        isLogin = 0 ;
      });

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
}