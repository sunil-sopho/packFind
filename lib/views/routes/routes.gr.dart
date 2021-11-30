// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:pack/models/package.dart' as _i12;
import 'package:pack/views/screens/home.dart' as _i1;
import 'package:pack/views/screens/dashboard.dart' as _i6;
import 'package:pack/views/screens/landing.dart' as _i2;
import 'package:pack/views/screens/qr_generate/generate_qr.dart' as _i3;
import 'package:pack/views/screens/qr_generate/upload_image.dart' as _i5;
import 'package:pack/views/screens/scan/scan_qr.dart' as _i4;
import 'package:pack/views/screens/scan/scan_result.dart' as _i8;
import 'package:pack/views/screens/search_screen/item_detailed_result.dart'
    as _i9;
import 'package:pack/views/screens/search_screen/search.dart' as _i7;

class Routes extends _i10.RootStackRouter {
  Routes([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    Home.name: (routeData) {
      final args = routeData.argsAs<HomeArgs>(orElse: () => const HomeArgs());
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.Home(key: args.key));
    },
    LandHome.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LandHome());
    },
    QRGeneratorSharePage.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.QRGeneratorSharePage());
    },
    ScanQRPage.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.ScanQRPage());
    },
    MyHomePage.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: _i5.MyHomePage());
    },
    InventoryPage.name: (routeData) {
      final args = routeData.argsAs<InventoryPageArgs>(
          orElse: () => const InventoryPageArgs());
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: _i6.InventoryPage(key: args.key));
    },
    PackageFinder.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.PackageFinder());
    },
    Information.name: (routeData) {
      final args = routeData.argsAs<InformationArgs>();
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.Information(key: args.key, result: args.result));
    },
    PackageDetailScreen.name: (routeData) {
      final args = routeData.argsAs<PackageDetailScreenArgs>();
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i9.PackageDetailScreen(
              key: args.key, packageList: args.packageList));
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(Home.name, path: '/'),
        _i10.RouteConfig(LandHome.name, path: '/land-home'),
        _i10.RouteConfig(QRGeneratorSharePage.name,
            path: '/q-rgenerator-share-page'),
        _i10.RouteConfig(ScanQRPage.name, path: '/scan-qr-page'),
        _i10.RouteConfig(MyHomePage.name, path: '/my-home-page'),
        _i10.RouteConfig(InventoryPage.name, path: '/inventory-page'),
        _i10.RouteConfig(PackageFinder.name, path: '/package-finder'),
        _i10.RouteConfig(Information.name, path: '/Information'),
        _i10.RouteConfig(PackageDetailScreen.name,
            path: '/package-detail-screen')
      ];
}

/// generated route for [_i1.Home]
class Home extends _i10.PageRouteInfo<HomeArgs> {
  Home({_i11.Key? key}) : super(name, path: '/', args: HomeArgs(key: key));

  static const String name = 'Home';
}

class HomeArgs {
  const HomeArgs({this.key});

  final _i11.Key? key;
}

/// generated route for [_i2.LandHome]
class LandHome extends _i10.PageRouteInfo<void> {
  const LandHome() : super(name, path: '/land-home');

  static const String name = 'LandHome';
}

/// generated route for [_i3.QRGeneratorSharePage]
class QRGeneratorSharePage extends _i10.PageRouteInfo<void> {
  const QRGeneratorSharePage() : super(name, path: '/q-rgenerator-share-page');

  static const String name = 'QRGeneratorSharePage';
}

/// generated route for [_i4.ScanQRPage]
class ScanQRPage extends _i10.PageRouteInfo<void> {
  const ScanQRPage() : super(name, path: '/scan-qr-page');

  static const String name = 'ScanQRPage';
}

/// generated route for [_i5.MyHomePage]
class MyHomePage extends _i10.PageRouteInfo<void> {
  const MyHomePage() : super(name, path: '/my-home-page');

  static const String name = 'MyHomePage';
}

/// generated route for [_i6.InventoryPage]
class InventoryPage extends _i10.PageRouteInfo<InventoryPageArgs> {
  InventoryPage({_i11.Key? key})
      : super(name, path: '/inventory-page', args: InventoryPageArgs(key: key));

  static const String name = 'InventoryPage';
}

class InventoryPageArgs {
  const InventoryPageArgs({this.key});

  final _i11.Key? key;
}

/// generated route for [_i7.PackageFinder]
class PackageFinder extends _i10.PageRouteInfo<void> {
  const PackageFinder() : super(name, path: '/package-finder');

  static const String name = 'PackageFinder';
}

/// generated route for [_i8.Information]
class Information extends _i10.PageRouteInfo<InformationArgs> {
  Information({_i11.Key? key, required String result})
      : super(name,
            path: '/Information',
            args: InformationArgs(key: key, result: result));

  static const String name = 'Information';
}

class InformationArgs {
  const InformationArgs({this.key, required this.result});

  final _i11.Key? key;

  final String result;
}

/// generated route for [_i9.PackageDetailScreen]
class PackageDetailScreen extends _i10.PageRouteInfo<PackageDetailScreenArgs> {
  PackageDetailScreen({_i11.Key? key, required _i12.Package packageList})
      : super(name,
            path: '/package-detail-screen',
            args: PackageDetailScreenArgs(key: key, packageList: packageList));

  static const String name = 'PackageDetailScreen';
}

class PackageDetailScreenArgs {
  const PackageDetailScreenArgs({this.key, required this.packageList});

  final _i11.Key? key;

  final _i12.Package packageList;
}