import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:pack/models/packfindUser.dart';

import 'auth_bloc.dart';

class User {
  late String displayName, photoUrl, email;
}

// final weburl = 'https://0obx0r7bsh.execute-api.us-east-1.amazonaws.com/dev/';

// Google Sign in Function
class SignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<PackFindUser?> signinWithCredential(AuthCredential credential,
      {bool verified = true}) async {
    //Sign in to Firebase
    final UserCredential result = await MyUserAuth.signin(credential);
    log("result ${result.toString()}");
    dynamic user = result.user;
    log("user + ${user.toString()}");
    //Check for existing user, Add if not yet registered
    if (user != null) {
      // log("h1 ------");
      var myuser = await MyUserAuth.getUser(user.uid);
      // log("####___###");
      // log(myuser.toString());
      // log("###__##");
      if (myuser == null) {
        // log("IMP: myuser is null");
        //Create App Database User
        var packfindUser = PackFindUser(
            email: user.email,
            userId: user.uid,
            verified: verified,
            displayName: user.displayName,
            photoUrl: user.photoURL);
        await MyUserAuth.setUser(packfindUser);
        myuser = packfindUser;
      }
      log("myuser ${myuser.toString()}");
      return myuser;
    }
    throw Exception("Unable to signin! Please try again.");
  }

  static Future<PackFindUser?> appleLogin() async {
    try {
      if (!await TheAppleSignIn.isAvailable()) {
        throw Exception('This Device is not eligible for Apple Sign in');
      }
    } catch (error) {
      rethrow;
    }

    final result = await TheAppleSignIn.performRequests(const [
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    // _processRunning.sink.add(true);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );

        final user = await signinWithCredential(credential);
        Hive.box('userBox').put('isLoggedIn', true);

        return user;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }

  static Future<PackFindUser?> login() async {
    try {
      // final user = await _googleSignIn.signIn();
      // log("google");
      // if (user == null) {
      //   log("google is null");

      //   return null;
      // }
      // // log(user.toString());
      // final gKey = await user.authentication;

      // // final accessToken = gKey?.accessToken;
      // final idToken = gKey.idToken;
      // // print(idToken);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Account can't be signed in");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final user = await signinWithCredential(credential);

      // Checking if email and name is null
      // assert(user.email != null);
      // assert(user.displayName != null);
      // assert(user.photoUrl != null);
      // log("assert passed");
      // log(user.toString());
      // var url = Uri.parse(weburl + 'login');
      // var response = await http.post(url, body: {'idToken': idToken});
      // print("rej");
      // print(jsonDecode(response.body));
      // if (response.statusCode != 200) {
      //   return null;
      // }
      // Saves user token and loggedin status in local storage so that user dont need to login every time
      Hive.box('userBox').put('isLoggedIn', true);
      // Hive.box('userBox').put('token', json.decode(response.body)['token']);
      // result.authentication.then((googleKey) {
      // print(accessToken);
      // print(idToken);
      //   print(_googleSignIn.currentUser.displayName);
      // }).catchError((err) {
      //   print('inner error');
      // });
      // print("return result");
      return user;
    } catch (error) {
      log(error.toString());

      rethrow;
    }

    // try {
    //
    //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    //   if (googleUser == null) {
    //     throw Exception("Account can't be signed in");
    //   }
    //   final GoogleSignInAuthentication googleAuth =
    //       await googleUser.authentication;
    //   log("1 googleauth-----");
    //   log(googleUser.toString());
    //   log(googleAuth.toString());
    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //       idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    //   // _processRunning.sink.add(true);
    //   final user = await signinWithCredential(credential);
    //   // return user;
    //   // _processRunning.sink.add(false);

    // } on PlatformException catch (error) {
    //   return null;
    //   // _processRunning.sink.add(false);
    //   // _errorMessage.sink.add(error.message);
    // } on FirebaseAuthException catch (error) {
    //   return null;
    //   // _processRunning.sink.add(false);
    //   // _errorMessage.sink.add(error.message);
    // } catch (e) {
    //   return null;
    // }
    // return null;
  }

  // log in as Guest
  static Future<User?> loginGuest() async {
    try {
      final user = User();
      // add sample credentials
      user.email = "samples@example.com";
      user.displayName = "Ted Ross";
      user.photoUrl = "https://www.woolha.com/media/2020/03/eevee.png";
      //"https://i.ibb.co/0CkNsSk/user.png"; //sample image

      // var url = Uri.parse(weburl + 'login_guest');
      // var response = await http.post(url);

      // print(jsonDecode(response.body));
      // if (response.statusCode != 200) {
      //   return null;
      // }
      Hive.box('userBox').put('isLoggedIn', true);
      // Hive.box('userBox').put('token', json.decode(response.body)['token']);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Function to logout
  static Future logout() async {
    await MyUserAuth.signOut();
    try {
      if (await isLoggedIn()) _googleSignIn.signOut();
    } catch (error) {}
    // chenges loggedin status to false in local storage and delete user token
    Hive.box('userBox').put('isLoggedIn', false);
    Hive.box('userBox').put('token', ""); // deleting token
    log("logout callled");
  }

  static verifyToken() async {
    // var url = Uri.parse(weburl + 'verify');
    // final token = Hive.box('userBox').get('token');
    // var response = await http.post(url, body: {'token': token});

    // print(jsonDecode(response.body));
    // if (response.statusCode != 200) {
    //   return false;
    // }
    return true;
  }

  // Function to check if user is logged in or not
  static isLoggedIn() async {
    var isLoggedInValue = false;
    try {
      isLoggedInValue = await _googleSignIn.isSignedIn();
    } catch (error) {}
    isLoggedInValue = await verifyToken() || isLoggedInValue;
    return isLoggedInValue;
  }
}
