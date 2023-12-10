import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setData(
    String collection,
    String document,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection(collection).doc(document).set(data);
      print('Data added successfully');
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<Map<String, dynamic>?> getData(
    String collection,
    String document,
  ) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection(collection).doc(document).get();
      return snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting data: $e');
      return null;
    }
  }
}
