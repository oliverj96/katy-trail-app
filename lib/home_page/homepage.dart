import 'package:flutter/material.dart';
import '../bookmark_page/bookmarks.dart';
import './map.dart';
import './explore.dart';
import './about.dart';
import '../about_page/AboutPage.dart';
import '../bookmark_page/bm_handler.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, Object>> data;
  final BookmarkHandler bmHandler;
  
  final points;
  HomePage(this.data, this.points, this.bmHandler);

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
            
            MapW(data, points, bmHandler),
            Explore(data, bmHandler),
            About(),
            
          ],
        )
      )
    );
  }
}