import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pack/models/package.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QRGeneratorSharePage(),
    );
  }
}

class QRGeneratorSharePage extends StatefulWidget {
  const QRGeneratorSharePage({Key? key}) : super(key: key);

  @override
  _QRGeneratorSharePageState createState() => _QRGeneratorSharePageState();
}

class _QRGeneratorSharePageState extends State<QRGeneratorSharePage> {
  final key = GlobalKey();
  String textdata = 'enter data';
  final int selectedIndex = 1;
  final dynamic _packageId =
      TextEditingController(text: getCounter().toString());
  // _packageId.text = getCounter();
  final _itemList = TextEditingController();
  final _location = TextEditingController();
  File? file;
  final List<Image> _imageList = [];
  final List<String> _imageStringList = [];

  var userID = '1';
  void updatePackageId() {
    incrementCounter();
    _packageId.text = getCounter().toString();
  }

  void updateImageList() {
    List _list = getImages();
    for (int i = 0; i < _list.length; i++) {
      _imageList.add(_list[i]);
    }
    print("Length : " + _list.length.toString());
  }

  void updateImageStringList() {
    List _list = getImageStrings();
    for (int i = 0; i < _list.length; i++) {
      _imageStringList.add(_list[i]);
    }
    // print("Length : " + _list.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    updateImageList();
    updateImageStringList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Column(
        children: [
          RepaintBoundary(
            key: key,
            child: Container(
              color: Colors.white,
              child: QrImage(
                size: 200, //size of the QrImage widget.
                data: textdata, //textdata used to create QR code
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              enabled: false,
              decoration: const InputDecoration(labelText: 'Package id'),
              controller: _packageId,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'List of items',
              ),
              controller: _itemList,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Location of packaging',
              ),
              controller: _location,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: _imageList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _imageList[index],
                    );
                  }),
            ),
          ),
          Row(children: [
            SizedBox(
              width: 150,
              child: OutlinedButton(
                  onPressed: () {
                    clearImages();
                    context.router.push(const MyHomePage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.camera_alt,
                        size: 20.0,
                      ),
                      Text('Add image'),
                    ],
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )))),
            ),
            OutlinedButton(
                child: const Text('Save Package'),
                onPressed: () async {
                  setState(() {
//rebuilds UI with new QR code

                    textdata = _packageId.text;
                  });
                  updateImageList();
                  updateImageStringList();
                  // clearImages();
                  dynamic imgpath = null;
                  if (_imageStringList.length > 0) {
                    imgpath = _imageStringList[0];
                  }
                  Package newpackage = Package(
                    packageId: _packageId.text,
                    uid: userID,
                    itemList: _itemList.text,
                    location: _location.text,
                    image: imgpath,
                  );
                  // print(" : : " + _packageId.text);
                  // print(newpackage.packageId);
                  handlePackage(newpackage);
                  updatePackageId();
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )))),
            OutlinedButton(
                child: const Text('Share'),
                onPressed: () async {
                  try {
                    RenderRepaintBoundary boundary = key.currentContext!
                        .findRenderObject() as RenderRepaintBoundary;
//captures qr image
                    var image = await boundary.toImage();

                    ByteData? byteData =
                        await image.toByteData(format: ImageByteFormat.png);

                    Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
                    final appDir = await getApplicationDocumentsDirectory();
//current time
                    var datetime = DateTime.now();
//qr image file creation
                    file = await File('${appDir.path}/$datetime.png').create();
//appending data
                    await file?.writeAsBytes(pngBytes);
//Shares QR image
                    await Share.shareFiles(
                      [file!.path],
                      mimeTypes: ["image/png"],
                      text: "Share the QR Code",
                    );
                  } catch (e) {
                    print(e.toString());
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))))
          ])
        ],
      ),
      bottomNavigationBar: BottomNavigator(
        selectedIndex: selectedIndex,
      ),
    );
  }
}
