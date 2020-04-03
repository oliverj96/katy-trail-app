import 'package:flutter/material.dart';
import '../about_page/AboutPage.dart';
import './location_list_cards.dart';

class LocationPage extends StatelessWidget {
  final List<Map<String, Object>> data;
  LocationPage(this.data);

  @override
  Widget build(BuildContext context) {
    var locationCards = List<LocationListCard>();
    for (var location in data) {
      var newLocationCard = LocationListCard(location);
      locationCards.add(newLocationCard);
    }
    return Scaffold(
      appBar: new AppBar(title: Text("Explore"),
        actions: <Widget>[ 
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new AboutPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: locationCards
        ), 
      ),
    );
  }
}