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

import 'package:get_it/get_it.dart';

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
  String textdata = getCounter().toString();
  final dataBloc = GetIt.instance<DataBloc>();
  final imageBloc = GetIt.instance<ImageBloc>();

  final int selectedIndex = 1;
  final dynamic _packageId =
      TextEditingController(text: getCounter().toString());
  // _packageId.text = getCounter();
  final _itemList = TextEditingController();
  final _location = TextEditingController();
  File? file;

  var userID = '1';
  void updatePackageId() {
    _packageId.text = getCounter().toString();
  }

  @override
  void dispose() {
    // imageBloc.dispose();
    // dataBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dataBloc.eventSink.add(DataEvent(DataAction.init));
    imageBloc.eventSink.add(ImageEvent(ImageAction.init));

    super.initState();
  }
  // void updateImageList() {
  //   List _list = getImages();
  //   for (int i = 0; i < _list.length; i++) {
  //     _imageList.add(_list[i]);
  //   }
  //   print("Length : " + _list.length.toString());
  // }

  // void updateImageStringList() {
  //   List _list = getImageStrings();
  //   for (int i = 0; i < _list.length; i++) {
  //     _imageStringList.add(_list[i]);
  //   }
  //   // print("Length : " + _list.length.toString());
  // }

  @override
  Widget build(BuildContext context) {
    // updateImageList();
    // updateImageStringList();
    print("build qr page");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const LogoWidget(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(
              child: TextFormField(
                enabled: false,
                decoration: const InputDecoration(labelText: 'Package id'),
                controller: _packageId,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            // QrCodeWidget(textdata: textdata),
            GestureDetector(
                child: Hero(
                  tag: 'package_qrcode',
                  child: RepaintBoundary(
                    key: key,
                    child: Container(
                      color: Colors.white,
                      child: QrImage(
                        size: 70, //size of the QrImage widget.
                        data: textdata, //textdata used to create QR code
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailScreen(qrdata: textdata);
                  }));
                })
          ]),
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
              child: StreamBuilder<List>(
                  stream: imageBloc.dataStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: Text("Loading"));
                    } else if (snapshot.hasError) {
                      print("error");
                      return const Text("Error");
                    } else {
                      print("making grid");
                      print(snapshot.data);
                      return GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: snapshot.data![index],
                            );
                          });
                    }
                  }),
            ),
          ),
          Row(children: [
            SizedBox(
              width: 150,
              child: OutlinedButton(
                  onPressed: () {
                    context.router.push(MyHomePage());
                  },
                  child: const AddImagebutton(),
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
                  // updateImageList();
                  // updateImageStringList();
                  // clearImages();
                  dynamic imgList = imageBloc.getImageStringList();
                  Package newpackage = Package(
                    packageId: _packageId.text,
                    uid: userID,
                    itemList: _itemList.text,
                    location: _location.text,
                    image: imgList,
                  );
                  // print(" : : " + _packageId.text);
                  // print(newpackage.packageId);
                  dataBloc.eventSink
                      .add(DataEvent(DataAction.addPackage, newpackage));
                  imageBloc.eventSink.add(ImageEvent(ImageAction.clearImages));

                  Navigator.pop(context);
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
                    print("step 1");
                    ByteData? byteData =
                        await image.toByteData(format: ImageByteFormat.png);
                    print("step 2");

                    Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
                    final appDir = await getApplicationDocumentsDirectory();
                    print("step 3");
//current time
                    var datetime = DateTime.now();
//qr image file creation
                    file = await File('${appDir.path}/$datetime.png').create();
                    print("step 4");
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

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, this.qrdata = ""}) : super(key: key);
  final String qrdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'package_qrcode',
            child: QrImage(
              size: 300, //size of the QrImage widget.
              data: qrdata, //textdata used to create QR code
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/packFND_3_logo.png',
      width: 180,
      height: 170,
    );
  }
}

class AddImagebutton extends StatelessWidget {
  const AddImagebutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.camera_alt,
          size: 20.0,
        ),
        Text('Add image'),
      ],
    );
  }
}

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({Key? key, this.textdata}) : super(key: key);
  final textdata;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Hero(
          tag: 'package_qrcode',
          child: RepaintBoundary(
            key: key,
            child: Container(
              color: Colors.white,
              child: QrImage(
                size: 70, //size of the QrImage widget.
                data: textdata, //textdata used to create QR code
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen(qrdata: textdata);
          }));
        });
  }
}
