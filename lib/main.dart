import 'dart:async';
import 'dart:convert';

import 'package:Advika/cart.dart';
import 'package:Advika/drawer.dart';
import 'package:Advika/product.dart';
import 'package:Advika/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/database_helper.dart';
import 'package/carousel_slider.dart';
import 'path.dart';
import 'allproduct_model.dart';
import 'package:http/http.dart' as http;

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
  var isLogin;
  int i = 0;
  @override
  void initState() {
    super.initState();
    fetch();
    _isLogin();
    // DatabaseHelper.instance.deleteall();
  }

  @override
  void dispose() {
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                      future: getProducts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        int ind = 0;

                        if (snapshot.hasData) {
                          List<GetAllProduct> data = snapshot.data;
                          return CustomScrollView(
                            slivers: <Widget>[
                              SliverList(
                                // Use a delegate to build items as they're scrolled on screen.
                                delegate: SliverChildBuilderDelegate(
                                  // The builder function returns a ListTile with a title that
                                  // displays the index of the current item.
                                  (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FutureBuilder(
                                          future: getBanner(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              List<GetBanner> data =
                                                  snapshot.data;
                                              return CarouselSlider(
                                                options: CarouselOptions(
                                                  viewportFraction: 1.5,
                                                  autoPlay: true,
                                                ),
                                                items: data
                                                    .map((item) => Container(
                                                          child: Center(
                                                              child: Image.network(
                                                                  "$bannerimage/" +
                                                                      item
                                                                          .image,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      3.5)),
                                                        ))
                                                    .toList(),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }),
                                    ],
                                  ),
                                  // Builds 1000 ListTiles
                                  childCount: 1,
                                ),
                              ),

                              SliverPadding(
                                padding: const EdgeInsets.only(bottom: 10),
                                sliver: SliverGrid.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  children: data
                                      .map(
                                        (product) => GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductPage(product
                                                            .productid)));
                                          },
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image.network(
                                                  "$image/${product.productimage}",
                                                  fit: BoxFit.fitWidth,
                                                  height: 120,
                                                ),
                                                Center(
                                                  child: Text(
                                                    product.productname,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    "\u20B9" +
                                                        product.productprice +
                                                        "/" +
                                                        product.unitname,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                Center(
                                                  child: ind == 0
                                                      ? RaisedButton(
                                                          color: Colors.green,
                                                          child: Text(
                                                              "Add to Cart",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                          onPressed: () async {
                                                            int i =
                                                                await DatabaseHelper
                                                                    .instance
                                                                    .addProduct({
                                                              DatabaseHelper
                                                                      .productId:
                                                                  product
                                                                      .productid,
                                                              DatabaseHelper
                                                                      .productName:
                                                                  product
                                                                      .productname,
                                                              DatabaseHelper
                                                                      .productImage:
                                                                  product
                                                                      .productimage,
                                                              DatabaseHelper
                                                                      .productPrice:
                                                                  product
                                                                      .productprice,
                                                              DatabaseHelper
                                                                      .minimumQty:
                                                                  product
                                                                      .productminimum,
                                                              DatabaseHelper
                                                                      .categoryName:
                                                                  product
                                                                      .categoryname,
                                                              DatabaseHelper
                                                                      .unitName:
                                                                  product
                                                                      .unitname,
                                                              DatabaseHelper
                                                                  .orderQty: 1,
                                                            });
                                                            if (i == 0) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Product Is Already Added in The Cart");
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Product Is Added in The Cart");
                                                            }
                                                          },
                                                        )
                                                      : RaisedButton(
                                                          color: Colors.grey,
                                                          child: Text(
                                                              "Add to Cart",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 6.0,
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 100),
                                          child: Image.network(
                                            "$bannerimage/banner.jpg",
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  // Builds 1000 ListTiles
                                  childCount: 1,
                                ),
                              ),
                              // SliverPadding(
                              //   padding: const EdgeInsets.only(bottom: 150),
                              //   sliver: Image.network(
                              //     "$bannerimage/1593766959-banner3.jpg",
                              //     fit: BoxFit.fitWidth,
                              //     height: 120,
                              //   ),
                              // ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
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
    const oneSec = const Duration(seconds: 50000);
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

  Future<List<GetBanner>> getBanner() async {
    var response = await http.post("$api/getBanner");
    var dataUser = await json.decode(utf8.decode(response.bodyBytes));

    List<GetBanner> rp = [];
    //   const oneSec = const Duration(seconds:5);
    // new Timer.periodic(oneSec, (Timer t) => setState((){

    // }));
    for (var res in dataUser) {
      GetBanner data = GetBanner(res['banner_image']);
      rp.add(data);
    }

    return rp;
  }
}
