import 'package:flutter/material.dart'; 
import './map.dart';
import './explore.dart';
import './about.dart';
import '../about_page/AboutPage.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, Object>> data;
  HomePage(this.data);

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
                MaterialPageRoute(builder: (context) => new AboutPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            
            MapW(data),
            Explore(data),
            About(),
            
          ],
        )
      )
    );
  }
}