import 'package:flutter/material.dart';
import './TextSection.dart';
import './TitleSection.dart';
import './AboutImage.dart';
import './Audio.dart';

class LocationPage extends StatelessWidget {
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
                MaterialPageRoute(builder: (context) => new LocationPage()),
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
            TextSection(),
            TextSection(),
            Audio(),
          ],
        ), 
      ),
    );
  }
}