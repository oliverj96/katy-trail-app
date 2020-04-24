import 'package:flutter/material.dart';
import '../location_page/LocationPage.dart';
import '../location_page/ExplorePage.dart';
import '../bookmark_page/bm_handler.dart';

class LocationCard extends StatelessWidget {
  final Map<String, Object> locDetails;
  final List<Map<String, Object>> data;
  final BookmarkHandler bmHandler;
  LocationCard(this.locDetails, this.data, this.bmHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.fromLTRB(20,20,20,20),
        child: Column(
        children: <Widget>[
          GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Image.asset('assets/images/location.png', height: 50, width: 50),
                Padding(padding: const EdgeInsets.only(top: 10.0),
                    child: Text(locDetails["name"], 
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ), 
          ), 
          GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 20.0),
                  // description takes up to 41 characters 
                    child: Text(locDetails["description"], 
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ), 
          ), 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExplorePage(locDetails)),
                      );
                    },
                    child: Padding(padding: const EdgeInsets.only(top: 20.0, right: 40.0),
                      child: Text(
                        "Explore",
                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic), 
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocationPage(data, bmHandler)),
                      );
                    },
                    child: Padding(padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Bookmark",
                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ], 
      ),
    );
  }
}