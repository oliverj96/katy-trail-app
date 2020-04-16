import 'package:flutter/material.dart';
import './bm_cards.dart';
import './bm_handler.dart';
import 'dart:async';

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

  void bmChange(Map<String, Object> location){
    setState(() {
      bmHandler.RemoveBookmark(location);
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