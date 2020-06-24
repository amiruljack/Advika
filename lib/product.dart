import 'package:flutter/material.dart';

import 'package/bottomNav.dart';
import 'package/carousel_slider.dart';
class ProductPage extends StatefulWidget {
  ProductPage(this.productid, {Key key}) : super(key: key);
  final String productid;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _currentIndex = 2;
  PageController _pageController;
  final List<String> imgList = [
    'http://w-safe.ml/advika/banner1.png',
    'http://w-safe.ml/advika/banner2.jpg',
    'http://w-safe.ml/advika/banner3.png',
    'http://w-safe.ml/advika/banner4.jpg',
  ];
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
    print(widget.productid);
     const PrimaryColor = const Color(0xFF34a24b);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Advika"),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
              ),
              items: imgList
                  .map((item) => Container(
                        child: Center(
                            child: Image.network(item,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 5)),
                      ))
                  .toList(),
            ),
            
            
          ],
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
              print("profile.dart");
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
              title: Text('Settings'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}