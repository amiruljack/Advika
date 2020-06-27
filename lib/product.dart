import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'allproduct_model.dart';
import 'cart.dart';
import 'database/database_helper.dart';
import 'login.dart';
import 'main.dart';
import 'package/bottomNav.dart';
import 'package/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'path.dart';
import 'profile.dart';

class ProductPage extends StatefulWidget {
  ProductPage(this.productid, {Key key}) : super(key: key);
  final String productid;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int productid;
  int ind = 0;
  int _currentIndex = 2;
  PageController _pageController;
  var isLogin;
  int i = 0;
  final qtyController = TextEditingController();
  final List<String> imgList = [
    'http://w-safe.ml/advika/banner1.png',
    'http://w-safe.ml/advika/banner2.jpg',
    'http://w-safe.ml/advika/banner3.png',
    'http://w-safe.ml/advika/banner4.jpg',
  ];
  @override
  void initState() {
    super.initState();
    getProducts();
    checkProduct(int.parse(widget.productid));
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Advika"),
            ],
          ),
        ),
        body: FutureBuilder(
            future: getProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.hasData ? snapshot.data.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          Container(
                              height: 400,
                              child: Image.network(
                                  "$image/" + snapshot.data[index].productimage,
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  width: MediaQuery.of(context).size.width)),
                          SingleChildScrollView(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(32.0),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text.rich(
                                                  TextSpan(children: [
                                                    TextSpan(
                                                        text: snapshot
                                                            .data[index]
                                                            .productname)
                                                  ]),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 22.0),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                "\u20B9" +
                                                    snapshot.data[index]
                                                        .productprice +
                                                    "/" +
                                                    snapshot
                                                        .data[index].unitname,
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      TextField(
                                        controller: qtyController,
                                        decoration: InputDecoration(
                                            labelText:
                                                'Enter Qty in ${snapshot.data[index].unitname} Minimum(${snapshot.data[index].productminimum + " " + snapshot.data[index].productminimumunit}) ',
                                            labelStyle: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green))),
                                      ),
                                      const SizedBox(height: 30.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ind == 0
                                            ? RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                color: PrimaryColor,
                                                textColor: Colors.white,
                                                child: Text(
                                                  "Order Now",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 16.0,
                                                  horizontal: 32.0,
                                                ),
                                                onPressed: () async {
                                                  int i = await DatabaseHelper
                                                      .instance
                                                      .insert({
                                                    DatabaseHelper.productId:
                                                        snapshot.data[index]
                                                            .productid,
                                                    DatabaseHelper.productName:
                                                        snapshot.data[index]
                                                            .productname,
                                                    DatabaseHelper.productImage:
                                                        snapshot.data[index]
                                                            .productimage,
                                                    DatabaseHelper.productPrice:
                                                        snapshot.data[index]
                                                            .productprice,
                                                    DatabaseHelper.minimumQty:
                                                        snapshot.data[index]
                                                            .productminimum,
                                                    DatabaseHelper.minimumUnit:
                                                        snapshot.data[index]
                                                            .productminimumunit,
                                                    DatabaseHelper.categoryName:
                                                        snapshot.data[index]
                                                            .categoryname,
                                                    DatabaseHelper.unitName:
                                                        snapshot.data[index]
                                                            .unitname,
                                                  });
                                                  setState(() {
                                                    ind = 1;
                                                  });
                                                  _showDilog("Success",
                                                      "product Successfully Added to your Cart");
                                                },
                                              )
                                            : RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                color: Colors.grey,
                                                textColor: Colors.white,
                                                child: Text(
                                                  "Order Now",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 16.0,
                                                  horizontal: 32.0,
                                                ),
                                                onPressed: null),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
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
              title: Text('Settings'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<List<GetAllProduct>> getProducts() async {
    var response = await http.post("$api/get_products", body: {
      "productid": widget.productid,
    });
    var dataUser = await json.decode(utf8.decode(response.bodyBytes));
    List<GetAllProduct> rp = [];
    //   const oneSec = const Duration(seconds:5);
    // new Timer.periodic(oneSec, (Timer t) => setState((){

    // }));
    for (var res in dataUser) {
      GetAllProduct data = GetAllProduct(
          res['product_id'],
          res['product_name'],
          res['product_price'],
          res['product_minimum'],
          res['minimum_name'],
          res['product_image'],
          res['category_name'],
          res['unit_name']);
      rp.add(data);
    }

    return rp;
  }

  checkProduct(int id) async {
    print(id);
    int check = await DatabaseHelper.instance.getProductById(id);
    if (check > 0) {
      setState(() {
        ind = 1;
      });
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
}
