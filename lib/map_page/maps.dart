import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import './location-card.dart';
import '../bookmark_page/bm_handler.dart';
import '../push_handler.dart';

class MapPage extends StatefulWidget {
  final List<Map<String, Object>> dataPointsCol;
  final BookmarkHandler bmHandler;
  final PushHandler pushHandler;
  MapPage(this.dataPointsCol, this.bmHandler, this.pushHandler);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  double _avgLatitude = 0.0; 
  double _avgLongitude = 0.0; 

  void _getAverageLocation() {
    for (var location in widget.dataPointsCol) {
      _avgLatitude += location["lat"];
      _avgLongitude += location["long"];
    }
    _avgLatitude /= widget.dataPointsCol.length;
    _avgLongitude /= widget.dataPointsCol.length;
  }

  @override
  void initState() {
    _getAverageLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    _showLocationCard(context, Map<String, Object> locData) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return LocationCard(
                locData, widget.dataPointsCol, widget.bmHandler);
          });
    }
 
    var locationPlaces = List<Marker>();
    for (var location in widget.dataPointsCol) {
      // Create marker widget for each location
      var temp = new Marker(
          width: 45.0,
          height: 45.0,
          point: new LatLng(location["lat"], location["long"]),
          builder: (context) => new Container(
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.red,
                  iconSize: 45.0,
                  onPressed: () {
                    //locationData = location;
                    //widget.pushHandler.showNotification(location);
                    _showLocationCard(context, location);
                    print("Location: " + location["name"] + " was tapped.");
                  },
                ),
              ));
      // Append location to list of places
      locationPlaces.add(temp);   
    }

    var url =
        'https://api.mapbox.com/styles/v1/ojohnson7cc/ck79a877u2ffj1jnn4dfgh3r9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWE0ZG5nMHIyaDNlcWh4cHd5N3I2bSJ9.L1xfay1JISdfIO1jDp8rTg';
    var token =
        'sk.eyJ1Ijoib2pvaG5zb243Y2MiLCJhIjoiY2s3OWp2cnNqMHUydzNlcWtxd2R4c2JncCJ9.keCK6gFmt7EO9Ug4GwC_jg';

    // Create Flutter Map Widget
    return Scaffold(
      appBar: new AppBar(
        title: Text('Map'),
      ),
      body: FlutterMap(
        options: new MapOptions(
            center: new LatLng(_avgLatitude, _avgLongitude,), maxZoom: 10),
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
