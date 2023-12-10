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

  Future<List<Map<String, dynamic>>> getAllDocuments(
      String collectionName) async {
    List<Map<String, dynamic>> documents = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        documents.add(documentSnapshot.data() as Map<String, dynamic>);
      }

      return documents;
    } catch (e) {
      print('Error getting documents: $e');
      return [];
    }
  }

  Future<void> addPublicationToScientist({
    required String scientistUid,
    required Map<String, dynamic> publicationData,
  }) async {
    try {
      DocumentSnapshot scientistSnapshot = await FirebaseFirestore.instance
          .collection('scientists')
          .doc(scientistUid)
          .get();

      List<Map<String, dynamic>> currentPublications =
          List<Map<String, dynamic>>.from(scientistSnapshot['publications']);

      currentPublications.add(publicationData);

      await FirebaseFirestore.instance
          .collection('scientists')
          .doc(scientistUid)
          .update({
        'publications': currentPublications,
      });
    } catch (e) {
      print('Error adding publication to scientist: $e');
    }
  }
}
