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
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              leading: Icon(Icons.school),
              title: Text('About'),
              subtitle: Text('Learn about the Katy Trail and this project'),
            )
          ],
        )
      ),
    );
  }
}