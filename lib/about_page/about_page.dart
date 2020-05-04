import 'package:flutter/material.dart';
import 'package:katy_trail_app/bookmark_page/bm_handler.dart';
import 'package:katy_trail_app/bookmark_page/bookmarks.dart';
import './text_section.dart';

/*
 * AboutPage shows a title, Katy Trail image, text section, 
 * a Magnificent Missouri logo, and Lindenwood University logo.
 */

class AboutPage extends StatelessWidget {
  final BookmarkHandler bmHandler;
  AboutPage(this.bmHandler); 

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Historic Katy Trail"),
      actions: <Widget>[ 
        IconButton(
          icon: Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new Bookmarks(bmHandler)),
            );
          },
        ),
      ],
    ),
      body: Center(
        child: ListView(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(top: 10.0, bottom: 10.0), 
              child: new Image.asset('assets/images/katy_trail.png', scale: 2.0),
            ),
            TextSection(),
            new Container(
              padding: new EdgeInsets.only(top: 15.0), 
              child: new Image.asset('assets/images/Missouri.png', scale: 2.0, width: 40.0, height: 40.0),
            ),
            //Image.asset('assets/images/Missouri.png', scale: 2.0, width: 40.0, height: 40.0),
            new Container(
              padding: new EdgeInsets.only(top: 10.0), 
              child: new Image.asset('assets/images/LUlogo.png', scale: 2.0, width: 52.0, height: 52.0),
            ),
            //Image.asset('assets/images/LUlogo.png', scale: 2.0, width: 52.0, height: 52.0),
          ],
        ),
      ),
    );
  }
}