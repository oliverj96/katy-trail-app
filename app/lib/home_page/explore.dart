import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  const Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              /*onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()), 
                );
              },*/
              leading: Icon(Icons.map),
              title: Text('Explore'),
              subtitle: Text('Learn more about all locations on the Katy Trail'),
            )
          ],
        )
      ),
    );
  }
}