import 'package:auto_route/auto_route.dart';
import 'package:pack/views/screens/home.dart';
import 'package:pack/views/screens/dashboard.dart';
import 'package:pack/views/screens/landing.dart';
import 'package:pack/views/screens/qr_generate/generate_qr.dart';
import 'package:pack/views/screens/qr_generate/upload_image.dart';
import 'package:pack/views/screens/scan/scan_qr.dart';
import 'package:pack/views/screens/scan/scan_result.dart';
import 'package:pack/views/screens/package_detail_screen/package_detail_screen.dart';
import 'package:pack/views/screens/search_screen/search.dart';
import 'package:pack/views/screens/splash/splash_screen.dart';

@AdaptiveAutoRouter(replaceInRouteName: 'Route,Page', routes: <AutoRoute>[
  AutoRoute(page: Home, initial: true),
  AutoRoute(page: LandHome),
  AutoRoute(page: QRGeneratorSharePage),
  AutoRoute(page: ScanQRPage),
  AutoRoute(page: MyHomePage),
  AutoRoute(page: InventoryPage),
  AutoRoute(page: PackageFinder),
  AutoRoute(page: Information),
  AutoRoute(page: PackageDetailScreen),
  AutoRoute(page: SplashScreen),
])
class $Routes {}
