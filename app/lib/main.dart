//import 'package:app/home_page/about.dart';
import 'package:flutter/material.dart';
import './AboutPage.dart';
import './home_page/homepage.dart';
import 'package:bmnav/bmnav.dart' as bmnav;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katy Trail App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Katy Trail App'),
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

  int currentTab = 0;

  final List<Widget> screens = [
    HomePage(), AboutPage(), AboutPage(), AboutPage(), //replace with MapPage(), ExplorePage() eventually 
  ];

  Widget currentScreen = HomePage();
  final PageStorageBucket bucket = PageStorageBucket();

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: Text(title),
        /*leading: new IconButton(
          alignment: Alignment.centerLeft,
            icon: Icon(
            Icons.keyboard_arrow_left, 
            color: Colors.white,
            ),
            onPressed: (){
              
            },
        ),*/
        /*actions: <Widget>[ 
          IconButton(
            icon: Icon(
            Icons.bookmark,
            color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new AboutPage()),
              );
            },
          ),
        ],*/
      //),
      /*
      body: Center(
        child: HomePage(),
      ),*/
      body: PageStorage(child: currentScreen, bucket: bucket),

      bottomNavigationBar: bmnav.BottomNav(
        index: currentTab,
        onTap: (i) {
          setState(() {
            currentTab = i;
            currentScreen = screens[i];
            
          });
        },
        items: [
          bmnav.BottomNavItem(Icons.home, label: 'Home'),
          bmnav.BottomNavItem(Icons.location_on, label: 'Map'),
          bmnav.BottomNavItem(Icons.explore, label: 'Explore'),
          bmnav.BottomNavItem(Icons.info, label: 'About'),
        ],
      ),

/*
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 40.0,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()), 
              );
            },
            title: new Text("Test"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.explore,
              color: Colors.grey,
              size: 40.0,
            ),
            title: new Text("Explore"),
          ),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.info,
                color: Colors.grey,
                size: 40.0,
              ),
              title: new Text("About")),
        ],
      ),*/
    );
  }
}
