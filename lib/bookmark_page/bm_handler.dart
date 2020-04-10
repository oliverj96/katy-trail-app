import 'dart:async';
import 'package:flutter/services.dart';

class BookmarkHandler {
  /*
   * This clas is to be initialized in the main file and passed 
   * to other widgets where needed (such as add to bookmark)
   */
  BookmarkHandler(String json){
    // TODO Initialize JSON file
    print(json);
  }
// Load Asset for Future Data Parsing
  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
  bool isBookmarked(){}

  void AddBookmark(){}

  void RemoveBookmark(){}
}