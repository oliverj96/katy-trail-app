import 'package:flutter/material.dart';
import '../map_page/maps.dart';

class MapW extends StatelessWidget {
  const MapW({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              leading: Image.asset('assets/images/map.png'),
              title: Text('Map'),
              subtitle: Text('See the Katy Trail on maps and find locations'),
            )
          ],
        )
      ),
    );
  }
}