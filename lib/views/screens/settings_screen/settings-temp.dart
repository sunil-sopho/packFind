// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:feather_icons_flutter/feather_icons_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:echo/controller/api/google_signin_api.dart';
// import 'package:echo/views/routes/rouut.dart';
// import 'package:provider/provider.dart';

// // Project imports:
// import 'package:echo/controller/providers/settings.dart';
// import 'package:echo/config/global.dart';
// import 'package:echo/views/styles/colors.dart';
// import 'package:echo/views/styles/text_style.dart';
// import 'package:echo/config/aplication_localization.dart';

// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           AppLocalizations.of(context).translate('settings'),
//           style: AppTextStyle.appBarTitle.copyWith(
//             fontSize: 18,
//             color: Provider.of<SettingsProvider>(context, listen: false)
//                     .isDarkThemeOn
//                 ? AppColor.background
//                 : AppColor.onBackground,
//           ),
//         ),
//       ),
//       body: Consumer<SettingsProvider>(
//         builder: (context, settingsProvider, child) => ListView(
//           children: <Widget>[
//             ListTile(
//               leading: Icon(FeatherIcons.sunset),
//               title: Text(AppLocalizations.of(context).translate('dark_theme')),
//               subtitle: Text(
//                   AppLocalizations.of(context).translate('darktheme_message')),
//               onTap: () {
//                 settingsProvider.darkTheme(!settingsProvider.isDarkThemeOn);
//               },
//               trailing: Switch(
//                   activeColor: AppColor.accent,
//                   value: settingsProvider.isDarkThemeOn,
//                   onChanged: (status) {
//                     settingsProvider.darkTheme(status);
//                   }),
//             ),
//             ListTile(
//               leading: Icon(FontAwesomeIcons.language),
//               title: Text(AppLocalizations.of(context).translate('language')),
//               onTap: () {},
//               trailing: DropdownButton(
//                   underline: Container(),
//                   value: settingsProvider.activeLanguge,
//                   items: Global.lang.map((String value) {
//                     return new DropdownMenuItem<String>(
//                       value: value,
//                       child: new Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (v) {
//                     // print("lang: $v");
//                     settingsProvider.setLang(v);
//                   }),
//             ),
//             ListTile(
//               leading: Icon(Icons.supervised_user_circle),
//               // TODO: translate 'profile'
//               title: Text('Profile'), //Text(AppLocalizations.of(context).translate('profile')),
//               onTap: () {
//                 Rouut.navigator.pushNamed(Rouut.userProfile);
//               },
//               // trailing: Text(
//               //   AppLocalizations.of(context).translate('profile'),
//               // ),
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Log out'), //Text(AppLocalizations.of(context).translate('profile')),
//               onTap: () {
//                 SignInApi.logout();
//                 Rouut.navigator.pushNamed(Rouut.splash);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
