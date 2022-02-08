import 'package:hive/hive.dart';
import 'package:pack/models/item.dart';
import 'package:pack/models/image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

const ITEM_COUNTER = "itemIdCounter";

final Box<Item> items = Hive.box('itemBox');
final counter = Hive.box('countBox');
// final Box<Img> images = Hive.box('imageBox');

void handleItem(Item item) async {
  final bool isPresent = items.containsKey(item.itemId);
  if (!isPresent) {
    items.put(item.itemId, item);
    incrementItemCounter();
    Fluttertoast.showToast(
      msg: 'Added new item',
      backgroundColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
    );
  } else {
    items.delete(item.itemId);
    items.put(item.itemId, item);
    Fluttertoast.showToast(
      msg: 'Updated item details',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}

void handleItemDelete(Item item) async {
  items.delete(item.itemId);
  // print(packages.length);

  Fluttertoast.showToast(
    msg: 'Deleted item details',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_SHORT,
  );
}

Item? getItemFromId(String itemId) {
  if (items.containsKey(itemId)) {
    return items.get(itemId);
  }
  return null;
}

int getItemCounter() {
  if (counter.containsKey(ITEM_COUNTER)) {
    return counter.get(ITEM_COUNTER);
  }
  return 0;
}

void incrementItemCounter() {
  if (counter.containsKey(ITEM_COUNTER)) {
    int val = counter.get(ITEM_COUNTER);
    counter.put(ITEM_COUNTER, val + 1);
  }
}

class ItemData {
  List _data = [];

//function to fetch the data
  ItemData() {
    for (var i = 0; i < items.length; i++) {
      _data.add(items.getAt(i));
    }
  }

  void update() {
    _data.clear();
    for (var i = 0; i < items.length; i++) {
      _data.add(items.getAt(i));
    }
  }

  String getId(int index) {
    return _data[index].itemId;
  }

  String getName(int index) {
    return _data[index].name;
  }

  String getPackageId(int index) {
    return _data[index].packageId;
  }

  String getDescription(int index) {
    return _data[index].description;
  }

  String getQunatity(int index) {
    return _data[index].quantity;
  }

  // Image getImage(int index) {
  //   if (_data[index].image != null && _data[index].image.length > 0) {
  //     return Utility.imageFromBase64String(_data[index].image[0]);
  //   }
  //   return Image.asset('assets/logo-0.png');
  // }

  int getLength() {
    return _data.length;
  }

  int length() {
    return _data.length;
  }

  List getData() {
    update();
    return _data;
  }
}

enum ItemDataAction { addItem, deleteItem, updateItem, init }

class ItemDataEvent {
  final ItemDataAction action;
  Item? data;

  ItemDataEvent(this.action, [this.data]);
}

class ItemDataBloc {
  late ItemData data;
  final _stateStreamController = StreamController<List>.broadcast();
  StreamSink<List> get dataSink => _stateStreamController.sink;
  Stream<List> get dataStream => _stateStreamController.stream;

  final _sizeStreamController = StreamController<int>.broadcast();
  StreamSink<int> get sizeSink => _sizeStreamController.sink;
  Stream<int> get sizeStream => _sizeStreamController.stream;

  final _eventStreamController = StreamController<ItemDataEvent>();
  StreamSink<ItemDataEvent> get eventSink => _eventStreamController.sink;
  Stream<ItemDataEvent> get eventStream => _eventStreamController.stream;

  ItemDataBloc() {
    data = ItemData();
    eventStream.listen((event) {
      if (event.action == ItemDataAction.init) {
        var allitems = data.getData();
        dataSink.add(allitems);
        sizeSink.add(data.getLength());
      } else if (event.action == ItemDataAction.addItem) {
        addItem(event.data);
        dataSink.add(data.getData());
        sizeSink.add(data.getLength());
      } else if (event.action == ItemDataAction.deleteItem) {
        deleteItem(event.data);
        var allpackages = data.getData();
        dataSink.add(allpackages);
        sizeSink.add(data.getLength());
      } else if (event.action == ItemDataAction.updateItem) {
        updateItem(event.data);
        var allpackages = data.getData();
        dataSink.add(allpackages);
        sizeSink.add(data.getLength());
      } else {
        dataSink.add(data.getData());
      }
    });
  }
  void addItem(newItem) {
    handleItem(newItem);
  }

  void deleteItem(item) {
    handleItemDelete(item);
  }

  void updateItem(newItem) {
    handleItem(newItem);
  }

  Item? getItem(String id) {
    return getItemFromId(id);
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
    _sizeStreamController.close();
  }
}
