import 'dart:convert';
import 'searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'database/database_helper.dart';
import 'drawer.dart';
import 'path.dart';
import 'success.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  int tag = 0;
  var orderID;
  int group = 0;
  String name = '';
  String email = '';
  String number = '';
  String password = '';
  String msg = '';
  String status = '';
  Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
          //resizeToAvoidBottomPadding: false,
          body: Form(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: Image.asset(
                                  'assets/logo.png',
                                  width: 100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        padding:
                            EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: nameController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  // hintText: 'EMAIL',
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  // hintText: 'EMAIL',
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: numberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Contact Number ',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              controller: addressController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  labelText: 'Address',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  // hintText: 'EMAIL',
                                  // hintStyle: ,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 10.0),
                            Wrap(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Text("Cash On Delivery"),
                                      Radio(
                                        value: 0,
                                        groupValue: group,
                                        onChanged: (T) {
                                          setState(() {
                                            group = T;
                                          });
                                        },
                                      ),
                                      // Text("Online Payment"),
                                      // Radio(
                                      //   value: 1,
                                      //   groupValue: group,
                                      //   onChanged: (T) {
                                      //     setState(() {
                                      //       group = T;
                                      //     });
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50.0),
                            if (tag == 0)
                              Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    shadowColor: Colors.greenAccent,
                                    color: Colors.green,
                                    elevation: 7.0,
                                    child: FlatButton(
                                      onPressed: () async {
                                        _uploadAddress();
                                        // _signup();
                                      },
                                      child: Center(
                                        child: Text(
                                          'PROCEED',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                    ),
                                  ))
                            else
                              Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    shadowColor: Colors.grey,
                                    color: Colors.grey,
                                    elevation: 7.0,
                                    child: FlatButton(
                                      onPressed: () async {
                                        // _signup();
                                      },
                                      child: Center(
                                        child: Text(
                                          'PROCEED',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                    ),
                                  )),
                            SizedBox(height: 20.0),
                            Container(
                              height: 40.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: Text('Go Back',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat')),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 30.0),
                  ]),
            ),
          )),
    );
  }

  void _uploadAddress() async {
    if (nameController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Name");
      setState(() {
        tag = 0;
      });
      return null;
    }
    if (emailController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Email");
      setState(() {
        tag = 0;
      });
      return null;
    }

    if (numberController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Number");
      setState(() {
        tag = 0;
      });
      return null;
    }
    if (addressController.text.length == 0) {
      Fluttertoast.showToast(msg: "Enter valid Address");
      setState(() {
        tag = 0;
      });
      return null;
    }
    setState(() {
      tag = 1;
    });
    var response = await http.post("$api/addAddress", body: {
      "name": nameController.text,
      "email": emailController.text,
      "mobile": numberController.text,
      "address": addressController.text,
    });
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        tag = 0;
      });
      Fluttertoast.showToast(
          msg: 'unautorized access:' + "Enter valid credential");

      return null;
    } else {
      if (datauser['flag'] == '1') {
        uploadProduct(datauser['order_id']);
        if (group == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SuccessPage()));
        } else {
          try {
            openCheckout();
          } catch (e) {
            print(e);
          }
        }
      }
    }
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

  uploadProduct(var orderid) async {
    setState(() {
      orderID = orderid;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    num totalamount = 0.0;
    int count = 0;
    var j = await DatabaseHelper.instance.getProductTotal();
    count = j.length;
    for (int k = 0; k < j.length; k++) {
      if (j[k]['orderqty'] == null) {
      } else {
        totalamount = totalamount +
            (num.parse(j[k]['productprice']) * num.parse(j[k]['orderqty']));
      }
    }

    await http.post("$api/updateOrderDetails", body: {
      "order_price": totalamount.toString(),
      "order_count": count.toString(),
      "order_id": orderid.toString(),
      "payment_type": group.toString(),
      "email": email,
    });
    var prod = await DatabaseHelper.instance.getProduct();

    for (int k = 0; k < prod.length; k++) {
      var t = num.parse(j[k]['productprice']) * num.parse(j[k]['orderqty']);
      // prod[k]['orderqty'print();
      print(prod[k].productId);
      print(prod[k].orderQty);
      print(t.toString());
      print(orderid.toString());
      await http.post("$api/updateProductDetails", body: {
        "product_id": prod[k].productId,
        "product_qty": prod[k].orderQty,
        "product_total": t.toString(),
        "order_id": orderid.toString()
      });
      if (k == (prod.length - 1)) {
        await DatabaseHelper.instance.deleteAll();
        print('exit');
      }
    }
  }

  Future<num> totalCount() async {
    num totalamount = 0.0;
    var j = await DatabaseHelper.instance.getProductTotal();
    for (int k = 0; k < j.length; k++) {
      if (j[k]['orderqty'] == null) {
      } else {
        totalamount = totalamount +
            (num.parse(j[k]['productprice']) * num.parse(j[k]['orderqty']));
      }
    }
    return totalamount;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    num totalamount = 0.0;
    var j = await DatabaseHelper.instance.getProductTotal();
    for (int k = 0; k < j.length; k++) {
      if (j[k]['orderqty'] == null) {
      } else {
        totalamount = totalamount +
            (num.parse(j[k]['productprice']) * num.parse(j[k]['orderqty']));
      }
    }
    var options = {
      'key': 'rzp_test_Wh0VxDyTQdsVcv',
      'amount': totalamount * 100,
      'name': 'Digiblade',
      'external': {
        'wallets': ['paytm'],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(orderID);
    await http.post("$api/paymentSuccess", body: {
      "orderid": orderID.toString(),
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SuccessPage()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "error:" + response.code.toString() + "." + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "external wallet:" + response.walletName);
  }
  // Fluttertoast.showToast(msg: "success:" + response.paymentId);
}
