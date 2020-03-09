import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';
import 'dart:io';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    String url, token;
    new File('url.key').readAsString().then((String contents) {
      url = contents;
    });
    new File('access.key').readAsString().then((String contents) {
      token = contents;
    });
    return FlutterMap(
      options: new MapOptions(
          center: new LatLng(38.77699, -90.482418), minZoom: 10.0),
      layers: [
        new TileLayerOptions(urlTemplate: url, additionalOptions: {
          'accessToken': token,
          'id': 'mapbox.mapbox-streets-v7'
        })
      ],
    );
  }
}
