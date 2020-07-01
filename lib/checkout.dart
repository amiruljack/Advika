import 'dart:convert';
import 'cart.dart';
import 'drawer.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'path.dart';

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
          body: Container(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              "Booking Email : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].bookingemail,
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
                                              "User Email : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].useremail,
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
                                              "Pickup Date : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].pickupdate,
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
                                              "Pickup Time : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].pickuptime,
                                              // set some style to text
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        snapshot.data[index].returndate != "0"
                                            ? Row(
                                                children: <Widget>[
                                                  new Text(
                                                    "Return Date : ",
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                  new Text(
                                                    snapshot
                                                        .data[index].returndate,
                                                    // set some style to text
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: <Widget>[],
                                              ),
                                        snapshot.data[index].returndate != "0"
                                            ? Row(
                                                children: <Widget>[
                                                  new Text(
                                                    "Return Time : ",
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                  new Text(
                                                    snapshot
                                                        .data[index].returntime,
                                                    // set some style to text
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: <Widget>[],
                                              ),
                                        Row(
                                          children: <Widget>[
                                            new Text(
                                              "Pick up City : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].city,
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
                                              "Drop City : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].dropCity,
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
                                              "Car Type : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].cartype,
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
                                              "Travel : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].way,
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
                                              "Payable Amount : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              snapshot.data[index].payable,
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
                                              "Status : ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            new Text(
                                              // snapshot.data[index].payable,
                                              snapshot
                                                  .data[index].bookingstatus,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            if (snapshot.data[index]
                                                    .bookingstatus ==
                                                "Pending")
                                              Container(
                                                  height: 40.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    shadowColor:
                                                        Colors.greenAccent,
                                                    color: Colors.green,
                                                    elevation: 7.0,
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        _confirmYourCar(snapshot
                                                            .data[index].id);
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Book Your Car',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  40,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Montserrat'),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            if (snapshot.data[index]
                                                    .bookingstatus ==
                                                "Cancel by Driver")
                                              Container(
                                                  height: 40.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    shadowColor:
                                                        Colors.greenAccent,
                                                    color: Colors.green,
                                                    elevation: 7.0,
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        // _confirmYourCar();
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Cancel By Driver',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  40,
                                                              fontFamily:
                                                                  'Montserrat'),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            SizedBox(width: 5),
                                            if (snapshot.data[index]
                                                    .bookingstatus !=
                                                "Cancel by user")
                                              Container(
                                                  height: 40.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    shadowColor:
                                                        Colors.redAccent,
                                                    color: Colors.red,
                                                    elevation: 7.0,
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        _cancelYourCar(snapshot
                                                            .data[index].id);
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Cancel Your Car',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  40),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                            else
                                              Container(
                                                  height: 40.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    shadowColor:
                                                        Colors.redAccent,
                                                    color: Colors.red,
                                                    elevation: 7.0,
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        _deleteDilog(snapshot
                                                            .data[index].id);
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Delete Booking',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  40),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
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
      ),
    );
  }

  refresh() async {
    setState(() {
      _getOrder();
    });
  }

  //get all data
  Future<List<Checkout>> _getOrder() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var response = await http.post("$api/order.php", body: {
      "email": pref.getString("email"),
    });
    // print(response.body);
    var dataUser = await json.decode(response.body);
    List<Checkout> orders = [];

    for (var row in dataUser) {
      Checkout ord = Checkout(
        row['id'],
        row['useremail'],
        row['bookingemail'],
        row['pickupdate'],
        row['pickuptime'],
        row['returndate'],
        row['returntime'],
        row['city'],
        row['dropCity'],
        row['cartype'],
        row['way'],
        row['payable'],
        row['bookingstatus'],
      );
      orders.add(ord);
    }
    return orders;
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
        _getOrder();
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
        _getOrder();
      });
    }
  }

  _deleteDilog(String id) async {
    // var result = await Connectivity().checkConnectivity();
    // if (result == ConnectivityResult.none) {
    //   _showDilog('No Internet', "You're not connected to a network");
    //   return null;
    // }

    var response = await http.post("$api/deleteorderhistory.php", body: {
      "id": id,
    });

    var dataUser = await json.decode(response.body);
    if (dataUser.length == 0) {
    } else {
//
      setState(() {
        _getOrder();
      });
    }
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
