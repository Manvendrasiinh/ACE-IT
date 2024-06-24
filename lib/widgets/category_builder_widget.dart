import 'package:ace_it/shimers/home_screen_shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/card_model.dart';
import 'card_list_widget.dart';

class CategoryBuilderWidget extends StatelessWidget {
  final String name;
  const CategoryBuilderWidget({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(name).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeScreenShimmer();
        }
        if (snapshot.hasError) {
          return const HomeScreenShimmer();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const HomeScreenShimmer();
        }
        List<CardModel> cards = snapshot.data!.docs
            .map((doc) => CardModel.fromFirestore(doc))
            .toList();
        return CardListWidget(cards: cards);
      },
    );
  }
}
