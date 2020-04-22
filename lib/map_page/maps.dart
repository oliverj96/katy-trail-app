import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:katy_trail_app/location_page/LocationPage.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../location_page/ExplorePage.dart';
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

  Map<String, Object> locationData;
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
      MaterialPageRoute(builder: (context) => new ExplorePage(locationData)),
      //MaterialPageRoute(builder: (context) => new LocationPage(dataPointsCol, bmHandler)),
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

  // Use to check if a user's current location is near a location's vicinity 
  bool isUserNearLocation = false;
  checkDistance(userCurrentLat, userCurrentLong) {

    var distance = 0.0001; 
    var latDistance = 0.0;
    var longDistance = 0.0;

    for(var location in dataPointsCol) {  // Go through all the points in the database coming in ["lat"] ["long"] 

      latDistance = (userCurrentLat - location["lat"]).abs(); 
      longDistance = (userCurrentLong - location["long"]).abs();

      // If user is close enough to a location but has not previously been close enough to that location
      if ((latDistance <= distance) && (longDistance <= distance) && !isUserNearLocation) {

        isUserNearLocation = false;
        locationData = location;
        showNotification(location); // Send the push notification 
      } 
      // If user is close enough to a location and continues to be close enough to that location
      else if ((latDistance <= distance) && (longDistance <= distance) && isUserNearLocation) {
        isUserNearLocation = true;
      } 
      
    } 
  }

  // Data variables
  final List<Map<String, Object>> dataPointsCol;
  final points;
  final BookmarkHandler bmHandler;
  _MapPageState(this.dataPointsCol, this.points, this.bmHandler);

  @override
  Widget build(BuildContext context) {
    _showLocationCard(context, Map<String, Object> locData) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return LocationCard(locData, dataPointsCol, bmHandler);
        }
      );
    }

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
              //locationData = location;
              _showLocationCard(context, location);
              print("Location: " + location["name"] + " was tapped.");
            },
          ),
        )
      );
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
