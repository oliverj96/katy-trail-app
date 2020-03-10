import 'package:flutter/material.dart';

class MapW extends StatelessWidget {
  const MapW({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /*onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapPage()),
        );
      },*/
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
              subtitle: Text('See the Katy Trail on maps and find locations'),
            )
          ],
        )
      ),
    );
  }
}