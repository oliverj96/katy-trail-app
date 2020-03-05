import 'package:flutter/material.dart';
import './TextSection.dart';
import './TitleSection.dart';
import './AboutImage.dart';

class AboutPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ListView( // gives scrolling ability 
      children: <Widget>[
        //AboutUsAppBar()
        TitleSection(),
        AboutImage(),
        TextSection(),
        TextSection(),
        TextSection(),
      ],
    );
  }
}