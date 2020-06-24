import 'dart:convert';

import 'package:Advika/product.dart';
import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'login.dart';
import 'package/bottomNav.dart';
import 'path.dart';
import 'allproduct_model.dart';
import 'package:http/http.dart'as http;

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
  int _currentIndex = 2;
  PageController _pageController;
 
  @override
  void initState() {
    super.initState();
   
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
            IconButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
            },
            icon:Icon(Icons.supervised_user_circle)
            )
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
                   List<GetAllProduct> data = snapshot.data;
                   return GridView.count(
                   crossAxisCount: 2,
                   childAspectRatio: (MediaQuery.of(context).size.width/ (MediaQuery.of(context).size.height/1.3)),
                   children: data.map(
                     (product) => GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductPage(product.productid)));
                        },
                          child: Card(
                         
                         child:Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             SizedBox(height: 10,),
                             Image.network("$image/${product.productimage}",
                                     fit: BoxFit.cover,
                                     width: MediaQuery.of(context).size.width/2-5,
                                     height:MediaQuery.of(context).size.height/5
                             ),
                             
                             Center(
                               child: Text(
                                 product.productname,
                                 style: TextStyle(
                                   fontSize: MediaQuery.of(context).size.width/25
                                 ),
                                 ),
                             ),
                             Center(
                               child: Text("1"+product.unitname),
                             ),
                             Center(
                               child: Text("\u20B9"+product.productprice+"/-"),
                             ),
                             Center(
                               child: RaisedButton(
                                 color: Colors.green,
                                 child: Text(
                                   "Add to Cart",
                                   style:TextStyle(
                                     color: Colors.white,
                                   )
                                 ),
                                 onPressed: ()async{
                                   int i = await DatabaseHelper.instance.insert({
                                    DatabaseHelper.productId:product.productid,
                                    DatabaseHelper.productName:product.productname,
                                    DatabaseHelper.productImage:product.productimage,
                                    DatabaseHelper.productPrice:product.productprice,
                                    DatabaseHelper.minimumQty:product.productminimum,
                                    DatabaseHelper.minimumUnit:product.productminimumunit,
                                    DatabaseHelper.categoryName:product.categoryname,
                                    DatabaseHelper.unitName:product.unitname,
                                   });
                                   print(i);
                                   setState(() {
                                     var plug = false;
                                   });

                                 },
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ).toList(),
                     
                     );
                 }
                 else{
                   return Center(
                     child: CircularProgressIndicator(),
                     );
                 }
               }
        ),
         
          
        
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            if(_currentIndex==0){
              print("order.dart");
            }
            if(_currentIndex==1){
              print("search.dart");
            }
            if(_currentIndex==2){
              print("home.dart");
            }
            if(_currentIndex==3){
              print("cart.dart");
            }
            if(_currentIndex==4){
              Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
  Future<List<GetAllProduct>> getProducts() async {
    var response = await http.post("$api/allproduct");
    var dataUser = await json.decode(utf8.decode(response.bodyBytes));
    List<GetAllProduct> rp = [];

    for (var res in dataUser) {
        GetAllProduct data = GetAllProduct(
            res['product_id'],
            res['product_name'],
            res['product_price'],
            res['product_minimum'],
            res['product_minimumunit'],
            res['product_image'],
            res['category_name'],
            res['unit_name']
        );
        rp.add(data);
      }


    return rp;
  }
  
}
  