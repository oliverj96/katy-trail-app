import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/*
 * BookmarkHandler is initialized in the main file. 
 * It is passed to widgets when needed to add and remove bookmarks.  
 */

class BookmarkHandler {
  static Future<File> ffile;
  static File jsonFile;
  var bmData = List<Map<String, Object>>();

  BookmarkHandler() {
    // Get JSON file
    ffile = _localFile;
  }

  void initializeBM() async {
    var file = await ffile;
    print(file);
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

  // Return true or false if a location is already bookmarked 
  bool isBookmarked(Map<String, Object> loc) {
    for (var location in bmData) {
      if (location["name"] == loc["name"]){
        return true;
      }
    }
    return false;
  }

  // Add a location to the bookmarks page 
  void addBookmark(Map<String, Object> loc) async {
    // convert loc to json
    var jsonData = json.encode(loc);
    // write json to file
    var file = await ffile;
    file.writeAsStringSync(jsonData);
    bmData.add(loc);
  }

  // Remove a location from the bookmarks page
  void removeBookmark(Map<String, Object> loc) {
    bmData.remove(loc);
  }

  List<Map<String, Object>> getBookmarks() {
    return bmData;
  }
}
