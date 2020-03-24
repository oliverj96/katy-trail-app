//import 'package:app/home_page/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './about_page/AboutPage.dart';
import './home_page/homepage.dart';
import './map_page/maps.dart';
import './location_page/LocationPage.dart';
import 'package:bmnav/bmnav.dart' as bmnav;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(       
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
    HomePage(), MapPage(), LocationPage(), AboutPage(), 
  ];

  Widget currentScreen = HomePage();
  final PageStorageBucket bucket = PageStorageBucket();

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}