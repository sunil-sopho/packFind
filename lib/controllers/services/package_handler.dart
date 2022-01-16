import 'package:hive/hive.dart';
import 'package:pack/models/package.dart';
import 'package:pack/models/image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
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
    incrementCounter();

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

void handleDelete(Package package) async {
  packages.delete(package.packageId);
  // print(packages.length);

  Fluttertoast.showToast(
    msg: 'Deleted package details',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_SHORT,
  );
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

void addImages(List<XFile>? allImages) async {
  allImages?.forEach((image) {
    image.readAsBytes().then((value) {
      String imgString = Utility.base64String(value);
      images.add(Img(img: imgString));
    });
  });
}

void addStringImages(List<String>? allImages) async {
  allImages?.forEach((imgString) {
    images.add(Img(img: imgString));
  });
}

void clearImages() {
  int numImages = images.length;
  for (var i = 1; i <= numImages; i++) {
    images.deleteAt(numImages - i);
  }
}

void deleteImage(int index) {
  int numImages = images.length;
  if (index < 0 || index >= numImages) {
    return;
  }
  images.deleteAt(index);
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

List<Image> getImagesfromStringList(List<String> images) {
  List<Image> _list = [];
  if (images.isNotEmpty) {
    for (int i = 0; i < images.length; i++) {
      _list.add(Utility.imageFromBase64String(images[i]));
    }
    return _list;
  }
  _list.add(Image.asset('assets/logo-0.png'));
  return _list;
}

List<Image> getImagesfromStringListForEditing(List<String> images) {
  List<Image> _list = [];
  if (images.isNotEmpty) {
    for (int i = 0; i < images.length; i++) {
      _list.add(Utility.imageFromBase64String(images[i]));
    }
  }
  return _list;
}

enum DataAction { addPackage, deletePackage, updatePackage, init }

class DataEvent {
  final DataAction action;
  Package? data;

  DataEvent(this.action, [this.data]);
}

class DataBloc {
  late Data data;
  int items = 0;
  final _stateStreamController = StreamController<List>.broadcast();
  StreamSink<List> get dataSink => _stateStreamController.sink;
  Stream<List> get dataStream => _stateStreamController.stream;

  final _sizeStreamController = StreamController<int>.broadcast();
  StreamSink<int> get sizeSink => _sizeStreamController.sink;
  Stream<int> get sizeStream => _sizeStreamController.stream;

  final _itemStreamController = StreamController<int>.broadcast();
  StreamSink<int> get itemSink => _itemStreamController.sink;
  Stream<int> get itemStream => _itemStreamController.stream;

  final _eventStreamController = StreamController<DataEvent>();
  StreamSink<DataEvent> get eventSink => _eventStreamController.sink;
  Stream<DataEvent> get eventStream => _eventStreamController.stream;

  DataBloc() {
    data = Data();
    eventStream.listen((event) {
      print(event);
      if (event.action == DataAction.init) {
        var allpackages = data.getData();
        dataSink.add(allpackages);
        updateItemCount(allpackages);
        sizeSink.add(data.getLength());
        itemSink.add(items);
      } else if (event.action == DataAction.addPackage) {
        addPackage(event.data);
        addItemsFromPackage(event.data);
        dataSink.add(data.getData());
        sizeSink.add(data.getLength());
        itemSink.add(items);
      } else if (event.action == DataAction.deletePackage) {
        deletePackage(event.data);
        var allpackages = data.getData();
        updateItemCount(allpackages);
        dataSink.add(allpackages);
        sizeSink.add(data.getLength());
        itemSink.add(items);
      } else if (event.action == DataAction.updatePackage) {
        updatePackage(event.data);
        var allpackages = data.getData();
        updateItemCount(allpackages);
        dataSink.add(allpackages);
        sizeSink.add(data.getLength());
        itemSink.add(items);
      } else {
        dataSink.add(data.getData());
      }
    });
  }
  void addPackage(newPackage) {
    handlePackage(newPackage);
  }

  void deletePackage(package) {
    handleDelete(package);
  }

  void updatePackage(newPackage) {
    handlePackage(newPackage);
  }

  Package? getPackage(String id) {
    return getPackageFromId(id);
  }

  void updateItemCount(List packages) {
    items = 0;
    for (int i = 0; i < packages.length; i++) {
      if (packages[i].itemList != "") {
        items += (",").allMatches(packages[i].itemList).length;
        items += (" ").allMatches(packages[i].itemList).length;
        items += 1;
      }
    }
  }

  void addItemsFromPackage(Package? package) {
    if (package?.itemList != "") {
      items += (",").allMatches(package?.itemList).length;
      items += (" ").allMatches(package?.itemList).length;
      items += 1;
    }
  }

  void dispose() {
    _itemStreamController.close();
    _stateStreamController.close();
    _eventStreamController.close();
    _sizeStreamController.close();
  }
}

enum ImageAction {
  addImage,
  deleteImage,
  addImages,
  init,
  clearImages,
  addStringImages
}

// enum ImageActionData { List<XFile>?,List<int>?}

class ImageEvent {
  final ImageAction action;
  List<XFile>? data = [];
  int? deleteIndex = 0;
  List<String>? stringImages = [];
  ImageEvent(this.action, [this.data, this.deleteIndex, this.stringImages]);
}

class ImageBloc {
  final _stateStreamController = StreamController<List>.broadcast();
  StreamSink<List> get dataSink => _stateStreamController.sink;
  Stream<List> get dataStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<ImageEvent>();
  StreamSink<ImageEvent> get eventSink => _eventStreamController.sink;
  Stream<ImageEvent> get eventStream => _eventStreamController.stream;

  ImageBloc() {
    eventStream.listen((event) {
      print(event.action);
      print(event.deleteIndex);
      if (event.action == ImageAction.init) {
        List imageList = updateImageList();
        dataSink.add(imageList);
      } else if (event.action == ImageAction.addImages) {
        print(event.data);
        updateImageList2(event.data);
        addImages(event.data);

        // print("data sink added");
        // print(imageList);
        // dataSink.add(imageList);
      } else if (event.action == ImageAction.clearImages) {
        clear();
      } else if (event.action == ImageAction.deleteImage) {
        print(event.deleteIndex);
        handleDelete(event.deleteIndex);
      } else if (event.action == ImageAction.addStringImages) {
        addStringImages(event.stringImages);
      }
    });
  }

  List updateImageList() {
    List _list = getImages();
    return _list;
  }

  void handleDelete(int? index) {
    if (index == null) return;
    print(index);
    deleteImage(index);
    eventSink.add(ImageEvent(ImageAction.init));
  }

  void updateImageList2(data) async {
    List _list = getImages();
    // data?.forEach((image) {
    for (int i = 0; i < data.length; i++) {
      var img = data[i];
      // var img_bytes = await img.readAsBytes();
      img = Image.file(
        File(img.path),
        fit: BoxFit.cover,
      );
      // var img = img.decodeImage(img_bytes);
      _list.add(img);
    }
    ;
    print("data sink added");
    print(_list);
    dataSink.add(_list);
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
