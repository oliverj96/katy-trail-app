import 'package:flutter/material.dart';
import '../about_page/AboutPage.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              leading: Image.asset('assets/images/about.png', height: 100, width: 100),
              title: Text('About'),
              subtitle: Text('Learn about the Katy Trail and this project'),
            )
          ],
        )
      ),
    );
  }
}