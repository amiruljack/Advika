import 'package:flutter/material.dart';

import 'package/bottomNav.dart';

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
  Widget build(BuildContext context) {}
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
              SizedBox(height: 10),
              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.yellowAccent,
                  color: Colors.yellow[800],
                  elevation: 7.0,
                  child: FlatButton(
                    onPressed: () async {
                      // int i = await DatabaseHelper.instance
                      //     .deleteFromCart(product.productId);
                      // print(i);
                      // setState(() {
                      //   DatabaseHelper.instance.getProduct();
                      // });
                      check();
                    },
                    child: Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 30,
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
                                                        product.productPrice,
                                                        product.orderQty) +
                                                    "/-"),
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
                                                                  setState(() {
                                                                    //  if(i>)
                                                                    ind = 1;
                                                                    _selectQty(
                                                                        "Select Qty",
                                                                        product
                                                                            .unitName,
                                                                        product
                                                                            .minimumQty,
                                                                        product
                                                                            .productId);
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
                                                                  // _selectQty(
                                                                  //     "Select Qty",
                                                                  //     product
                                                                  //         .unitName,
                                                                  //     product
                                                                  //         .minimumQty,
                                                                  //     product
                                                                  //         .productId);
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
