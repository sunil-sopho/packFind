import 'package:flutter/material.dart';
import 'package:pack/models/package.dart';
import 'package:pack/controllers/services/package_handler.dart';

class PackageDetailScreen extends StatelessWidget {
  final Package packageList;
  PackageDetailScreen({Key? key, required this.packageList}) : super(key: key);
  final _data = Data();

  get abc => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text("List of items:  " + packageList.itemList),
            Text("Location is  :  " + packageList.location),
            const SizedBox(
              height: 10,
            ),
            _data.getImage(int.parse(packageList.packageId) - 1),
          ],
        ),
      ),
    );
  }
}
