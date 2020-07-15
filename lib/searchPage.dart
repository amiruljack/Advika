import 'dart:async';
import 'dart:convert';

import 'package:Advika/cart.dart';
import 'package:Advika/drawer.dart';
import 'package:Advika/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/database_helper.dart';
import 'path.dart';
import 'allproduct_model.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textController = TextEditingController();

  var isLogin;
  int i = 0;
  @override
  void initState() {
    super.initState();
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
              TextField(
                onChanged: (value) {
                  setState(() {
                    getSearch(textController.text);
                  });
                },
                controller: textController,
                decoration: InputDecoration(
                    labelText: 'Enter Product',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                    future: getSearch(textController.text),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      int ind = 0;

                      if (snapshot.hasData) {
                        List<GetAllProduct> data = snapshot.data;
                        return CustomScrollView(
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.only(bottom: 150),
                              sliver: SliverGrid.count(
                                crossAxisSpacing: 10,
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (MediaQuery.of(context).size.width / 2) /
                                        (MediaQuery.of(context).size.height /
                                            2),
                                children: data
                                    .map(
                                      (product) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductPage(
                                                          product.productid)));
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
                                                              color:
                                                                  Colors.white,
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
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Product Is Already Added in The Cart");
                                                          } else {
                                                            Fluttertoast.showToast(
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
                                                              color:
                                                                  Colors.white,
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
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<GetAllProduct>> getSearch(String data) async {
    var response =
        await http.post("$api/getProductsBySearch", body: {'pattern': data});
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
