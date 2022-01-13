import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  late String displayName, photoUrl, email;
}

// final weburl = 'https://0obx0r7bsh.execute-api.us-east-1.amazonaws.com/dev/';

// Google Sign in Function
class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() async {
    try {
      final user = await _googleSignIn.signIn();
      print("google");
      print(user);
      final gKey = await user?.authentication;

      // final accessToken = gKey?.accessToken;
      final idToken = gKey?.idToken;
      // print(idToken);

      // Checking if email and name is null
      assert(user?.email != null);
      assert(user?.displayName != null);
      assert(user?.photoUrl != null);

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
      print(error);
      return null;
    }
  }

  // log in as Guest
  static Future<User?> loginGuest() async {
    try {
      final user = User();
      // add sample credentials
      user.email = "samples@example.com";
      user.displayName = "Ted Ross";
      user.photoUrl = "https://i.ibb.co/0CkNsSk/user.png"; //sample image

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
    try {
      if (await isLoggedIn()) _googleSignIn.signOut();
    } catch (error) {}
    // chenges loggedin status to false in local storage and delete user token
    Hive.box('userBox').put('isLoggedIn', false);
    Hive.box('userBox').put('token', ""); // deleting token
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
