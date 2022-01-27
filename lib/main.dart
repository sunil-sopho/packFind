import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pack/views/styles/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:pack/models/package.dart';
import 'package:pack/models/image.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/controllers/providers/settings.dart';

late FirebaseAnalytics analytics;
final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final docPath = await getApplicationDocumentsDirectory();
  await Firebase.initializeApp();
  analytics = FirebaseAnalytics.instance;

  Hive.init(docPath.path);
  Hive.registerAdapter(PackageAdapter());
  Hive.registerAdapter(ImgAdapter());
  // flutter boxes related to data storage
  await Hive.openBox<Package>('packageBox');
  await Hive.openBox('countBox');
  await Hive.openBox<Img>('imageBox');

  final _init = await Hive.box('countBox').get('isInitialized');
  if (_init == null) {
    await Hive.box('countBox').put('isInitialized', true);
    await Hive.box('countBox').put('idCounter', 1);
  }

  // settings and user information boxes
  await Hive.openBox('settingsBox');
  await Hive.openBox('userBox');

  final _isDarkModeOn = await Hive.box('settingsBox').get('isDarkModeOn');
  SettingsProvider().darkTheme(_isDarkModeOn ?? false);

  final _isLoggedIn = await Hive.box('userBox').get('isLoggedIn');

  if (_isLoggedIn == null) {
    await Hive.box('userBox').put('isLoggedIn', false);
  }

  final _lang = await Hive.box('settingsBox').get('activeLang');

  // registering blocs
  final dataBloc = DataBloc();
  final imageBloc = ImageBloc();
  getIt.registerSingleton<DataBloc>(dataBloc);
  getIt.registerSingleton<ImageBloc>(imageBloc);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
            create: (_) => SettingsProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _appRouter = Routes();
  final dataBloc = GetIt.instance<DataBloc>();
  final imageBloc = GetIt.instance<ImageBloc>();

  @override
  void dispose() {
    imageBloc.dispose();
    dataBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("building app");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', ''),
      ],
      home: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: kLightThemeData,
        darkTheme: kDarkThemeData,
        themeMode:
            Provider.of<SettingsProvider>(context, listen: true).isDarkThemeOn
                ? ThemeMode.dark
                : ThemeMode.light,
        routerDelegate: _appRouter.delegate(
          initialRoutes: [
            if (Hive.box('userBox').get('isLoggedIn'))
              const InventoryPage()
            else
              const SplashScreen(),
          ],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
