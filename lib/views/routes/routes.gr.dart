// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:pack/models/package.dart' as _i15;
import 'package:pack/views/screens/dashboard.dart' as _i6;
import 'package:pack/views/screens/home.dart' as _i1;
import 'package:pack/views/screens/landing.dart' as _i2;
import 'package:pack/views/screens/package_detail_screen/package_detail_screen.dart'
    as _i9;
import 'package:pack/views/screens/qr_generate/generate_qr.dart' as _i3;
import 'package:pack/views/screens/qr_generate/upload_image.dart' as _i5;
import 'package:pack/views/screens/scan/scan_qr.dart' as _i4;
import 'package:pack/views/screens/scan/scan_result.dart' as _i8;
import 'package:pack/views/screens/search_screen/search.dart' as _i7;
import 'package:pack/views/screens/settings_screen/settings.dart' as _i11;
import 'package:pack/views/screens/sign_in/sign_in_screen.dart' as _i10;
import 'package:pack/views/screens/splash/splash_screen.dart' as _i12;

class Routes extends _i13.RootStackRouter {
  Routes([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    Home.name: (routeData) {
      final args = routeData.argsAs<HomeArgs>(orElse: () => const HomeArgs());
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.Home(key: args.key));
    },
    LandHome.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LandHome());
    },
    QRGeneratorSharePage.name: (routeData) {
      final args = routeData.argsAs<QRGeneratorSharePageArgs>(
          orElse: () => const QRGeneratorSharePageArgs());
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData,
          child:
              _i3.QRGeneratorSharePage(key: args.key, package: args.package));
    },
    ScanQRPage.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.ScanQRPage());
    },
    MyHomePage.name: (routeData) {
      final args = routeData.argsAs<MyHomePageArgs>(
          orElse: () => const MyHomePageArgs());
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: _i5.MyHomePage(key: args.key));
    },
    InventoryPage.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.InventoryPage());
    },
    PackageFinder.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.PackageFinder());
    },
    Information.name: (routeData) {
      final args = routeData.argsAs<InformationArgs>();
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.Information(key: args.key, result: args.result));
    },
    PackageDetailScreen.name: (routeData) {
      final args = routeData.argsAs<PackageDetailScreenArgs>(
          orElse: () => const PackageDetailScreenArgs());
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i9.PackageDetailScreen(
              key: args.key, packageList: args.packageList));
    },
    SignInScreen.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i10.SignInScreen());
    },
    SettingsScreen.name: (routeData) {
      final args = routeData.argsAs<SettingsScreenArgs>(
          orElse: () => const SettingsScreenArgs());
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: _i11.SettingsScreen(key: args.key));
    },
    SplashScreen.name: (routeData) {
      return _i13.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i12.SplashScreen());
    }
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(Home.name, path: '/Home'),
        _i13.RouteConfig(LandHome.name, path: '/land-home'),
        _i13.RouteConfig(QRGeneratorSharePage.name,
            path: '/q-rgenerator-share-page'),
        _i13.RouteConfig(ScanQRPage.name, path: '/scan-qr-page'),
        _i13.RouteConfig(MyHomePage.name, path: '/my-home-page'),
        _i13.RouteConfig(InventoryPage.name, path: '/inventory-page'),
        _i13.RouteConfig(PackageFinder.name, path: '/package-finder'),
        _i13.RouteConfig(Information.name, path: '/Information'),
        _i13.RouteConfig(PackageDetailScreen.name,
            path: '/package-detail-screen'),
        _i13.RouteConfig(SignInScreen.name, path: '/sign-in-screen'),
        _i13.RouteConfig(SettingsScreen.name, path: '/settings-screen'),
        _i13.RouteConfig(SplashScreen.name, path: '/')
      ];
}

/// generated route for
/// [_i1.Home]
class Home extends _i13.PageRouteInfo<HomeArgs> {
  Home({_i14.Key? key})
      : super(Home.name, path: '/Home', args: HomeArgs(key: key));

  static const String name = 'Home';
}

class HomeArgs {
  const HomeArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'HomeArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LandHome]
class LandHome extends _i13.PageRouteInfo<void> {
  const LandHome() : super(LandHome.name, path: '/land-home');

  static const String name = 'LandHome';
}

/// generated route for
/// [_i3.QRGeneratorSharePage]
class QRGeneratorSharePage
    extends _i13.PageRouteInfo<QRGeneratorSharePageArgs> {
  QRGeneratorSharePage({_i14.Key? key, _i15.Package? package})
      : super(QRGeneratorSharePage.name,
            path: '/q-rgenerator-share-page',
            args: QRGeneratorSharePageArgs(key: key, package: package));

  static const String name = 'QRGeneratorSharePage';
}

class QRGeneratorSharePageArgs {
  const QRGeneratorSharePageArgs({this.key, this.package});

  final _i14.Key? key;

  final _i15.Package? package;

  @override
  String toString() {
    return 'QRGeneratorSharePageArgs{key: $key, package: $package}';
  }
}

/// generated route for
/// [_i4.ScanQRPage]
class ScanQRPage extends _i13.PageRouteInfo<void> {
  const ScanQRPage() : super(ScanQRPage.name, path: '/scan-qr-page');

  static const String name = 'ScanQRPage';
}

/// generated route for
/// [_i5.MyHomePage]
class MyHomePage extends _i13.PageRouteInfo<MyHomePageArgs> {
  MyHomePage({_i14.Key? key})
      : super(MyHomePage.name,
            path: '/my-home-page', args: MyHomePageArgs(key: key));

  static const String name = 'MyHomePage';
}

class MyHomePageArgs {
  const MyHomePageArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'MyHomePageArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.InventoryPage]
class InventoryPage extends _i13.PageRouteInfo<void> {
  const InventoryPage() : super(InventoryPage.name, path: '/inventory-page');

  static const String name = 'InventoryPage';
}

/// generated route for
/// [_i7.PackageFinder]
class PackageFinder extends _i13.PageRouteInfo<void> {
  const PackageFinder() : super(PackageFinder.name, path: '/package-finder');

  static const String name = 'PackageFinder';
}

/// generated route for
/// [_i8.Information]
class Information extends _i13.PageRouteInfo<InformationArgs> {
  Information({_i14.Key? key, required String result})
      : super(Information.name,
            path: '/Information',
            args: InformationArgs(key: key, result: result));

  static const String name = 'Information';
}

class InformationArgs {
  const InformationArgs({this.key, required this.result});

  final _i14.Key? key;

  final String result;

  @override
  String toString() {
    return 'InformationArgs{key: $key, result: $result}';
  }
}

/// generated route for
/// [_i9.PackageDetailScreen]
class PackageDetailScreen extends _i13.PageRouteInfo<PackageDetailScreenArgs> {
  PackageDetailScreen({_i14.Key? key, _i15.Package? packageList})
      : super(PackageDetailScreen.name,
            path: '/package-detail-screen',
            args: PackageDetailScreenArgs(key: key, packageList: packageList));

  static const String name = 'PackageDetailScreen';
}

class PackageDetailScreenArgs {
  const PackageDetailScreenArgs({this.key, this.packageList});

  final _i14.Key? key;

  final _i15.Package? packageList;

  @override
  String toString() {
    return 'PackageDetailScreenArgs{key: $key, packageList: $packageList}';
  }
}

/// generated route for
/// [_i10.SignInScreen]
class SignInScreen extends _i13.PageRouteInfo<void> {
  const SignInScreen() : super(SignInScreen.name, path: '/sign-in-screen');

  static const String name = 'SignInScreen';
}

/// generated route for
/// [_i11.SettingsScreen]
class SettingsScreen extends _i13.PageRouteInfo<SettingsScreenArgs> {
  SettingsScreen({_i14.Key? key})
      : super(SettingsScreen.name,
            path: '/settings-screen', args: SettingsScreenArgs(key: key));

  static const String name = 'SettingsScreen';
}

class SettingsScreenArgs {
  const SettingsScreenArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'SettingsScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.SplashScreen]
class SplashScreen extends _i13.PageRouteInfo<void> {
  const SplashScreen() : super(SplashScreen.name, path: '/');

  static const String name = 'SplashScreen';
}
