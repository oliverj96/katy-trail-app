import 'package:flutter/material.dart';
import './TextSection.dart';
import './TitleSection.dart';
import './AboutImage.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("About"),
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
        AboutImage(),
        TextSection(),
        TextSection(),
        TextSection(),
      ],

      ), 
    ),
    );
  }
}