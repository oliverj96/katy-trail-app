import 'package:flutter/material.dart';
import 'package:katy_trail_app/bookmark_page/bm_handler.dart';
import '../about_page/about_page.dart';

/*
 * About is the home page card that navigates to the about page when tapped. 
 * It shows an icon, a title, and a description. 
 */

class About extends StatelessWidget {

  final BookmarkHandler bmHandler;
  About(this.bmHandler); 

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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AboutPage(bmHandler)),
                );
              },
              leading: Image.asset('assets/images/about.png', height: 100, width: 80),
              title: Text('About'),
              subtitle: Text('Learn about the Katy Trail and this project'),
            )
          ],
        )
      ),
      margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
    );
  }
}