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
      "name": "Test Home",
      "description": "This is my house",
      "lat": 38.679778, // 37.4219983
      "long": -90.444028 // -122.084
    },
    {
      "name": "Missouri’s First Capitol",
      "description": "Missouri's first capital building.",
      "LongDes": "The first Missouri State Capitol State Historic Site holds years of history." +
          "It was Missouri’s first capitol building between statehood in 1821 and the capitol moving to Jefferson City in 1826." +
          "The building was restored in the 1960s. It features 11 rooms to take you back in history." +
          "Tours available at the State Capitol Historic Site office next door." +
          "Here’s the site today, and before the state restored it." +
          "(Images: St. Charles County Historical Society, Missouri State Parks)",
      "lat": 38.784926,
      "long": -90.478854,
      "images": "FCapitol1.png" "FCapitol2.png"
    },
    {
      "name": "Pilot Groove",
      "description": "Small horse-powered mill settlement",
      "LongDes": "Little is known about the origin of Pilot Grove," +
          "although a small horse-powered mill settlement was created in 1820 on a tributary of the Petite Saline Creek." +
          "Half a mile northeast of Pilot Grove a Katy Railroad train carrying WWII supplies of crude oil and artillery shells" +
          "derailed and exploded, sending shrapnel a half mile down to the Pilot Grove depot",
      "lat": 38.60881,
      "long": -90.794006,
      "images": "PilotGroove1.png" "PilotGroove2.png"
    },
    {
      "name": "Augusta Cemetery",
      "description": "Monument and burial site of Daniel Boone",
      "LongDes": "Just a mile’s ride north of here is the Augusta Cemetery, created in 1859." +
          "The earliest residents of Augusta were German immigrants, attracted here by its landscape—and" +
          "the writings of Gottfried Duden, promoting it a “Rhineland.” When you arrive at the cemetery," +
          "the oldest sections are to the south (your right as you face the gate)." +
          "Notice the inscriptions in German that date to even the early twentieth century, like this one of John Fuhr.",
      "lat": 38.580103,
      "long": -90.884011,
      "images": "Augusta.png"
    },
    {
      "name": "MKT RAILROAD ",
      "description": "The Missouri Kansas & Texas Railroad",
      "LongDes":
          "The Missouri Kansas & Texas Railroad—the “Katy”—was built in 1865;" +
              "; Union Pacific acquired it in 1988. The Katy Railroad had more than" +
              "3,377 miles of track  servicing a booming coal industry." +
              "Engines like this one connected the Midwest to Texas.",
      "lat": 38.777167,
      "long": -90.482046,
      "images": "MKT.png"
    },
  ];

  Widget currentScreen = HomePage(sampleData, _bmHandler, _pushHandler);
  final PageStorageBucket bucket = PageStorageBucket();

  //@override
  Widget build(BuildContext context) {
    // Check user's current location every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      _pushHandler.getPosition();
      _pushHandler.checkDistance();
    });

    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
    );
  } //uncomment after showing push notifications example
}
