// // Flutter imports:
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:pack/controllers/api/google_signin_api.dart';
import 'package:pack/controllers/utils.dart';
import 'package:pack/main.dart';
import 'package:flutter/material.dart';

// // Package imports:
// import 'package:feather_icons_flutter/feather_icons_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:pack/controllers/api/google_signin_api.dart';
// import 'package:pack/views/routes/rouut.dart';
// import 'package:pack/views/styles/baseStyles.dart';
// import 'package:provider/provider.dart';
// import 'package:pack/config/constants.dart';
// import './account-setting.dart';
import 'package:flutter_svg/flutter_svg.dart';

// // Project imports:
// import 'package:pack/controller/providers/settings.dart';
// import 'package:pack/config/global.dart';
// import 'package:pack/views/styles/colors.dart';
// import 'package:pack/views/styles/text_style.dart';
// import 'package:pack/config/aplication_localization.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Settings'
            // AppLocalizations.of(context).translate('settings'),
            // style: AppTextStyle.appBarTitle.copyWith(
            //   fontSize: 18,
            //   color: Provider.of<SettingsProvider>(context, listen: false)
            //           .isDarkThemeOn
            //       ? AppColor.background
            //       : AppColor.onBackground,
            // ),
            ),
      ),
      body:
          // Consumer<SettingsProvider>(
          //   builder: (context, settingsProvider, child) =>
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          space(),
          profileImageBtn(),
          space(),
          ProfileMenu(
            text:
                'my_account', //AppLocalizations.of(context).translate('my_account'),
            icon: "assets/user.svg",
            press: () {
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //       builder: (context) => AccountSetting(),
              //     ));
            },
          ),
          // spaceLow(),
          // ProfileMenu(
          //   text: settingsProvider.isDarkThemeOn
          //       ? AppLocalizations.of(context).translate('switch_to_light')
          //       : AppLocalizations.of(context).translate('switch_to_dark'),
          //   icon: "assets/icons/settings.svg",
          //   press: () {
          //     settingsProvider.darkTheme(!settingsProvider.isDarkThemeOn);
          //     analytics.logEvent(
          //         name: "switched_app_theme",
          //         parameters: <String, dynamic>{
          //           'switched_to':
          //               settingsProvider.isDarkThemeOn ? 'dark' : 'light'
          //         });
          //   },
          // ),
          // spaceLow(),
          // ProfileMenu(
          //   text: settingsProvider.getActiveLanguageCode() == 'en'
          //       ? AppLocalizations.of(context).translate('change_to_kr')
          //       : AppLocalizations.of(context).translate('change_to_en'),
          //   icon: "assets/icons/settings.svg",
          //   press: () {
          //     print(settingsProvider.getActiveLanguageCode());
          //     if (settingsProvider.getActiveLanguageCode() == "en") {
          //       settingsProvider.setLang("Korean");
          //     } else {
          //       settingsProvider.setLang("English");
          //     }
          //     // analytics.logEvent(
          //     //     name: "switched_app_lang",
          //     //     parameters: <String, dynamic>{
          //     //       'switched_to':
          //     //           settingsProvider.getActiveLanguageCode() == 'en' ? 'en' : 'kr'
          //     //     });
          //   },
          // ),
          spaceLow(),
          ProfileMenu(
            text:
                "log out", //AppLocalizations.of(context).translate("log_out"),
            icon: "assets/logout.svg",
            press: () {
              GoogleSignInApi.logout();
              context.router.pushNamed('/');
              // analytics.logEvent(
              //   name: "signed_out",
              // );
            },
          ),
        ],
      ),
    );
  }

  Widget space() {
    return Container(
      padding: const EdgeInsets.all(25),
    );
  }

  Widget spaceLow() {
    return Container(
      padding: const EdgeInsets.all(1),
    );
  }

  Widget profileImageBtn() {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://st.depositphotos.com/1779253/5140/v/600/depositphotos_51405259-stock-illustration-male-avatar-profile-picture-use.jpg'),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                onPressed: () {},
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset("assets/Camera-Icon.svg",
                      color: Colors.black45),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black, //kPrimaryColor,
          backgroundColor: Colors.yellow,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.black,
              // Provider.of<SettingsProvider>(context, listen: true)
              //         .isDarkThemeOn
              //     ? BaseStyles.onBackgroundDark
              //     : BaseStyles.onBackground,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
