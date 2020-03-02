import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

// class MapsPage extends StatefulWidget {
//   @override
//   _MapsPageState createState() => new _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(title: new Text('Leaflet Maps')),
//         body: new FlutterMap(
//             options: new MapOptions(
//                 center: new LatLng(35.22, -101.83), minZoom: 10.0),
//             layers: [
//               new TileLayerOptions(
//                   urlTemplate:
//                       "mapbox://styles/ojohnson7cc/ck79a877u2ffj1jnn4dfgh3r9",
//                   additionalOptions: {
//                     'accessToken':
//                         'pk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWE0ZG5nMHIyaDNlcWh4cHd5N3I2bSJ9.L1xfay1JISdfIO1jDp8rTg',
//                     'id': 'mapbox.mapbox-streets-v7'
//                   })
//             ]));
//   }
// }

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options:
          new MapOptions(center: new LatLng(38.77699, -90.482418), minZoom: 10.0),
      layers: [
        new TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/ojohnson7cc/ck79a877u2ffj1jnn4dfgh3r9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWE0ZG5nMHIyaDNlcWh4cHd5N3I2bSJ9.L1xfay1JISdfIO1jDp8rTg",
            additionalOptions: {
              'accessToken':
                  'sk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWp2cnNqMHUydzNlcWtxd2R4c2JncCJ9.keCK6gFmt7EO9Ug4GwC_jg',
              'id': 'mapbox.mapbox-streets-v7'
            })
      ],
    );
  }
}
