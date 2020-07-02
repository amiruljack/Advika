import 'dart:convert';
import 'package:Advika/database/database_helper.dart';

import 'cart.dart';
import 'cart_model.dart';
import 'drawer.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'allproduct_model.dart';
import 'path.dart';
import 'product.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  var flag = 0;
  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xFF34a24b);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: <Widget>[
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
          drawer: DrawerPage(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Container(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: FutureBuilder(
                          future: DatabaseHelper.instance.getProduct(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
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
                                                  builder: (context) =>
                                                      ProductPage(
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
                                                          fontSize: MediaQuery.of(
                                                                      context)
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
                                                            product
                                                                .productPrice,
                                                            product.orderQty) +
                                                        "/-"),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        height: 40.0,
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          shadowColor: Colors
                                                              .greenAccent,
                                                          color: Colors.red,
                                                          elevation: 7.0,
                                                          child: FlatButton(
                                                            onPressed:
                                                                () async {
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
                ),
                Container(
                  child: FutureBuilder(
                      future: getTotal(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<GetTotal> data = snapshot.data;
                          return Row(
                            children: data
                                .map(
                                  (product) => Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      color: PrimaryColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            "No. of Products:" +
                                                product.count.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Total: \u20B9 " +
                                                product.total.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
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
                          return CircularProgressIndicator();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  refresh() async {
    setState(() {
      // _getOrder();
    });
  }

  //get all data
  // Future<List<Checkout>> _getOrder() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var response = await http.post("$api/order.php", body: {
  //     "email": pref.getString("email"),
  //   });
  //   // print(response.body);
  //   var dataUser = await json.decode(response.body);
  //   List<Checkout> orders = [];

  //   for (var row in dataUser) {
  //     Checkout ord = Checkout(
  //       row['id'],
  //       row['useremail'],
  //       row['bookingemail'],
  //       row['pickupdate'],
  //       row['pickuptime'],
  //       row['returndate'],
  //       row['returntime'],
  //       row['city'],
  //       row['dropCity'],
  //       row['cartype'],
  //       row['way'],
  //       row['payable'],
  //       row['bookingstatus'],
  //     );
  //     orders.add(ord);
  //   }
  //   return orders;
  // }

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

  Future<List<GetTotal>> getTotal() async {
    List<GetTotal> total = [];
    num totalamount = 0.0;
    int count = 0;
    var j = await DatabaseHelper.instance.getProductTotal();
    count = j.length;
    for (int k = 0; k < j.length; k++) {
      totalamount = totalamount +
          (num.parse(j[k]['productprice']) * num.parse(j[k]['orderqty']));
    }
    GetTotal get = GetTotal(
      count,
      totalamount,
    );
    total.add(get);
    return total;
  }

  _confirmYourCar(String id) async {
    var response = await http.post("$api/confirmorder.php", body: {
      "id": id,
    });

    var dataUser = await json.decode(response.body);
    if (dataUser.length == 0) {
    } else {
//
      setState(() {
        // _getOrder();
      });
    }
  }

  _cancelYourCar(String id) async {
    var response = await http.post("$api/cancelorder.php", body: {
      "id": id,
    });

    var dataUser = await json.decode(response.body);
    if (dataUser.length == 0) {
    } else {
//
      setState(() {
        // _getOrder();
      });
    }
  }

  _deleteDilog(String id) async {
    var response = await http.post("$api/deleteorderhistory.php", body: {
      "id": id,
    });

    var dataUser = await json.decode(response.body);
    if (dataUser.length == 0) {
    } else {
//
      setState(() {
        // _getOrder();
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
}

class Checkout {
  final String id;
  final String useremail;
  final String bookingemail;
  final String pickupdate;
  final String pickuptime;
  final String returndate;
  final String returntime;
  final String city;
  final String dropCity;
  final String cartype;
  final String way;
  final String payable;
  final String bookingstatus;
  Checkout(
    this.id,
    this.useremail,
    this.bookingemail,
    this.pickupdate,
    this.pickuptime,
    this.returndate,
    this.returntime,
    this.city,
    this.dropCity,
    this.cartype,
    this.way,
    this.payable,
    this.bookingstatus,
  );
}
