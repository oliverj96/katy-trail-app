import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './home_page/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  static var sampleData = [
    {"name": "Location 1", "description": "This is about location 1", "long": 38.766964, "lat": -90.489257},
    {"name": "Location 2", "description": "This is about location 2", "long": 38.794659, "lat": -90.474353},
    {"name": "Location 3", "description": "This is about location 3", "long": 38.800099, "lat": -90.470506},
  ];

  Widget currentScreen = HomePage(sampleData);
  final PageStorageBucket bucket = PageStorageBucket();

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
    );
  }
}