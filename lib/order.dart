import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'allproduct_model.dart';
import 'cart.dart';
import 'drawer.dart';
import 'path.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var isLogin;
  int i = 0;
  @override
  void initState() {
    super.initState();
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
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: FutureBuilder(
              future: _getOrder(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ListView.builder(
                  itemCount: snapshot.hasData ? snapshot.data.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.hasData) {
                      return Card(
                        child: new Container(
                          child: new Center(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          new Text(
                                            "Order Id: ",
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          new Text(
                                            snapshot.data[index].orderid,
                                            // set some style to text
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          new Text(
                                            "Total Amount : ",
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          new Text(
                                            snapshot.data[index].orderprice,
                                            // set some style to text
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          new Text(
                                            "No. of Product: ",
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          new Text(
                                            snapshot.data[index].ordercount,
                                            // set some style to text
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      snapshot.data[index].orderstatus == "1"
                                          ? Row(
                                              children: <Widget>[
                                                new Text(
                                                  "Order Status : ",
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                new Text(
                                                  "Booked",
                                                  // set some style to text
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: <Widget>[
                                                new Text(
                                                  "Order Status : ",
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                new Text(
                                                  "Deliverd",
                                                  // set some style to text
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                      snapshot.data[index].paymenttype == "0"
                                          ? Row(
                                              children: <Widget>[
                                                new Text(
                                                  "Payment Type : ",
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                new Text(
                                                  "Cash On Delivery",
                                                  // set some style to text
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: <Widget>[
                                                new Text(
                                                  "Payment Type : ",
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                new Text(
                                                  "Online Payment",
                                                  // set some style to text
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                      snapshot.data[index].paymentstatus == "0"
                                          ? Row(
                                              children: <Widget>[
                                                new Text(
                                                  "Payment Status : ",
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                new Text(
                                                  "Unpaid",
                                                  // set some style to text
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: <Widget>[
                                                new Text(
                                                  "Payment Status : ",
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                new Text(
                                                  "Paid",
                                                  // set some style to text
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                      Row(
                                        children: <Widget>[
                                          new Text(
                                            "Order Date : ",
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                          new Text(
                                            snapshot.data[index].orderdate,
                                            // set some style to text
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20.0),
                                    ],
                                  ),
                                ),
                                // new Column(
                                //   children: <Widget>[
                                //     new IconButton(
                                //       icon: const Icon(
                                //           Icons.delete_forever,
                                //           color: const Color(0xFF167F67)),
                                //       onPressed: () {
                                //         _deleteDilog(
                                //             snapshot.data[index].id);
                                //       },
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("Dont have any member"),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<List<GetOrder>> _getOrder() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    var response = await http.post("$api/getOrder", body: {
      "email": email,
    });
    var dataUser = await json.decode(utf8.decode(response.bodyBytes));

    List<GetOrder> rp = [];
    //   const oneSec = const Duration(seconds:5);
    // new Timer.periodic(oneSec, (Timer t) => setState((){

    // }));
    for (var res in dataUser) {
      GetOrder data = GetOrder(
          res['generatedorder_id'],
          res['order_price'],
          res['order_count'],
          res['order_status'],
          res['order_date'],
          res['payment_type'],
          res['payment_status']);
      rp.add(data);
    }

    return rp;
  }
}
