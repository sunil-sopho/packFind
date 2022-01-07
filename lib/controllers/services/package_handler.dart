import 'package:hive/hive.dart';
import 'package:pack/models/package.dart';
import 'package:pack/models/image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';

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
  int numImages = images.length;
  for (var i = 1; i <= numImages; i++) {
    images.deleteAt(numImages - i);
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
    if (_data[index].image != null && _data[index].image.length > 0) {
      print(_data[index].image.length);
      return Utility.imageFromBase64String(_data[index].image[0]);
    }
    return Image.asset('assets/logo-0.png');
  }

  List<Image> getImages(int index) {
    List<Image> _list = [];
    if (_data[index].image != null && _data[index].image.length > 0) {
      for (int i = 0; i < _data[index].image.length; i++) {
        _list.add(Utility.imageFromBase64String(_data[index].image[i]));
      }
      return _list;
    }
    _list.add(Image.asset('assets/logo-0.png'));
    return _list;
  }

  int getLength() {
    return _data.length;
  }

  int length() {
    return _data.length;
  }

  List getData() {
    update();
    print("data returned");
    print(_data);
    return _data;
  }
}

enum DataAction { addPackage, deletePackage, updatePackage, init }

class DataEvent {
  final DataAction action;
  Package? data;

  DataEvent(this.action, [this.data]);
}

class DataBloc {
  late Data data;

  final _stateStreamController = StreamController<List>.broadcast();
  StreamSink<List> get dataSink => _stateStreamController.sink;
  Stream<List> get dataStream => _stateStreamController.stream;

  final _sizeStreamController = StreamController<int>.broadcast();
  StreamSink<int> get sizeSink => _sizeStreamController.sink;
  Stream<int> get sizeStream => _sizeStreamController.stream;

  final _eventStreamController = StreamController<DataEvent>();
  StreamSink<DataEvent> get eventSink => _eventStreamController.sink;
  Stream<DataEvent> get eventStream => _eventStreamController.stream;

  DataBloc() {
    data = Data();
    eventStream.listen((event) {
      print(event);
      if (event.action == DataAction.init) {
        dataSink.add(data.getData());
        sizeSink.add(data.getLength());
      } else if (event.action == DataAction.addPackage ||
          event.action == DataAction.deletePackage) {
        if (event.action == DataAction.addPackage) {
          addPackage(event.data);
        }
        dataSink.add(data.getData());
        sizeSink.add(data.getLength());
      } else {
        dataSink.add(data.getData());
      }
    });
  }
  void addPackage(newPackage) {
    print("adding package ");
    print(newPackage);
    handlePackage(newPackage);
    incrementCounter();
  }

  Package? getPackage(String id) {
    return getPackageFromId(id);
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
    _sizeStreamController.close();
  }
}

enum ImageAction { addImage, deleteImage, addImages, init, clearImages }

class ImageEvent {
  final ImageAction action;
  List<XFile>? data = [];

  ImageEvent(this.action, [this.data]);
}

class ImageBloc {
  final List<Image> _imageList = [];
  final List<String> _imageStringList = [];

  final _stateStreamController = StreamController<List>.broadcast();
  StreamSink<List> get dataSink => _stateStreamController.sink;
  Stream<List> get dataStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<ImageEvent>();
  StreamSink<ImageEvent> get eventSink => _eventStreamController.sink;
  Stream<ImageEvent> get eventStream => _eventStreamController.stream;

  ImageBloc() {
    eventStream.listen((event) {
      print(event);
      if (event.action == ImageAction.init) {
        var imageList = updateImageList();
        dataSink.add(imageList);
      } else if (event.action == ImageAction.addImages) {
        print(event.data);
        addImages(event.data);
        var imageList = updateImageList();
        dataSink.add(imageList);
      } else if (event.action == ImageAction.clearImages) {
        clear();
      }
    });
  }

  List updateImageList() {
    List _list = getImages();
    return _list;
  }

  List<String> getImageStringList() {
    return getImageStrings();
    // print("Length : " + _list.length.toString());
  }

  void clear() {
    clearImages();
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
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
