import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'allproduct_model.dart';
import 'cart_model.dart';
import 'database/database_helper.dart';
import 'login.dart';
import 'main.dart';
import 'package/bottomNav.dart';
import 'path.dart';
import 'product.dart';
import 'profile.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _currentIndex = 3;
  PageController _pageController;
  var isLogin;
  int i = 0;
  @override
  void initState() {
    super.initState();

    _isLogin();
    // DatabaseHelper.instance.deleteall();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
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
          centerTitle: true,
          actions: <Widget>[
            if (isLogin != 1)
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.supervised_user_circle))
            else
              IconButton(
                  onPressed: () {
                    logout();
                  },
                  icon: Icon(Icons.power_settings_new)),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Advika"),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.yellowAccent,
                  color: Colors.yellow[800],
                  elevation: 7.0,
                  child: FlatButton(
                    onPressed: () async {
                      // int i = await DatabaseHelper.instance
                      //     .deleteFromCart(product.productId);
                      // print(i);
                      // setState(() {
                      //   DatabaseHelper.instance.getProduct();
                      // });
                      check();
                    },
                    child: Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 30,
                  child: FutureBuilder(
                      future: DatabaseHelper.instance.getProduct(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        int ind = 0;

                        if (snapshot.hasData) {
                          List<Product> data = snapshot.data;
                          return ListView(
                            children: data
                                .map(
                                  (product) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductPage(
                                                  product.productId)));
                                    },
                                    child: Card(
                                      child: Row(
                                        children: <Widget>[
                                          Image.network(
                                              "$image/${product.productImage}",
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5),
                                          Column(
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  "Product Name:" +
                                                      product.productName,
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              25),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                    "Order Qty: ${product.orderQty} ${product.unitName}"),
                                              ),
                                              Center(
                                                child: Text("\u20B9" +
                                                    product.productPrice +
                                                    "/" +
                                                    product.unitName),
                                              ),
                                              Center(
                                                child: Text("Payable:\u20B9" +
                                                    countPrice(
                                                        product.productPrice,
                                                        product.orderQty) +
                                                    "/-"),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Center(
                                                    child: ind == 0
                                                        ? Container(
                                                            height: 40.0,
                                                            child: Material(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              shadowColor: Colors
                                                                  .greenAccent,
                                                              color:
                                                                  Colors.green,
                                                              elevation: 7.0,
                                                              child: FlatButton(
                                                                onPressed:
                                                                    () async {
                                                                  setState(() {
                                                                    //  if(i>)
                                                                    ind = 1;
                                                                    _selectQty(
                                                                        "Select Qty",
                                                                        product
                                                                            .unitName,
                                                                        product
                                                                            .minimumQty,
                                                                        product
                                                                            .productId);
                                                                  });
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                    'Select Qty.',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            'Montserrat'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 40.0,
                                                            child: Material(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              shadowColor: Colors
                                                                  .greenAccent,
                                                              color:
                                                                  Colors.grey,
                                                              elevation: 7.0,
                                                              child: FlatButton(
                                                                onPressed: () {
                                                                  // _login();
                                                                  // _selectQty(
                                                                  //     "Select Qty",
                                                                  //     product
                                                                  //         .unitName,
                                                                  //     product
                                                                  //         .minimumQty,
                                                                  //     product
                                                                  //         .productId);
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                    'select Qty.',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            'Montserrat'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                  Container(
                                                    height: 40.0,
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      shadowColor:
                                                          Colors.greenAccent,
                                                      color: Colors.red,
                                                      elevation: 7.0,
                                                      child: FlatButton(
                                                        onPressed: () async {
                                                          int i = await DatabaseHelper
                                                              .instance
                                                              .deleteFromCart(
                                                                  product
                                                                      .productId);
                                                          print(i);
                                                          setState(() {
                                                            DatabaseHelper
                                                                .instance
                                                                .getProduct();
                                                          });
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Montserrat'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            if (_currentIndex == 0) {
              print("order.dart");
            }
            if (_currentIndex == 1) {
              print("search.dart");
            }
            if (_currentIndex == 2) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            }
            if (_currentIndex == 3) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            }
            if (_currentIndex == 4) {
              if (isLogin != 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }
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
              title: Text('Profile'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future _isLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool login = pref.getBool("isLogin") ?? false;

    if (login) {
      setState(() {
        isLogin = 1;
      });
    }
  }

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
    setState(() {
      isLogin = 0;
    });
  }

  void _selectQty(String title, String unit, String minimum, String productid) {
    final qtyCtrl = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Order Qty"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //  Positioned(
                  //  left:10,
                  //top:50,
                  //child: Text('data'),
                  // child:
                  TextField(
                    autocorrect: true,
                    controller: qtyCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Enter Qty in $unit Minimum($minimum $unit)',
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
                            // _editGroupMember(id);
                            int i = await DatabaseHelper.instance.updateCart({
                              DatabaseHelper.productId: productid,
                              DatabaseHelper.orderQty: qtyCtrl.text,
                            });
                            print(i);
                            _showDilog("Success", "Qty is Added succesfully");
                            // Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              'Order Qty',
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

  countPrice(String p, String u) {
    if (u != null) {
      var price = double.parse(p);
      assert(price is double);
      var qty = double.parse(u);
      assert(qty is double);
      double total = (price * qty);
      return total.toString();
    } else {
      return "0.0";
    }
  }

  check() async {
    int i = await DatabaseHelper.instance.checkProduct();
    if (i == 1) {
      _showDilog("Warning", "Please select order Qty for all products");
    } else {
      _showDilog("orderplaced", "success");
    }
  }
}

//   Container(
//   height: 100,
//   child: Card(
//     child: TextField(
//       controller: qtyCtrl,
//       decoration: InputDecoration(
//           labelText: 'Enter Qty in $unit Minimum($minimum $unit) ',
//           labelStyle: TextStyle(
//               fontFamily: 'Montserrat',
//               fontWeight: FontWeight.bold,
//               color: Colors.grey),
//           focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.green))),
//     ),
//   ),
// )
