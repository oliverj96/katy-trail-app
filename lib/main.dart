import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './home_page/home_page.dart';
import './bookmark_page/bm_handler.dart';
import 'location_page/explore_page.dart';
import './push_handler.dart';
import './location.dart';

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
  static var locationData = Locations().data;
  static BookmarkHandler _bmHandler = BookmarkHandler();
  static PushHandler _pushHandler = PushHandler(locationData);

  @override
  void initState() {
    super.initState();
    _pushHandler.flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
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

  Widget currentScreen = HomePage(locationData, _bmHandler, _pushHandler);
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
