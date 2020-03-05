import 'package:flutter/material.dart';
import './map.dart';
import './explore.dart';
import './about.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //appBar: new AppBar(title: Text("Katy Trail Home")),
      child: Column(
          children: <Widget>[
            MapW(),
            Explore(),
            About(),
          ],
        )
    );
  }
}