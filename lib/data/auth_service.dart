import 'package:firebase_auth/firebase_auth.dart';

import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();

  Future<UserCredential?> signUpWithEmail(
    String email,
    String password,
    String displayName,
    bool isScientist,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(displayName);

      Map<String, dynamic> userData = {
        'authorId': userCredential.user!.uid,
        'email': email,
        'role': isScientist ? 'scientists' : 'user',
        'displayName': displayName,
        'publications': [],
      };

      await _databaseService.setData(
        'scientists',
        userCredential.user!.uid,
        userData,
      );

      return userCredential;
    } catch (e) {
      print("Error during email registration: $e");
      return null;
    }
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print("Error during email login: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
