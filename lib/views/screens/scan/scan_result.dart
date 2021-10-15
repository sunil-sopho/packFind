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
      img = Image.asset('assets/img-home1.jpeg');
    } else {
      item = p.itemList;
      packId = p.packageId;
      img = Utility.imageFromBase64String(p.image);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Found your Package'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Package_id: $packId'),
              Text('Items : $item'),
              img,
            ],
          ),
        ],
      ),
    );
  }
}
