import 'package:hive/hive.dart';
import 'package:pack/models/package.dart';
import 'package:pack/models/image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:convert';

final Box<Package> packages = Hive.box('packageBox');
final counter = Hive.box('countBox');
final Box<Img> images = Hive.box('imageBox');

void handlePackage(Package package) async {
  final bool isPresent = packages.containsKey(package.packageId);
  if (!isPresent) {
    packages.put(package.packageId, package);
    // print(packages.length);
    Fluttertoast.showToast(
      msg: 'Added new package',
      backgroundColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
    );
  } else {
    packages.delete(package.packageId);
    packages.put(package.packageId, package);
    // print(packages.length);

    Fluttertoast.showToast(
      msg: 'Updated package details',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}

Package? getPackageFromId(String id) {
  if (packages.containsKey(id)) {
    return packages.get(id);
  }
  return null;
}

class Utility {
  static Image imageFromBase64String(String? base64String) {
    if (base64String == null) {
      return Image.memory(base64Decode("aaaa"));
    }
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

int getCounter() {
  if (counter.containsKey('idCounter')) {
    return counter.get('idCounter');
  }
  return 0;
}

void incrementCounter() {
  if (counter.containsKey('idCounter')) {
    int val = counter.get('idCounter');
    counter.put('idCounter', val + 1);
  }
}

void addImages(List<XFile>? allImages) {
  allImages?.forEach((image) {
    image.readAsBytes().then((value) {
      String imgString = Utility.base64String(value);
      images.add(Img(img: imgString));
    });
  });
}

void clearImages() {
  for (var i = 0; i < images.length; i++) {
    images.deleteAt(i);
  }
}

List<Image> getImages() {
  var _list = <Image>[];
  for (var i = 0; i < images.length; i++) {
    _list.add(Utility.imageFromBase64String(images.getAt(i)?.img));
  }
  return _list;
}

List<String> getImageStrings() {
  var _list = <String>[];
  for (var i = 0; i < images.length; i++) {
    _list.add(images.getAt(i)?.img);
  }
  return _list;
}

class Data {
  List _data = [];

//function to fetch the data

  Data() {
    for (var i = 0; i < packages.length; i++) {
      _data.add(packages.getAt(i));
    }
  }

  void update() {
    _data.clear();
    for (var i = 0; i < packages.length; i++) {
      _data.add(packages.getAt(i));
    }
  }

  String getId(int index) {
    return _data[index].packageId;
  }

  String getName(int index) {
    return _data[index].uid;
  }

  String getItemList(int index) {
    return _data[index].itemList;
  }

  String getLocation(int index) {
    return _data[index].location;
  }

  Image getImage(int index) {
    if (_data[index].image != null && _data[index].image != "") {
      print(_data[index].image);
      return Utility.imageFromBase64String(_data[index].image);
    }
    return Image.asset('assets/logo-0.png');
  }

  int getLength() {
    return _data.length;
  }
}


// void addArticlesToUnreads(List<Articles> articles) async {
//   articles.forEach((element) {
//     if (!unreadsBox.containsKey(element.url)) {
//       unreadsBox.put(element.url, element);
//       print('added' + "${unreadsBox.length}");
//     }
//   });
// }

// void removeArticleFromUnreads(Articles articles) {
//   if (unreadsBox.containsKey(articles.url)) {
//     unreadsBox.delete(articles.url);
//     print('removed' + "${unreadsBox.length}");
//   }
// }
