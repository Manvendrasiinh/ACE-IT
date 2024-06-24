import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/flash_card_screen.dart';

class CardSelectedProvider extends ChangeNotifier {
  bool isCardSelected = false;
  String selectedCardName = '';
  String selectedCardCategory = '';
  String selectedCardType = '';

  void onCardSelected({required String name, required String type, required String category, required BuildContext context}) {
    selectedCardName = name;
    selectedCardType = type;
    selectedCardCategory = category;
    isCardSelected = true;
    notifyListeners();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FlashCardScreen(
      name: name,
      category: category,
      type: type,
    )));
  }
}
