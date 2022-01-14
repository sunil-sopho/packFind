// import 'package:flutter/material.dart';
// import 'package:echo/controller/providers/settings.dart';
// import 'package:echo/views/styles/text_style.dart';
// import 'package:echo/views/styles/colors.dart';
// import 'package:echo/views/styles/baseStyles.dart';
// import 'package:echo/views/widgets/default_button.dart';
// import 'package:provider/provider.dart';

// class AccountSetting extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//           _popNavigationWithResult(context, 'from_back');
//           return false;
//         },
//       child: Scaffold(
//         appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           'My Account',
//           style: AppTextStyle.appBarTitle.copyWith(
//             fontSize: 18,
//             color: Provider.of<SettingsProvider>(context, listen: false)
//                     .isDarkThemeOn
//                 ? AppColor.background
//                 : AppColor.onBackground,
//           ),
//         ),
//       ),
//         body: Container(
//           padding:const EdgeInsets.all(30),
//             child:Consumer<SettingsProvider>(
//         builder: (context, settingsProvider, child) => Column( 
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [ Column (
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text("Full Name"),
//               SizedBox(height: 10.0,),
//               Container(
//                   padding:const EdgeInsets.symmetric(vertical:5, horizontal:20),
//                 decoration: BoxDecoration(
//                   color: settingsProvider.isDarkThemeOn ? BaseStyles.surfaceDark :BaseStyles.surfaceNew,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: TextField(
//                   controller:TextEditingController()..text = settingsProvider.userFullName,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           DefaultButton(text:'Save Changes',press:(){

//           })]
//           ),
//           )
//         ),
//       ),
//     );
//   }

//   void _popNavigationWithResult(BuildContext context, dynamic result) {
//     Navigator.pop(context, result);
//   }
// }