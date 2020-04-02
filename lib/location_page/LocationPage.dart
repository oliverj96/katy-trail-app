import 'package:flutter/material.dart';
import '../about_page/TitleSection.dart';
import '../about_page/AboutPage.dart';

class LocationPage extends StatelessWidget {
  final List<Map<String, Object>> data;
  LocationPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Location"),
        actions: <Widget>[ 
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new AboutPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            TitleSection(),
          ],
        ), 
      ),
    );
  }
}