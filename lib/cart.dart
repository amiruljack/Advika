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
              RaisedButton(
                onPressed: null,
                child: Text("Proceed to check out"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
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
                                                    "Order Qty: ${product.orderQty}"),
                                              ),
                                              Center(
                                                child: Text("\u20B9" +
                                                    product.productPrice +
                                                    "/" +
                                                    product.unitName),
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
                                                                  int i = await DatabaseHelper
                                                                      .instance
                                                                      .addProduct({
                                                                    DatabaseHelper
                                                                            .productId:
                                                                        product
                                                                            .productId,
                                                                    DatabaseHelper
                                                                            .productName:
                                                                        product
                                                                            .productName,
                                                                    DatabaseHelper
                                                                            .productImage:
                                                                        product
                                                                            .productImage,
                                                                    DatabaseHelper
                                                                            .productPrice:
                                                                        product
                                                                            .productPrice,
                                                                    DatabaseHelper
                                                                            .minimumQty:
                                                                        product
                                                                            .minimumQty,
                                                                    DatabaseHelper
                                                                            .minimumUnit:
                                                                        product
                                                                            .minimumUnit,
                                                                    DatabaseHelper
                                                                            .categoryName:
                                                                        product
                                                                            .categoryName,
                                                                    DatabaseHelper
                                                                            .unitName:
                                                                        product
                                                                            .unitName,
                                                                  });
                                                                  setState(() {
                                                                    //  if(i>)
                                                                    ind = 1;
                                                                    print(ind);
                                                                    _selectQty(
                                                                        "Select Qty",
                                                                        product
                                                                            .unitName,
                                                                        product
                                                                            .minimumQty);
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
                                                                  _selectQty(
                                                                      "Select Qty",
                                                                      product
                                                                          .unitName,
                                                                      product
                                                                          .minimumQty);
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

  void _selectQty(String title, String unit, String minimum) {
    final qtyCtrl = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Card(
              child: TextField(
                controller: qtyCtrl,
                decoration: InputDecoration(
                    labelText: 'Enter Qty in $unit Minimum($minimum $unit) ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
          );
        });
  }
}
