import 'dart:convert';

import 'package:Advika/drawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'allproduct_model.dart';
import 'cart.dart';
import 'database/database_helper.dart';
import 'package:http/http.dart' as http;
import 'path.dart';
import 'searchPage.dart';

class ProductPage extends StatefulWidget {
  ProductPage(this.productid, {Key key}) : super(key: key);
  final String productid;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int productid;
  int ind = 0;
  PageController _pageController;
  var isLogin;
  int i = 0;
  final qtyController = TextEditingController();

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
                                                'Enter Qty in ${snapshot.data[index].unitname} Minimum(${snapshot.data[index].productminimum + " " + snapshot.data[index].unitname}) ',
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
                                                  if (qtyController
                                                          .text.length ==
                                                      0) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please Enter Product Qty");
                                                  } else if (num.parse(
                                                          qtyController.text) <
                                                      num.parse(snapshot
                                                          .data[index]
                                                          .productminimum)) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please Enter Qty Greater then minimum qty.");
                                                  } else {
                                                    await DatabaseHelper
                                                        .instance
                                                        .insert({
                                                      DatabaseHelper.productId:
                                                          snapshot.data[index]
                                                              .productid,
                                                      DatabaseHelper
                                                              .productName:
                                                          snapshot.data[index]
                                                              .productname,
                                                      DatabaseHelper
                                                              .productImage:
                                                          snapshot.data[index]
                                                              .productimage,
                                                      DatabaseHelper
                                                              .productPrice:
                                                          snapshot.data[index]
                                                              .productprice,
                                                      DatabaseHelper.minimumQty:
                                                          snapshot.data[index]
                                                              .productminimum,
                                                      DatabaseHelper
                                                              .categoryName:
                                                          snapshot.data[index]
                                                              .categoryname,
                                                      DatabaseHelper.unitName:
                                                          snapshot.data[index]
                                                              .unitname,
                                                      DatabaseHelper.orderQty:
                                                          qtyController.text,
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "product Successfully Added to your Cart");
                                                    setState(() {
                                                      ind = 1;
                                                    });
                                                  }
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

  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
    setState(() {
      isLogin = 0;
    });
  }
}
