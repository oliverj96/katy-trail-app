import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './home_page/homepage.dart';
import 'package:latlong/latlong.dart';

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
    var data = loadAsset('assets/docs/path.txt');
    getPoints(data);
  }

  static List<LatLng> points = <LatLng>[];
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
    {"name": "Location 1", "description": "This is about location 1 and cheese", "long": 38.766964, "lat": -90.489257},
    {"name": "Location 2", "description": "This is about location 2", "long": 38.794659, "lat": -90.474353},
    {"name": "Location 3", "description": "This is about location 3", "long": 38.800099, "lat": -90.470506},
  ];

  Widget currentScreen = HomePage(sampleData, points);
  final PageStorageBucket bucket = PageStorageBucket();

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
    );
  }
}