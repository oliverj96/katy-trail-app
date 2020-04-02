import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import './location-card.dart';

class MapPage extends StatefulWidget {
  final List<Map<String, Object>> dataPointsCol;
  MapPage(this.dataPointsCol);

  @override
  _MapPageState createState() => _MapPageState(dataPointsCol);
}

class _MapPageState extends State<MapPage> {
  final List<Map<String, Object>> dataPointsCol;
  _MapPageState(this.dataPointsCol);
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

  // return true or false based on if user's location intersects with specified coordinates polygon
  bool inside(point, vs) {
    // Ray-casting algorithm based on
    // http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
    var x = point[0], y = point[1];

    var inside = false;
    for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
        var xi = vs[i][0], yi = vs[i][1];
        var xj = vs[j][0], yj = vs[j][1];

        var intersect = ((yi > y) != (yj > y))
            && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
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

  final points = <LatLng>[];

  @override
  Widget build(BuildContext context) {

    _showLocationCard(context, String name, String description){
      showModalBottomSheet(context: context, builder: (BuildContext context) {
        return LocationCard(name, description, dataPointsCol);
      });
    }

    // TODO Create polygons for each location
    var polygon = [ [ 38.767002, -90.489269 ], [ 38.766971, -90.489328 ], [ 38.766922, -90.489235 ], [ 38.766980, -90.489202 ] ];

    // Check user's current location every 10 seconds  
    // TODO Compare user's current location with all Katy Trail locations
    /*Timer.periodic(Duration(seconds: 30), (timer) {
      getCurrentLocation();
    });*/

    // Build map path from file
    // TODO Fix bug: path isn't drawn until build update
    var data = loadAsset('assets/docs/path.txt');
    getPoints(data);

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
                    // Print true or false if user is within specified coordinates square 
                    print(inside([ 38.766974, -90.489245 ], polygon));
                    // TODO Add card once tapped
                    _showLocationCard(context, location["name"], location["description"]);
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

    // TODO: Get location and map onto the map
    // var geolocator = Geolocator();
    // var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

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
          new PolylineLayerOptions(polylines: [
            new Polyline(
              points: points,
              strokeWidth: 5.0,
              color: Colors.blue,
            )
          ]),
          new MarkerLayerOptions(markers: locationPlaces),
        ],
      ),
    );
  }
}