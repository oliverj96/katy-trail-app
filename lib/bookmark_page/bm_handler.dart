import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class BookmarkHandler {
  /*
   * This clas is to be initialized in the main file and passed 
   * to other widgets where needed (such as add to bookmark)
   */

  //https://medium.com/flutter-community/how-to-parse-json-in-flutter-for-beginners-8074a68d7a79
  //https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  static Future<File> ffile;
  BookmarkHandler(){
    // TODO Initialize JSON file
    // print(json);
    ffile = _localFile;
    // print(jsonFile);
    // json.
  }

  // Load Asset for Future Data Parsing
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/bookmarks.json');
  }

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
  bool isBookmarked(){}

  void AddBookmark(){}

  void RemoveBookmark(){}
}