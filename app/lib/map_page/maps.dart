import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  _showLocationCard(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return (Container());
        });
  }

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

  final sampleData = [
    {"name": "Location 1", "long": 38.766964, "lat": -90.489257},
  ];

  final points = <LatLng>[];

  @override
  Widget build(BuildContext context) {
    // Build map path from file
    // TODO Fix bug: path isn't drawn until build update
    var data = loadAsset('assets/docs/path.txt');
    getPoints(data);

    // Dynamically add markers to List
    // TODO Once firebase is integrated, change sample data to pulled data
    var locationPlaces = List<Marker>();
    for (var location in sampleData) {
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
                    // TODO Add card once tapped
                    _showLocationCard(context);
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
    return FlutterMap(
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
    );
  }
}
