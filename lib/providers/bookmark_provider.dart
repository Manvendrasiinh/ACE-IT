import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  List<Map<String, dynamic>> bookmarks = [];

  Future<void> fetchBookmarks() async {
    print("Fetching bookmarks..."); // Debug print
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.getString("BOOKMARKS") ?? '[]';  // Use '[]' if no data is found
    try {
      List<dynamic> decodedList = jsonDecode(data);
      bookmarks = decodedList.cast<Map<String, dynamic>>()
          .map((map) => Map<String, dynamic>.from(map)..putIfAbsent('isExpanded', () => false))
          .toList();
      print("Bookmarks fetched: $bookmarks"); // Debug print
    } catch (e) {
      bookmarks = [];
      print("Error decoding bookmarks: $e"); // Debug print
    }
    notifyListeners();
  }

  void toggleExpansion(int index) {
    bookmarks[index]['isExpanded'] = !bookmarks[index]['isExpanded'];
    notifyListeners();
  }
}
