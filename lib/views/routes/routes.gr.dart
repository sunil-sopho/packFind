// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:pack/models/package.dart' as _i13;
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
import 'package:pack/views/screens/splash/splash_screen.dart' as _i10;

class Routes extends _i11.RootStackRouter {
  Routes([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    Home.name: (routeData) {
      final args = routeData.argsAs<HomeArgs>(orElse: () => const HomeArgs());
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.Home(key: args.key));
    },
    LandHome.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LandHome());
    },
    QRGeneratorSharePage.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.QRGeneratorSharePage());
    },
    ScanQRPage.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.ScanQRPage());
    },
    MyHomePage.name: (routeData) {
      final args = routeData.argsAs<MyHomePageArgs>(
          orElse: () => const MyHomePageArgs());
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: _i5.MyHomePage(key: args.key));
    },
    InventoryPage.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.InventoryPage());
    },
    PackageFinder.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.PackageFinder());
    },
    Information.name: (routeData) {
      final args = routeData.argsAs<InformationArgs>();
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.Information(key: args.key, result: args.result));
    },
    PackageDetailScreen.name: (routeData) {
      final args = routeData.argsAs<PackageDetailScreenArgs>(
          orElse: () => const PackageDetailScreenArgs());
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i9.PackageDetailScreen(
              key: args.key, packageList: args.packageList));
    },
    SplashScreen.name: (routeData) {
      return _i11.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i10.SplashScreen());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(Home.name, path: '/'),
        _i11.RouteConfig(LandHome.name, path: '/land-home'),
        _i11.RouteConfig(QRGeneratorSharePage.name,
            path: '/q-rgenerator-share-page'),
        _i11.RouteConfig(ScanQRPage.name, path: '/scan-qr-page'),
        _i11.RouteConfig(MyHomePage.name, path: '/my-home-page'),
        _i11.RouteConfig(InventoryPage.name, path: '/inventory-page'),
        _i11.RouteConfig(PackageFinder.name, path: '/package-finder'),
        _i11.RouteConfig(Information.name, path: '/Information'),
        _i11.RouteConfig(PackageDetailScreen.name,
            path: '/package-detail-screen'),
        _i11.RouteConfig(SplashScreen.name, path: '/splash-screen')
      ];
}

/// generated route for
/// [_i1.Home]
class Home extends _i11.PageRouteInfo<HomeArgs> {
  Home({_i12.Key? key}) : super(Home.name, path: '/', args: HomeArgs(key: key));

  static const String name = 'Home';
}

class HomeArgs {
  const HomeArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'HomeArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LandHome]
class LandHome extends _i11.PageRouteInfo<void> {
  const LandHome() : super(LandHome.name, path: '/land-home');

  static const String name = 'LandHome';
}

/// generated route for
/// [_i3.QRGeneratorSharePage]
class QRGeneratorSharePage extends _i11.PageRouteInfo<void> {
  const QRGeneratorSharePage()
      : super(QRGeneratorSharePage.name, path: '/q-rgenerator-share-page');

  static const String name = 'QRGeneratorSharePage';
}

/// generated route for
/// [_i4.ScanQRPage]
class ScanQRPage extends _i11.PageRouteInfo<void> {
  const ScanQRPage() : super(ScanQRPage.name, path: '/scan-qr-page');

  static const String name = 'ScanQRPage';
}

/// generated route for
/// [_i5.MyHomePage]
class MyHomePage extends _i11.PageRouteInfo<MyHomePageArgs> {
  MyHomePage({_i12.Key? key})
      : super(MyHomePage.name,
            path: '/my-home-page', args: MyHomePageArgs(key: key));

  static const String name = 'MyHomePage';
}

class MyHomePageArgs {
  const MyHomePageArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'MyHomePageArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.InventoryPage]
class InventoryPage extends _i11.PageRouteInfo<void> {
  const InventoryPage() : super(InventoryPage.name, path: '/inventory-page');

  static const String name = 'InventoryPage';
}

/// generated route for
/// [_i7.PackageFinder]
class PackageFinder extends _i11.PageRouteInfo<void> {
  const PackageFinder() : super(PackageFinder.name, path: '/package-finder');

  static const String name = 'PackageFinder';
}

/// generated route for
/// [_i8.Information]
class Information extends _i11.PageRouteInfo<InformationArgs> {
  Information({_i12.Key? key, required String result})
      : super(Information.name,
            path: '/Information',
            args: InformationArgs(key: key, result: result));

  static const String name = 'Information';
}

class InformationArgs {
  const InformationArgs({this.key, required this.result});

  final _i12.Key? key;

  final String result;

  @override
  String toString() {
    return 'InformationArgs{key: $key, result: $result}';
  }
}

/// generated route for
/// [_i9.PackageDetailScreen]
class PackageDetailScreen extends _i11.PageRouteInfo<PackageDetailScreenArgs> {
  PackageDetailScreen({_i12.Key? key, _i13.Package? packageList})
      : super(PackageDetailScreen.name,
            path: '/package-detail-screen',
            args: PackageDetailScreenArgs(key: key, packageList: packageList));

  static const String name = 'PackageDetailScreen';
}

class PackageDetailScreenArgs {
  const PackageDetailScreenArgs({this.key, this.packageList});

  final _i12.Key? key;

  final _i13.Package? packageList;

  @override
  String toString() {
    return 'PackageDetailScreenArgs{key: $key, packageList: $packageList}';
  }
}

/// generated route for
/// [_i10.SplashScreen]
class SplashScreen extends _i11.PageRouteInfo<void> {
  const SplashScreen() : super(SplashScreen.name, path: '/splash-screen');

  static const String name = 'SplashScreen';
}
