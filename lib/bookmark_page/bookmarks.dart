import 'package:flutter/material.dart';
import './bm_cards.dart';
import './bm_handler.dart';

/*
 * Bookmarks shows a list of all bookmarked location cards. 
 * Each location card includes an image, a name, and a short description. 
 */

class Bookmarks extends StatefulWidget {
  final BookmarkHandler bmHandler;
  Bookmarks(this.bmHandler);

  @override
  _BookmarksState createState() => _BookmarksState(bmHandler);
}

class _BookmarksState extends State<Bookmarks> {
  final BookmarkHandler bmHandler;
  List<Map<String, Object>> bmList;

  _BookmarksState(this.bmHandler);

  // Listen to state change for bookmark updates
  void bmChange(Map<String, Object> location) {
    setState(() {
      bmHandler.removeBookmark(location);
      bmList = bmHandler.getBookmarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      bmList = bmHandler.getBookmarks();
    });
    var bmCards = List<BMCard>();
    for (var bmLoc in bmList) {
      BMCard temp = BMCard(bmLoc, bmHandler, bmChange);
      bmCards.add(temp);
    }

    return Scaffold(
      appBar: new AppBar(title: Text("Bookmarks")),
       body: ListView(
         children: bmCards,
       ),
    );
  }
}