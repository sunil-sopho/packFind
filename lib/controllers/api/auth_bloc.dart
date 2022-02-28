import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pack/models/user.dart';

final _auth = FirebaseAuth.instance;
FirebaseFirestore _db = FirebaseFirestore.instance;

class MyUserAuth {
  static Future<PackFindUser?> getUser(String userId) {
    return _db.collection('users').doc(userId).get().then((snapshot) {
      print("snapshot---");
      print(snapshot);
      if (snapshot.exists) {
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
}

Future<PackFindUser?> signinWithCredential(AuthCredential credential,
    {bool verified = true}) async {
  //Sign in to Firebase
  dynamic user;
  try {
    final UserCredential result = await MyUserAuth.signin(credential);
    if (result.user == null) return null;
    print("result---");
    print(result);
    user = result.user;
  } catch (e) {
    return null;
  }

  //Check for existing user, Add if not yet registered
  if (user != null) {
    print("result.user---");
    print(user);
    var myuser;
    myuser = await MyUserAuth.getUser(user.uid);
    if (myuser == null) {
      //Create App Database User
      var packfindUser = PackFindUser(
          email: user.email,
          userId: user.uid,
          verified: verified,
          displayName: user.displayName);
      await MyUserAuth.setUser(packfindUser);
      myuser = packfindUser;
    }
    return myuser;
  }
  return null;
}
