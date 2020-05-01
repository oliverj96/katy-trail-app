import 'package:flutter/material.dart';
import 'package:katy_trail_app/bookmark_page/bm_handler.dart';
import 'package:katy_trail_app/bookmark_page/bookmarks.dart';
import './text_section.dart';
import './title_section.dart';
import './about_image.dart';

class AboutPage extends StatelessWidget {
  final BookmarkHandler bmHandler;
  AboutPage(this.bmHandler); 

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("About"),
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
        child: ListView(
          children: <Widget>[
            TitleSection(),
            AboutImage(),
            TextSection(),
            Image.asset('assets/images/Missouri.png', scale: 2.0, width: 40.0, height: 40.0),
            Image.asset('assets/images/LUlogo.png', scale: 2.0, width: 52.0, height: 52.0),
          ],
        ),
      ),
    );
  }
}