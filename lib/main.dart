import 'package:Advika/product.dart';
import 'package:flutter/material.dart';
import 'package/bottomNav.dart';
import 'package/carousel_slider.dart';

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
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.width/ (MediaQuery.of(context).size.height/1.3)),
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => new ProductPage()
                        ));
                    },
                    child: Card(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 10,),
                          Image.network("http://w-safe.ml/advika/gobhi.png",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width/2-5,
                                  height:MediaQuery.of(context).size.height/5
                          ),
                          
                          Center(
                            child: Text(
                              "Gobhi",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width/25
                              ),
                              ),
                          ),
                          Center(
                            child: Text("250g"),
                          ),
                          Center(
                            child: Text("\u20B9 30/-"),
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
                              onPressed: (){

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Image.network("http://w-safe.ml/advika/gobhi.png",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width/2-5,
                                height:MediaQuery.of(context).size.height/5
                        ),
                        
                        Center(
                          child: Text(
                            "Gobhi",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/25
                            ),
                            ),
                        ),
                        Center(
                          child: Text("250g"),
                        ),
                        Center(
                          child: Text("\u20B9 30/-"),
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
                            onPressed: (){

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                 Card(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Image.network("http://w-safe.ml/advika/gobhi.png",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width/2-5,
                                height:MediaQuery.of(context).size.height/5
                        ),
                        
                        Center(
                          child: Text(
                            "Gobhi",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/25
                            ),
                            ),
                        ),
                        Center(
                          child: Text("250g"),
                        ),
                        Center(
                          child: Text("\u20B9 30/-"),
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
                            onPressed: (){

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Image.network("http://w-safe.ml/advika/gobhi.png",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width/2-5,
                                height:MediaQuery.of(context).size.height/5
                        ),
                        
                        Center(
                          child: Text(
                            "Gobhi",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/25
                            ),
                            ),
                        ),
                        Center(
                          child: Text("250g"),
                        ),
                        Center(
                          child: Text("\u20B9 30/-"),
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
                            onPressed: (){

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Image.network("http://w-safe.ml/advika/gobhi.png",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width/2-5,
                                height:MediaQuery.of(context).size.height/5
                        ),
                        
                        Center(
                          child: Text(
                            "Gobhi",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/25
                            ),
                            ),
                        ),
                        Center(
                          child: Text("250g"),
                        ),
                        Center(
                          child: Text("\u20B9 30/-"),
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
                            onPressed: (){

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Image.network("http://w-safe.ml/advika/gobhi.png",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width/2-5,
                                height:MediaQuery.of(context).size.height/5
                        ),
                        
                        Center(
                          child: Text(
                            "Gobhi",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/25
                            ),
                            ),
                        ),
                        Center(
                          child: Text("250g"),
                        ),
                        Center(
                          child: Text("\u20B9 30/-"),
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
                            onPressed: (){

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
