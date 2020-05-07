import 'package:flutter/material.dart';
import '../location_page/location_page.dart';
import '../bookmark_page/bm_handler.dart';

/*
 * Explore is the home page card that navigates to the explore page when tapped. 
 * It shows an icon, a title, and a description. 
 */

class Explore extends StatelessWidget {
  final List<Map<String, Object>> data;
  final BookmarkHandler bmHandler;
  const Explore(this.data, this.bmHandler);

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
                MaterialPageRoute(builder: (context) => LocationPage(data, bmHandler)), 
                );
              },
              leading: Image.asset('assets/images/explore.png', height: 100, width: 80),
              title: Text('Explore'),
              subtitle: Text('Learn about all locations on the Katy Trail'),
            )
          ],
        )
      ),
      margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
    );
  }
}