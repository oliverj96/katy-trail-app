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
              onTap: (){
                Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => LocationPage()), 
                );
              },
              leading: Image.asset('assets/images/explore.png'),
              title: Text('Explore'),
              subtitle: Text('Learn more about all locations on the Katy Trail'),
            )
          ],
        )
      ),
    );
  }
}