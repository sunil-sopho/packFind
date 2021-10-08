import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:hive/hive.dart';
import 'camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Code Generator With Share',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRGeneratorSharePage(),
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
  final textcontroller = TextEditingController();
  final textcontroller2 = TextEditingController();
  final textcontroller3 = TextEditingController();
  File? file;
  var box = Hive.box('packages');
  var userID = '1';
  var counter = Hive.box('count');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('QR Code Generator'),
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
              decoration: const InputDecoration(labelText: 'Package id'),
              controller: textcontroller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'List of items',
              ),
              controller: textcontroller2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Location of packaging',
              ),
              controller: textcontroller3,
            ),
          ),
          SizedBox(
            width: 150,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Camera');
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
              child: Text('Create QR Code'),
              onPressed: () async {
                setState(() {
//rebuilds UI with new QR code
                  textdata = textcontroller.text;
                });
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
          OutlinedButton(
              child: Text('Share'),
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
        ],
      ),
    );
  }
}