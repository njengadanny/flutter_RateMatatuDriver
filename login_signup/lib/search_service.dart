import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('firstName',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .snapshots();
  }
}