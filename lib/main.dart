import 'dart:async';
import 'dart:convert';

import 'package:Advika/cart.dart';
import 'package:Advika/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/database_helper.dart';
import 'login.dart';
import 'package/bottomNav.dart';
import 'package/carousel_slider.dart';
import 'path.dart';
import 'allproduct_model.dart';
import 'package:http/http.dart' as http;

import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Advika'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imgList = [
    'http://w-safe.ml/advika/banner1.png',
    'http://w-safe.ml/advika/banner2.jpg',
    'http://w-safe.ml/advika/banner3.png',
    'http://w-safe.ml/advika/banner4.jpg',
  ];
  int _currentIndex = 2;
  PageController _pageController;
  var isLogin;
  int i = 0;
  @override
  void initState() {
    super.initState();
    fetch();
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
        drawer: Drawer(),
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
        body: Stack(
          children: <Widget>[
            // CarouselSlider(
            //   options: CarouselOptions(
            //     autoPlay: true,
            //   ),
            //   items: imgList
            //       .map((item) => Container(
            //             child: Center(
            //                 child: Image.network(item,
            //                     fit: BoxFit.cover,
            //                     width: MediaQuery.of(context).size.width,
            //                     height:
            //                         MediaQuery.of(context).size.height / 5)),
            //           ))
            //       .toList(),
            // ),
            FutureBuilder(
                future: getProducts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  int ind = 0;

                  if (snapshot.hasData) {
                    List<GetAllProduct> data = snapshot.data;
                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.3)),
                      children: data
                          .map(
                            (product) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductPage(product.productid)));
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.network(
                                        "$image/${product.productimage}",
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5),
                                    Center(
                                      child: Text(
                                        product.productname,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25),
                                      ),
                                    ),
                                    Center(
                                      child: Text("1" + product.unitname),
                                    ),
                                    Center(
                                      child: Text("\u20B9" +
                                          product.productprice +
                                          "/-"),
                                    ),
                                    Center(
                                      child: ind == 0
                                          ? RaisedButton(
                                              color: Colors.green,
                                              child: Text("Add to Cart",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                              onPressed: () async {
                                                int i = await DatabaseHelper
                                                    .instance
                                                    .addProduct({
                                                  DatabaseHelper.productId:
                                                      product.productid,
                                                  DatabaseHelper.productName:
                                                      product.productname,
                                                  DatabaseHelper.productImage:
                                                      product.productimage,
                                                  DatabaseHelper.productPrice:
                                                      product.productprice,
                                                  DatabaseHelper.minimumQty:
                                                      product.productminimum,
                                                  DatabaseHelper.categoryName:
                                                      product.categoryname,
                                                  DatabaseHelper.unitName:
                                                      product.unitname,
                                                });
                                                if (i == 0) {
                                                  _showDilog("Thankyou",
                                                      "Product Is Already Added in The Cart");
                                                } else {
                                                  _showDilog("Thankyou",
                                                      "Product Is Added in The Cart");
                                                }
                                              },
                                            )
                                          : RaisedButton(
                                              color: Colors.grey,
                                              child: Text("Add to Cart",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                              onPressed: null,
                                            ),
                                    ),
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
          ],
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
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => MyApp()),
                  ModalRoute.withName('/'));
            }
            if (_currentIndex == 3) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CartPage()),
                  ModalRoute.withName('/'));
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

  Future<List<GetAllProduct>> getProducts() async {
    var response = await http.post("$api/allproduct");
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
          res['product_image'],
          res['category_name'],
          res['unit_name']);
      rp.add(data);
    }

    return rp;
  }

  checkProduct(String id) async {
    int check = await DatabaseHelper.instance.getProductByIdInMain(id);
    if (check > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  fetch() async {
    const oneSec = const Duration(seconds: 5);
    new Timer.periodic(
        oneSec,
        (Timer t) => setState(() {
              getProducts();
            }));
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

  setBottom() {
    setState(() {
      _currentIndex = 2;
    });
  }
}
