import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashCardProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot> cards = [];
  int progress = 0;
  String cardCategory = '';
  String cardType = '';
  List<Map<String, String>> bookmarks = [];

  Future<void> fetchQuestions({
    required String name,
    required String type,
    required String category,
  }) async {
    try {
      QuerySnapshot data = await FirebaseFirestore.instance
          .collection(category)
          .doc(type)
          .collection('flash_cards')
          .orderBy('id')
          .get();
      cards = data.docs;
      cardCategory = category;
      cardType = type;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      progress = int.parse(preferences.getString('${cardCategory}_${cardType}_PROGRESS') ?? '0');
      String? bookmarksString = preferences.getString('BOOKMARKS');
      if (bookmarksString != null) {
        List<dynamic> decodedBookmarks = jsonDecode(bookmarksString);
        bookmarks = decodedBookmarks.map((item) => Map<String, String>.from(item)).toList();
      }
      notifyListeners();
    } catch (error) {
      print('Error fetching questions: $error');
      rethrow;
    }
  }

  Future<void> toggleBookmark(String question, String answer) async {
    Map<String, String> bookmark = {'que': question, 'ans': answer};
    if (bookmarks.any((item) => item['que'] == question)) {
      bookmarks.removeWhere((item) => item['que'] == question);
    } else {
      bookmarks.add(bookmark);
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('BOOKMARKS', jsonEncode(bookmarks));
    print(bookmarks);
    notifyListeners();
  }

  Future<void> nextQuestion() async {
    if (progress < cards.length - 1) {
      progress++;
    } else {
      progress = 0;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('${cardCategory}_${cardType}_PROGRESS', progress.toString());
    notifyListeners();
  }

  Future<void> resetProgress() async {
    progress = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('${cardCategory}_${cardType}_PROGRESS', progress.toString());
    notifyListeners();
  }

  bool isBookmarked(String question) {
    return bookmarks.any((item) => item['que'] == question);
  }
}