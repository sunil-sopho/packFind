import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';
import 'package:pack/views/routes/routes.gr.dart';

class LandHome extends StatelessWidget {
  const LandHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Qr code"),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                context.router.push(const ScanQRPage());
              },
              child: const Text('Scan it to Find it'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
          ElevatedButton(
              onPressed: () {
                context.router.push(QRGeneratorSharePage());
              },
              child: const Text('Create inventory'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
          ElevatedButton(
              onPressed: () {
                context.router.push(const PackageFinder());
              },
              child: const Text('Find inventory'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
          ElevatedButton(
              onPressed: () {
                context.router.push(InventoryPage());
              },
              child: const Text('all inventory'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
        ]),
      ]),
      bottomNavigationBar: BottomNavigator(
        selectedIndex: 0,
      ),
    );
  }
}
