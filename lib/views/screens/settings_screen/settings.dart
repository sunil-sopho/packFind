// // // Flutter imports:
// import 'package:pack/main.dart';
// import 'package:flutter/material.dart';

// // // Package imports:
// // import 'package:feather_icons_flutter/feather_icons_flutter.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:pack/controllers/api/google_signin_api.dart';
// // import 'package:pack/views/routes/rouut.dart';
// // import 'package:pack/views/styles/baseStyles.dart';
// // import 'package:provider/provider.dart';
// // import 'package:pack/config/constants.dart';
// // import './account-setting.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// // // Project imports:
// // import 'package:pack/controller/providers/settings.dart';
// // import 'package:pack/config/global.dart';
// // import 'package:pack/views/styles/colors.dart';
// // import 'package:pack/views/styles/text_style.dart';
// // import 'package:pack/config/aplication_localization.dart';

// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         title: Text('Settings'
//             // AppLocalizations.of(context).translate('settings'),
//             // style: AppTextStyle.appBarTitle.copyWith(
//             //   fontSize: 18,
//             //   color: Provider.of<SettingsProvider>(context, listen: false)
//             //           .isDarkThemeOn
//             //       ? AppColor.background
//             //       : AppColor.onBackground,
//             // ),
//             ),
//       ),
//       body: 
//       // Consumer<SettingsProvider>(
//       //   builder: (context, settingsProvider, child) => 
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             space(),
//             profileImageBtn(settingsProvider),
//             space(),
//             ProfileMenu(
//               text: 'my_account',//AppLocalizations.of(context).translate('my_account'),
//               icon: "assets/icons/user.svg",
//               press: () {
//                 Navigator.push(
//                     context,
//                     new MaterialPageRoute(
//                       builder: (context) => AccountSetting(),
//                     ));
//               },
//             ),
//             spaceLow(),
//             ProfileMenu(
//               text: settingsProvider.isDarkThemeOn
//                   ? AppLocalizations.of(context).translate('switch_to_light')
//                   : AppLocalizations.of(context).translate('switch_to_dark'),
//               icon: "assets/icons/settings.svg",
//               press: () {
//                 settingsProvider.darkTheme(!settingsProvider.isDarkThemeOn);
//                 analytics.logEvent(
//                     name: "switched_app_theme",
//                     parameters: <String, dynamic>{
//                       'switched_to':
//                           settingsProvider.isDarkThemeOn ? 'dark' : 'light'
//                     });
//               },
//             ),
//             spaceLow(),
//             ProfileMenu(
//               text: settingsProvider.getActiveLanguageCode() == 'en'
//                   ? AppLocalizations.of(context).translate('change_to_kr')
//                   : AppLocalizations.of(context).translate('change_to_en'),
//               icon: "assets/icons/settings.svg",
//               press: () {
//                 print(settingsProvider.getActiveLanguageCode());
//                 if (settingsProvider.getActiveLanguageCode() == "en") {
//                   settingsProvider.setLang("Korean");
//                 } else {
//                   settingsProvider.setLang("English");
//                 }
//                 // analytics.logEvent(
//                 //     name: "switched_app_lang",
//                 //     parameters: <String, dynamic>{
//                 //       'switched_to':
//                 //           settingsProvider.getActiveLanguageCode() == 'en' ? 'en' : 'kr'
//                 //     });
//               },
//             ),
//             spaceLow(),
//             ProfileMenu(
//               text: AppLocalizations.of(context).translate("log_out"),
//               icon: "assets/icons/logout.svg",
//               press: () {
//                 GoogleSignInApi.logout();
//                 Rouut.navigator.pushNamed(Rouut.splash);
//                 // analytics.logEvent(
//                 //   name: "signed_out",
//                 // );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget space() {
//     return Container(
//       padding: const EdgeInsets.all(25),
//     );
//   }

//   Widget spaceLow() {
//     return Container(
//       padding: const EdgeInsets.all(1),
//     );
//   }

//   Widget profileImageBtn(settingsProvider) {
//     return SizedBox(
//       height: 115,
//       width: 115,
//       child: Stack(
//         fit: StackFit.expand,
//         clipBehavior: Clip.none,
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(settingsProvider.userProfilePic),
//           ),
//           Positioned(
//             right: -16,
//             bottom: 0,
//             child: SizedBox(
//               height: 46,
//               width: 46,
//               child: TextButton(
//                 onPressed: () {},
//                 child: Container(
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.white),
//                   padding: const EdgeInsets.all(5),
//                   child: SvgPicture.asset("assets/icons/Camera-Icon.svg",
//                       color: Colors.black45),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ProfileMenu extends StatelessWidget {
//   const ProfileMenu({
//     Key? key,
//     required this.text,
//     required this.icon,
//     required this.press,
//   }) : super(key: key);

//   final String text, icon;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: FlatButton(
//         padding: EdgeInsets.all(17),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         color: Colors.black,
//             // Provider.of<SettingsProvider>(context, listen: true).isDarkThemeOn
//             //     ? BaseStyles.surfaceDark
//             //     : BaseStyles.surface,
//         onPressed: press,
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               icon,
//               color: Colors.black,
//               // Provider.of<SettingsProvider>(context, listen: true)
//               //         .isDarkThemeOn
//               //     ? BaseStyles.onBackgroundDark
//               //     : BaseStyles.onBackground,
//               width: 22,
//             ),
//             SizedBox(width: 20),
//             Expanded(child: Text(text)),
//             Icon(Icons.arrow_forward_ios),
//           ],
//         ),
//       ),
//     );
//   }
// }
