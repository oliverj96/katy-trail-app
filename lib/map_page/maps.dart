import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:katy_trail_app/location_page/LocationPage.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import './location-card.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../bookmark_page/bm_handler.dart';

class MapPage extends StatefulWidget {
  final List<Map<String, Object>> dataPointsCol;
  final points;
  final BookmarkHandler bmHandler;
  MapPage(this.dataPointsCol, this.points, this.bmHandler);

  @override
  _MapPageState createState() => _MapPageState(dataPointsCol, points, bmHandler);
}

class _MapPageState extends State<MapPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onSelectNotification: onSelectNotification
    );
  }

  Future onSelectNotification(String payload) async {
    // Use payload for selecting specific location page 
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new LocationPage(dataPointsCol, bmHandler)),
      );
  }  

  showNotification(Map<String, Object> locDetails) async {
    var android = new AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High,importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
      0, 
      locDetails['name'], 
      'Learn about this area!', 
      platform
    );
  }

  // Data variables
  final List<Map<String, Object>> dataPointsCol;
  final points;
  final BookmarkHandler bmHandler;
  _MapPageState(this.dataPointsCol, this.points, this.bmHandler);

  double latitude = 0;
  // Get a user's current latitude
  Future getLatitude(double latitude) async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = (position.latitude.toString()); 
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

  // return true or false based on if user's location intersects with specified coordinates polygon
  bool inside(point, vs) {
    // Ray-casting algorithm based on
    // http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
    var x = point[0], y = point[1];

    var inside = false;
    for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
      var xi = vs[i][0], yi = vs[i][1];
      var xj = vs[j][0], yj = vs[j][1];

      var intersect =
          ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }

    return inside;
  }

  // Get a user's current location and print longitude and latitude
  Future getCurrentLocation() async {
    // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position.latitude.toString()+ " ");
    // print(position.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    _showLocationCard(context, Map<String, Object> locData) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return LocationCard(locData, dataPointsCol, bmHandler);
          });
    }

    // Check user's current location every 10 seconds
    // TODO Compare user's current location with all Katy Trail locations
    /*Timer.periodic(Duration(seconds: 30), (timer) {
      getCurrentLocation();
    });*/

    // Build map path from file
    // TODO Fix bug: path isn't drawn until build update
    // var data = loadAsset('assets/docs/path.txt');
    // getPoints(data);

    // Use to check if a user's current location is near a location's vicinity 
    bool isUserNearLocation = false;
    
    /*// TODO Compare user's current location with all Katy Trail locations
    // Check user's current location every 3 seconds 
    Timer.periodic(Duration(seconds: 3), (timer) {

      getLatitude(latitude); 
      getLongitude(longitude);
      // TODO replace coordinates with user's current location
      // If user is inside a polygon and has not been inside polygon 
      if (!inside( [ latitude, longitude ], polygon) && !isUserNearLocation) {
        isUserNearLocation = false; 
        print("Made it to 1st if statement");
      }
      // If a user is inside a polygon and is near a location
      else if (inside([ latitude, longitude ], polygon) && !isUserNearLocation) {
        isUserNearLocation = true; 
        print("Made it to 2nd if statement");
        // TODO pass in necessary information
        showNotification(); 
      }
      // If a user is inside a polygon and is not near a location
      else if(inside([ latitude, longitude ], polygon) && isUserNearLocation) {
        print("Made it to 3rd if statement");
      } 
    });
    */

    // Dynamically add markers to List
    // TODO Once firebase is integrated, change sample data to pulled data
    var locationPlaces = List<Marker>();
    for (var location in dataPointsCol) {
      // Create marker widget for each location
      var temp = new Marker(
          width: 45.0,
          height: 45.0,
          point: new LatLng(location["long"], location["lat"]),
          builder: (context) => new Container(
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.red,
                  iconSize: 45.0,
                  onPressed: () {
                    showNotification(location);
                    // Print true or false if user is within specified coordinates square 
                    // print(inside([ 38.570249, -90.480863 ], polygon));
                    getLongitude(longitude); 
                    // Print true or false if user is within specified coordinates square
                    // print(inside([ 38.766974, -90.489245 ], polygon));
                    _showLocationCard(context, location);
                    print("Location: " + location["name"] + " was tapped.");
                  },
                ),
              ));
      // Append location to list of places
      locationPlaces.add(temp);
    }
    // Retrieve API url and token
    // TODO: Retrieve from Key files from the asset folder
    String url, token;
    url =
        'https://api.mapbox.com/styles/v1/ojohnson7cc/ck79a877u2ffj1jnn4dfgh3r9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWE0ZG5nMHIyaDNlcWh4cHd5N3I2bSJ9.L1xfay1JISdfIO1jDp8rTg';
    token =
        'sk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWp2cnNqMHUydzNlcWtxd2R4c2JncCJ9.keCK6gFmt7EO9Ug4GwC_jg';

    // Create Flutter Map Widget
    return Scaffold(
      appBar: new AppBar(
        title: Text('Map'),
      ),
      body: FlutterMap(
        options: new MapOptions(
            center: new LatLng(38.77699, -90.482418), minZoom: 10.0),
        layers: [
          new TileLayerOptions(urlTemplate: url, additionalOptions: {
            'accessToken': token,
            'id': 'mapbox.mapbox-streets-v7'
          }),
          new MarkerLayerOptions(markers: locationPlaces),
        ],
      ),
    );
  }
}
