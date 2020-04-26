import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 30, left: 30, bottom: 10),
        child: Column(
          children: <Widget>[
            Text(
                "Welcome to the virtual Katy Trail app!  " +
                "Here you can find information about sites along the trail and something of their history.o " + 
                "Keep watching—more sites are going to be added all the time.\n\n " +
                "This app is a collaboration with Magnificent Missouri, the Katy Land Trust, and Lindenwood University students.  ",
                style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
   
      ),
    );
  }
}