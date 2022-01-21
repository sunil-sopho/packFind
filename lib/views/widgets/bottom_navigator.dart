import 'package:flutter/material.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:pack/views/screens/home.dart';
import 'package:pack/views/screens/dashboard.dart';
import 'package:pack/views/screens/landing.dart';
import 'package:pack/views/screens/qr_generate/generate_qr.dart';
import 'package:pack/views/screens/qr_generate/upload_image.dart';
import 'package:pack/views/screens/scan/scan_qr.dart';
import 'package:pack/views/screens/scan/scan_result.dart';
import 'package:pack/views/screens/package_detail_screen/package_detail_screen.dart';
import 'package:pack/views/screens/search_screen/search.dart';

class BottomNavigator extends StatefulWidget {
  var selectedIndex;
  BottomNavigator({Key? key, required this.selectedIndex}) : super(key: key);
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState(selectedIndex);
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  _BottomNavigatorState(int selectedIndex) {
    _selectedIndex = selectedIndex;
  }

  void _onItemTapped(int index) {
    if (index == 0 && _selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const InventoryPage()),
      // );
      context.router.pushNamed('/inventory-page');
    } else if (index == 1 && _selectedIndex != 1) {
      setState(() {
        _selectedIndex = 1;
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const QRGeneratorSharePage()),
      // );
      context.router.pushNamed('/q-rgenerator-share-page');
    } else if (index == 2 && _selectedIndex != 2) {
      setState(() {
        _selectedIndex = 2;
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const PackageFinder()),
      // );
      context.router.pushNamed('/package-finder');
    } else if (index == 3 && _selectedIndex != 3) {
      setState(() {
        _selectedIndex = 3;
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const PackageFinder()),
      // );
      context.router.pushNamed('/settings-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white, //Color(0xFF6200EE),
      selectedItemColor: Colors.orange, //Color(0xFF6200EE)
      unselectedItemColor: Colors.orange.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.home,
            size: 35,
          ),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(
            Icons.add_circle,
            size: 35,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.search,
            size: 35,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.account_circle,
            size: 35,
          ),
        ),
      ],
    ));
  }
}
