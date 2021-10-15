import 'package:flutter/material.dart';
import 'package:pack/views/screens/search_screen/search.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'package:pack/views/screens/qr_generate/upload_image.dart';
import 'package:pack/views/screens/qr_generate/generate_qr.dart';
import 'package:pack/views/screens/home.dart';
import 'package:pack/views/screens/landing.dart';
import 'package:pack/views/screens/scan/scan_qr.dart';
import 'package:pack/views/screens/inventory.dart';
import 'package:pack/models/package.dart';
import 'package:pack/models/image.dart';

// void main() => runApp(MaterialApp(
//       home: const Home(),
//       routes: {
//         '/landHome': (context) => LandHome(),
//         '/ScanQr': (context) => ScanQRPage(),
//         '/GenQr': (context) => QRGeneratorSharePage(),
//         '/Search': (context) => SearchPage(title: 'Find'),
//         '/Camera': (context) => MyHomePage(),
//       },
//     ));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  final docPath = await getApplicationDocumentsDirectory();

  Hive.init(docPath.path);
  Hive.registerAdapter(PackageAdapter());
  Hive.registerAdapter(ImgAdapter());
  await Hive.openBox<Package>('packageBox');
  await Hive.openBox('countBox');
  await Hive.openBox<Img>('imageBox');

  final _init = await Hive.box('countBox').get('isInitialized');
  if (_init == null) {
    await Hive.box('countBox').put('isInitialized', true);
    await Hive.box('countBox').put('idCounter', 1);
  }

  await Hive.openBox('settingsBox');
  await Hive.openBox('userBox');

  final _isDarkModeOn = await Hive.box('settingsBox').get('isDarkModeOn');
  // SettingsProvider().darkTheme(_isDarkModeOn ?? false);

  final _isLoggedIn = await Hive.box('userBox').get('isLoggedIn');

  if (_isLoggedIn == null) {
    await Hive.box('userBox').put('isLoggedIn', false);
  }

  final _lang = await Hive.box('settingsBox').get('activeLang');

  runApp(MaterialApp(
    home: const Home(),
    routes: {
      '/landHome': (context) => LandHome(),
      '/ScanQr': (context) => ScanQRPage(),
      '/GenQr': (context) => QRGeneratorSharePage(),
      '/Search': (context) => const HomePage(),
      '/Camera': (context) => MyHomePage(),
      '/All': (context) => InventoryPage(),
    },
  ));
}
