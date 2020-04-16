import 'package:flutter/material.dart';
import '../map_page/maps.dart';
import '../bookmark_page/bm_handler.dart';

class MapW extends StatelessWidget {
  final List<Map<String, Object>> data;
  final points;
  final BookmarkHandler bmHandler;
  const MapW(this.data, this.points, this.bmHandler);

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
                  MaterialPageRoute(builder: (context) => MapPage(data, points, bmHandler)),
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