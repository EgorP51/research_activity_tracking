import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setData(
    String collection,
    String document,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection(collection).doc(document).set(data);
      if (kDebugMode) {
        print('Data added successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding data: $e');
      }
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
      if (kDebugMode) {
        print('Error getting data: $e');
      }
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
      if (kDebugMode) {
        print('Error getting documents: $e');
      }
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
      if (kDebugMode) {
        print('Error adding publication to scientist: $e');
      }
    }
  }

  Future<void> changeUserRole({
    required String userId,
    required String newRole,
  }) async {
    try {
      await _db.collection('scientists').doc(userId).update({
        'role': newRole,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error changing user role: $e');
      }
      rethrow;
    }
  }

  Future<void> deletePublication(String publicationId) async {
    try {
      await _db.collection('publications').doc(publicationId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting publication: $e');
      }
      rethrow;
    }
  }

  Future<void> verifyPublication(String publicationId) async {
    try {
      await _db.collection('publications').doc(publicationId).update({
        'verified': "true",
      });

      if (kDebugMode) {
        print('Publication verification status updated successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating publication verification status: $e');
      }
    }
  }
}
