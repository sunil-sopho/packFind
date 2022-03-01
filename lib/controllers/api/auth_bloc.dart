import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pack/models/packfindUser.dart';

final _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;

class MyUserAuth {
  static Future<PackFindUser?> getUser(String userId) {
    return _db.collection('users').doc(userId).get().then((snapshot) {
      if (snapshot.exists) {
        // log("snapshot data----");
        // log(snapshot.data().toString());
        return PackFindUser.fromJson(snapshot.data());
      } else {
        return null;
      }
    });
  }

  static Future<void> setUser(PackFindUser user) {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  static Future<UserCredential> signin(AuthCredential credential) {
    return _auth.signInWithCredential(credential);
  }

  static User? user() => _auth.currentUser;
  static Future<void> signOut() => _auth.signOut();
}
