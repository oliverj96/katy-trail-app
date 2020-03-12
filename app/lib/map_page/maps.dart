import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  Future getPoints(Future<String> data) async {
    return await data.then((dataPoints) {
      var dump = dataPoints.split(' ');
      for (var i = 0; i < dump.length - 2; i += 2) {
        // print(i);
        var newPoint =
            new LatLng(double.parse(dump[i]), double.parse(dump[i + 1]));
        // print(newPoint);
        points.add(newPoint);
      }
    });
  }

  final sampleData = [
    {"name": "Location 1", "long": 38.766964, "lat": -90.489257},
    // {"name": "Location 2", "long": 12.1, "lat": 12.1},
  ];

  final points = <LatLng>[
    // new LatLng(38.766964, -90.489257),
    // new LatLng(38.800099, -90.470506),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO read from file

    var data = loadAsset('assets/docs/path.txt');
    getPoints(data);
    var locationPlaces = List<Marker>();
    for (var location in sampleData) {
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
                    print("Location: " + location["name"] + " was tapped.");
                  },
                ),
              ));
          locationPlaces.add(temp);
    }
    // setState(() {
    // });
    // dump.add(15);
    // String data = await getFileData('assets/docs/path.txt');

    // var test = pathFile.readAsString();
    // test.then((String contents){
    //   print(contents);
    // });
    String url, token;
    url =
        'https://api.mapbox.com/styles/v1/ojohnson7cc/ck79a877u2ffj1jnn4dfgh3r9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWE0ZG5nMHIyaDNlcWh4cHd5N3I2bSJ9.L1xfay1JISdfIO1jDp8rTg';
    token =
        'sk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWp2cnNqMHUydzNlcWtxd2R4c2JncCJ9.keCK6gFmt7EO9Ug4GwC_jg';
    // var geolocator = Geolocator();
    // var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
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
        new MarkerLayerOptions(markers: 
          locationPlaces
        ),
      ],
    );
  }
}
