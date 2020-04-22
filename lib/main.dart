import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import './home_page/homepage.dart';
import 'package:latlong/latlong.dart';
import './bookmark_page/bm_handler.dart';
import 'location_page/ExplorePage.dart';

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
  _MyHomePageState(){
    
    // bmHandler = BookmarkHandler('assets/docs/bookmarks.json');
    // var data = loadAsset('assets/docs/path.txt');
    // getPoints(data);
  }

  double latitude = 0;
  // Get a user's current latitude
  Future getLatitude(double latitude) async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = (position.latitude.toString()); 
    print(lat);
    this.latitude = double.parse(lat);
    return latitude; 
  }

  double longitude = 0; 
  // Get a user's current longitude
  Future getLongitude(double longitude) async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var long = (position.longitude.toString()); 
    print(long);
    this.longitude = double.parse(long);
    return longitude; 
  }

  static List<LatLng> points = <LatLng>[];
  static BookmarkHandler bmHandler = BookmarkHandler();
  // Load Asset for Future Data Parsing
  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  Future getPoints(Future<String> data) async {
    return await data.then((dataPoints) {
      var dump = dataPoints.split(' ');
      for (var i = 0; i < dump.length - 2; i += 2) {
        var newPoint =
            new LatLng(double.parse(dump[i]), double.parse(dump[i + 1]));
        points.add(newPoint);
      }
    });
  }

  static var sampleData = [
    {"name": "Missouri’s first capitol", "description": "This is about location 1 and cheese", "long": 38.780073, "lat": -90.481848},
    {"name": "Masonic Hall 1849", "description": "This is about location 2", "long": 38.780621, "lat": -90.481401},
    {"name": "Daniel Boone Burial Site", "description": "This is about location 3", "long": 38.621592, "lat": -91.034315},
    {"name": "Peers Store", "description": "This is about location 3", "long": 38.634266, "lat": -91.122865},
    {"name": "Daniel Boone Judgment Tree", "description": "This is about location 3", "long": 38.608879, "lat": -90.794029},
  ];

  Widget currentScreen = HomePage(sampleData, points, bmHandler);
  final PageStorageBucket bucket = PageStorageBucket();

  //@override
  Widget build(BuildContext context) {

  // Check user's current location every 2 seconds 
    Timer.periodic(Duration(seconds: 2), (timer) {
      getLatitude(latitude); 
      getLongitude(longitude);
      //checkDistance(latitude, longitude);
    });

    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
    );
 } //uncomment after showing push notifications example
}