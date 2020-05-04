import 'package:flutter/material.dart';

/*
 * TitleSection shows the title used in the about page. 
 */

class TitleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          children: <Widget>[
            Text(
              "The Historic Katy Trail",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
