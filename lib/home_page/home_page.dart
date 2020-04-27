import 'package:flutter/material.dart';
import 'package:katy_trail_app/push_handler.dart';
import '../bookmark_page/bookmarks.dart';
import './map.dart';
import './explore.dart';
import './about.dart';
import '../bookmark_page/bm_handler.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, Object>> data;
  final BookmarkHandler bmHandler;
  final PushHandler pushHandler;
  HomePage(this.data, this.bmHandler, this.pushHandler);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Katy Trail Home"),
        actions: <Widget>[ 
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new Bookmarks(bmHandler)),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MapW(data, bmHandler, pushHandler),
            Explore(data, bmHandler),
            About(),
          ],
        )
      )
    );
  }
}