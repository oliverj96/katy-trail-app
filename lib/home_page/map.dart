import 'package:flutter/material.dart';
import '../map_page/maps.dart';

class MapW extends StatelessWidget {
  final List<Map<String, Object>> data;
  final points;
  const MapW(this.data, this.points);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage(data, points)),
                );
              },
              leading: Container(
                height: 100,
                child: Image.asset('assets/images/map.png', height: 100, width: 100),
              ),
              //leading: 
              title: Text('Map'),
              subtitle: Text('See the Katy Trail on maps and find locations'), 
            )
          ],
        )
      ),
    );
  }
}