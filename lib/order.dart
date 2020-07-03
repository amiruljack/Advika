import 'package:flutter/material.dart';
import 'cart.dart';
import 'cart_model.dart';
import 'database/database_helper.dart';
import 'path.dart';
import 'product.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _currentIndex = 3;
  PageController _pageController;
  var isLogin;
  int i = 0;
  @override
  void initState() {
    super.initState();

    // _isLogin();
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
                                                      fontFamily: 'Montserrat',
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
                                                      fontFamily: 'Montserrat',
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
                                                      fontFamily: 'Montserrat',
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
                                                      fontFamily: 'Montserrat',
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
                                            "OrderId : ",
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
                                            "Number Of products : ",
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
                                            "Payment Type : ",
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
                                            "Payment Status : ",
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
                                            snapshot.data[index].bookingstatus,
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

  _getOrder() {}
}
