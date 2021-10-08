import 'package:hive/hive.dart';
import 'package:pack/models/package.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';

final Box<Package> packages = Hive.box('packageBox');
final counter = Hive.box('countBox');

void handlePackage(Package package) async {
  final bool isPresent = packages.containsKey(package.packageId);
  print(package.packageId);
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
