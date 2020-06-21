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
  'banner1.png',
  'banner2.jpg',
  'banner3.png'

  ];
  @override
  void initState() {
    
    super.initState();
    _pageController = PageController();
  }
  @override 
  void dispose(){
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
        body: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             CarouselSlider(
                options: CarouselOptions(),
                items: imgList.map((item) => Container(
                  child: Center(
                    child: Image.network(item, fit: BoxFit.cover, width: 1000)
                  ),
                )).toList(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PrimaryColor,
          onPressed: (){},
          tooltip: 'Increment',
          child: Icon(Icons.refresh),
        ), 
        bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        print(_currentIndex);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.assignment
            ),
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
