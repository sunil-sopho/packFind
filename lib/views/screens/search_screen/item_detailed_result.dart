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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'List of instructions:  ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  packageList.itemList,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Location is  :  ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  packageList.location,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
              decoration: const BoxDecoration(color: Colors.grey),
              child: _data.getImage(int.parse(packageList.packageId) - 1),
            )
          ],
        ),
      ),
    );
  }
}
