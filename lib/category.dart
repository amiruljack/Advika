import 'dart:convert';

import 'package:Advika/category_model.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'category_product.dart';
import 'drawer.dart';
import 'fetchData.dart';
import 'path.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
        body: FutureBuilder(
            future: getCategory(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<GetCategory> data = snapshot.data;
                return ListView(
                  children: data
                      .map(
                        (product) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryProductPage(
                                        product.categoryid)));
                          },
                          child: Card(
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        child: Image.network(
                                            "$categoryimage/${product.categoryimage}",
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: Text(
                                      product.categoryname,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
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
    );
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

}

//   Container(
//   height: 100,
//   child: Card(
//     child: TextField(
//       controller: qtyCtrl,
//       decoration: InputDecoration(
//           labelText: 'Enter Qty in $unit Minimum($minimum $unit) ',
//           labelStyle: TextStyle(
//               fontFamily: 'Montserrat',
//               fontWeight: FontWeight.bold,
//               color: Colors.grey),
//           focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.green))),
//     ),
//   ),
// )
