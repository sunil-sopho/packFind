// Flutter imports:
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Package imports:
import 'package:hive/hive.dart';

class SettingsProvider extends ChangeNotifier {
  bool isDarkThemeOn = Hive.box('settingsBox').get('isDarkModeOn') ?? false;
  String activeLanguge = Hive.box('settingsBox').get('activeLang') ?? "English";
  String localeCode = "en";
  late GoogleSignInAccount googleSignInAccount;
  String userProfilePic = Hive.box('userBox').get('userProfilePic') ??
      'https://www.woolha.com/media/2020/03/eevee.png';
  String userFullName = Hive.box('userBox').get('userFullName') ?? '';

  String getActiveLanguageCode() {
    final value = Hive.box('settingsBox').get('activeLang');
    switch (value) {
      case "हिंदी":
        return "hi";
      default:
        return "en";
    }
  }

  void darkTheme(bool status) {
    isDarkThemeOn = status;

    final themeBox = Hive.box('settingsBox');
    themeBox.put('isDarkModeOn', status);

    notifyListeners();
  }

  void setUserProfilePic(String profilePicUrl) {
    userProfilePic = profilePicUrl;
    Hive.box('userBox').put('userProfilePic', profilePicUrl);
    notifyListeners();
  }

  void setUserFullName(String fullName) {
    userFullName = fullName;
    Hive.box('userBox').put('userFullName', userFullName);
    notifyListeners();
  }

  void setLang(String value) {
    activeLanguge = value;

    final langBox = Hive.box('settingsBox');

    switch (value) {
      case "हिंदी":
        langBox.put('activeLang', "हिंदी");
        localeCode = "hi";
        notifyListeners();

        break;
      default:
        langBox.put('activeLang', "English");
        localeCode = "en";
        notifyListeners();
    }

    notifyListeners();
  }
}

// class UserData {
//   String firstName;
//   String lastName;
//   String phone;
//
//   UserData({this.firstName, this.lastName, this.phone});
// }
