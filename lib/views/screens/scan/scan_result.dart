import 'package:flutter/material.dart';
import 'package:pack/models/package.dart';
import 'package:pack/controllers/services/package_handler.dart';

class Information extends StatelessWidget {
  final String result;
  const Information({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String item, packId, imgString;
    Image img;
    Package? p = getPackageFromId(result);
    if (p == null) {
      item = "";
      packId = "";
      img = Image.asset('assets/logo-1.png');
    } else {
      item = p.itemList;
      packId = p.packageId;
      // img = Utility.imageFromBase64String(p.image[0]);
      img = Image.asset('assets/logo-1.png');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Found your Package'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Package_id:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  packId,
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
                  'Items : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  item,
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
              child: img,
            )
          ],
        ),
      ),
    );
  }
}
