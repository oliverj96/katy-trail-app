import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './home_page/homepage.dart';
import './bookmark_page/bm_handler.dart';
import 'location_page/ExplorePage.dart';
import './push_handler.dart';

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
  static BookmarkHandler _bmHandler = BookmarkHandler();
  static PushHandler _pushHandler = PushHandler(sampleData);

  @override
  void initState() {
    super.initState();
    _pushHandler.flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    _pushHandler.flutterLocalNotificationsPlugin
        .initialize(initSetttings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    // Use payload for selecting specific location page
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new ExplorePage(_pushHandler.locationData)));
  }

  static var sampleData = [
    {
      "name": "Missouri’s first capitol",
      "description": "This is about location 1 and cheese",
      "long": 38.780073,
      "lat": -90.481848
    },
    {
      "name": "Masonic Hall 1849",
      "description": "This is about location 2",
      "long": 38.780621,
      "lat": -90.481401
    },
    {
      "name": "Daniel Boone Burial Site",
      "description": "This is about location 3",
      "long": 38.621592,
      "lat": -91.034315
    },
    {
      "name": "Peers Store",
      "description": "This is about location 3",
      "long": 38.634266,
      "lat": -91.122865
    },
    {
      "name": "Daniel Boone Judgment Tree",
      "description": "This is about location 3",
      "long": 38.608879,
      "lat": -90.794029
    },
  ];

  Widget currentScreen = HomePage(sampleData, _bmHandler, _pushHandler);
  final PageStorageBucket bucket = PageStorageBucket();

  //@override
  Widget build(BuildContext context) {
    // Check user's current location every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      _pushHandler.getPosition();
      //_pushHandler.checkDistance();
    });

    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
    );
  } //uncomment after showing push notifications example
}
