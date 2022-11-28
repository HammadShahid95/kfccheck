import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  // --- sign in, up and out
  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('Error happened');
    }
  }
  Future<dynamic> getFromStore({
 required String path,
    String? parentId,
}) async {}
}
