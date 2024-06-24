import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  final String name;
  final String logo;
  final String category;
  final String type;

  const CardModel(
      {required this.name,
      required this.logo,
      required this.category,
      required this.type});

  factory CardModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CardModel(
        name: data['name'],
        logo: data['logo'],
        category: data['category'],
        type: data['type']);
  }
}
