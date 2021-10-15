// // Flutter imports:
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:auto_route/router_utils.dart';

// // Project imports:
// import 'package:pack/views/screens/qr_generate/upload_image.dart';
// import 'package:pack/views/screens/qr_generate/generate_qr.dart';
// import 'package:pack/views/screens/home.dart';
// import 'package:pack/views/screens/landing.dart';
// import 'package:pack/views/screens/scan/scan_qr.dart';
// import 'package:pack/views/screens/search_screen/search.dart';
// import 'package:pack/views/screens/inventory.dart';
// import 'package:pack/models/package.dart';
// import 'package:pack/models/image.dart';
// import 'package:path_provider/path_provider.dart';

// class Rouut{
//   static const searchPackage = '/searchPackage';
//   static const landingHome = '/landingHome';
//   static const scanQr = '/scanQr';
//   static const generateQr = '/generateQr';
//   static const uploadImage = '/uploadImage';
//   static const inventory = '/inventory';

//   static GlobalKey<NavigatorState> get navigatorKey => getNavigatorKey<Rouut>();
//   static NavigatorState get navigator => navigatorKey.currentState;

//   static Route<dynamic> onGenerateRoute(RouteSettings settings){
//     final args = settings.arguments;
//     switch (settings.name){
//       case Rouut.searchPackage:
//         return MaterialPageRoute(
//           builder: (_) => PackageFinder(),
//           settings: settings,
//           );

//       case Rouut.landingHome:
//         return MaterialPageRoute(
//           builder: (_) => LandHome(),
//           settings: settings,
//         );

//       case Rouut.generateQr:
//         return MaterialPageRoute(
//           builder: (_) => QRGeneratorSharePage(),
//           settings: settings,
//         );

//       case Rouut.scanQr:
//         return MaterialPageRoute(
//           builder: (_) => ScanQRPage(),
//           settings: settings,
//         );

//       case Rouut.uploadImage:
//         return MaterialPageRoute(
//           builder: (_) => MyHomePage(),
//           settings: settings,
//         );

//       case Rouut.inventory:
//         return MaterialPageRoute(
//           builder: (_) => InventoryPage(),
//           settings: settings,
//         );
//     }
//   }

// }