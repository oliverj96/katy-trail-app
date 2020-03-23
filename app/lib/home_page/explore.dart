import 'package:flutter/material.dart';
import '../location_page/LocationPage.dart';

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
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              onTap: (){
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => LocationPage()), 
                );
              },
              leading: Image.asset('assets/images/explore.png', height: 100, width: 100),
              title: Text('Explore'),
              subtitle: Text('Learn about all locations on the Katy Trail'),
            )
          ],
        )
      ),
    );
  }
}