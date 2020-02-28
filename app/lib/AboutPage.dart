import 'package:flutter/material.dart';
import './TextSection.dart';
import './TitleSection.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TitleSection(),
        Image.asset('assets/images/katy_trail.jpg'),
        TextSection(),
      ],
    );
  }
}
