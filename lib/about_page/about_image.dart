import 'package:flutter/material.dart';

class AboutImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 15),
        child: Image.asset('assets/images/katy_trail.png'),
      ),
    );
  }
}