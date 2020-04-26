import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final Map<String, Object> locDetails;
  const ExplorePage(this.locDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // child: child,
      appBar: new AppBar(title: Text(locDetails["name"])),
      body: ListView(
        children: <Widget>[
          Text(locDetails["LongDes"])
        ],
      ),
    );
  }
}
