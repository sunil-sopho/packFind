import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pack/controllers/api/google_signin_api.dart';
import 'package:pack/controllers/providers/settings.dart';
import 'package:pack/controllers/utils.dart';
// import 'package:pack/views/widgets/default_button.dart';
// import 'package:pack/controller/providers/settings.dart';
import 'package:pack/controllers/utils.dart';
// import 'package:pack/views/styles/baseStyles.dart';
// import 'package:pack/views/routes/routes.gr.dart';
// import 'package:pack/views/widgets/no_account_text.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
// import 'package:pack/views/widgets/socal_card.dart';
// import 'package:provider/provider.dart';
// import 'package:pack/utils/size_config.dart';
import 'sign_form.dart';
import 'package:pack/main.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  // SettingsProvider settings;
  @override
  Widget build(BuildContext context) {
    // settings = Provider.of<SettingsProvider>(context, listen: true);
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child:
              // Consumer<SettingsProvider>(
              //   builder: (context, settingsProvider, child) =>
              Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Image.asset(
                'assets/packFND_4_logo.png',
                width: 300,
                height: 300,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              Text(
                "Welcome Back",
                style: TextStyle(
                  // color:
                  //     Provider.of<SettingsProvider>(context, listen: true)
                  //             .isDarkThemeOn
                  //         ? BaseStyles.onBackgroundDark
                  //         : BaseStyles.onBackground,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "continue with social media",
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: SizeConfig.screenHeight * 0.08),
              // SignForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              // DefaultButton(
              //   text: "Guest Login",
              //   press: () {
              //     KeyboardUtil.hideKeyboard(context);
              //     Rouut.navigator.pushNamed(Rouut.appBase);
              //   },
              // ),
              SignInButton(
                Buttons.Email,
                text: "Guest Login",
                onPressed: () {
                  KeyboardUtil.hideKeyboard(context);
                  // while (Rouut.navigator.canPop()) {
                  //   Rouut.navigator.pop();
                  // }
                  // Rouut.navigator.pop();
                  // Rouut.navigator.pushNamed(Rouut.appBase);
                  return signInGuest(context);
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              // DefaultButton(
              //   text: "Login with Google",
              //   press: () {
              //     return signInGoogle();
              //   },
              // ),
              // with custom text
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {
                  return signInGoogle(context);
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SocalCard(
                  //   icon: Icon(Icons.audiotrack),
                  //   press: () {
                  //     showAlertDialog(context);
                  //   },
                  // ),
                  SignInButton(
                    Buttons.Facebook,
                    mini: true,
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                  SignInButton(
                    Buttons.Twitter,
                    mini: true,
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              // NoAccountText(),
              // SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ),
      //   ),
      // ),
    ));
  }

  Future signInGoogle(BuildContext context) async {
    var user;
    try {
      user = await GoogleSignInApi.login();
    } catch (error) {
      showAlertDialog(context, msg: error.toString());
    }
    print("user --------------- $user");
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    if (user != null) {
      print("signed in $user");
      print("signed in ${user.photoUrl}");
      // final ggAuth = await user.authentication;
      // print(ggAuth.idToken);
      // print(ggAuth.accessToken);

      // print("auth token :${user.getAuthResponse().id_token}")
      settings.setUserProfilePic(user.photoUrl ?? '');
      settings.setUserFullName(user.displayName ?? '');
      settings.googleSignInAccount = user;
      // while (Rouut.navigator.canPop()) {
      //   Rouut.navigator.pop();
      //   // TODO: why we did, we don't know
      // }
      // Rouut.navigator.pop();
      // Rouut.navigator.pushNamed(Rouut.appBase);
      Hive.box('userBox').put('isLoggedIn', true);
      context.router.popUntilRoot();
      context.router.pushNamed('/inventory-page');
      // analytics.logEvent(
      //     name: "signed_in_as_google",
      //     parameters: <String, dynamic>{
      //       "user_email": user.email,
      //       "user_display_name": user.displayName
      //     });
    } else {
      showAlertDialog(context, msg: 'user is null');
    }
  }

  Future signInGuest(BuildContext context) async {
    final user = await GoogleSignInApi.loginGuest();
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    if (user != null) {
      settings.setUserProfilePic(user.photoUrl);
      settings.setUserFullName(user.displayName);
      // if (settings != null) settings.googleSignInAccount = user;
      // while (Rouut.navigator.canPop()) {
      //   Rouut.navigator.pop();
      //   // TODO: why we did, we don't know
      // }
      Hive.box('userBox').put('isLoggedIn', true);
      context.router.popUntilRoot();
      context.router.pushNamed('/inventory-page');

      // Rouut.navigator.pop();
      // Rouut.navigator.pushNamed(Rouut.appBase);
      // analytics.logEvent(
      //     name: "signed_in_as_guest",
      //     parameters: <String, dynamic>{
      //       "user_email": user.email,
      //       "user_display_name": user.displayName
      //     });
    }
  }
}

showAlertDialog(BuildContext context, {String? msg}) {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    minimumSize: const Size(60, 34),
    backgroundColor: Colors.grey,
    padding: const EdgeInsets.all(0),
  );
  // Create button
  Widget okButton = TextButton(
    style: flatButtonStyle,
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: const Text(
      "OK",
      style: TextStyle(color: Colors.white),
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Coming Soon..."),
    content: Text(msg ?? "Currently this login method is not available."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
