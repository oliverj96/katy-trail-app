import 'package:flutter/material.dart';
import 'package:katy_trail_app/push_handler.dart';
import '../map_page/maps.dart';
import '../bookmark_page/bm_handler.dart';

class MapW extends StatelessWidget {
  final List<Map<String, Object>> data;
  final BookmarkHandler bmHandler;
  final PushHandler pushHandler;
  const MapW(this.data, this.bmHandler, this.pushHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage(data, bmHandler, pushHandler)),
                );
              },
              leading: Container(
                height: 100,
                child: Image.asset('assets/images/map.png', height: 100, width: 80),
              ),
              //leading: 
              title: Text('Map'),
              subtitle: Text('See the Katy Trail on maps and find locations'), 
            )
          ],
        )
      ),
      margin: EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
    );
  }
}