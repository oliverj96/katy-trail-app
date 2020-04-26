import 'package:flutter/material.dart';
import './location_list_cards.dart';
import '../bookmark_page/bm_handler.dart';
import '../bookmark_page/bookmarks.dart';

class LocationPage extends StatelessWidget {
  final List<Map<String, Object>> data;
  final BookmarkHandler bmHandler;
  LocationPage(this.data, this.bmHandler);

  @override
  Widget build(BuildContext context) {
    var locationCards = List<LocationListCard>();
    for (var location in data) {
      var newLocationCard = LocationListCard(location, bmHandler);
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
                MaterialPageRoute(builder: (context) => new Bookmarks(bmHandler)),
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