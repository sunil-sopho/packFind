import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:pack/models/package.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(MyApp());
// }
List getInfo = [
  [1, 'pen1,pencil,brush', 'assets/img-home1.jpeg'],
  [2, 'pen2,pencil,brush', 'assets/img-home1.jpeg'],
  [3, 'pen3,pencil,brush', 'assets/img-home1.jpeg'],
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScanQRPage(),
    );
  }
}

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({Key? key}) : super(key: key);
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Barcode? result;

//in order to get hot reload to work.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: onQRViewCreated,
                  overlay: QrScannerOverlayShape(
//customizing scan area
                    borderWidth: 10,
                    borderColor: Colors.teal,
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await controller.flipCamera();
                            }),
                        IconButton(
                            icon: const Icon(
                              Icons.flash_on,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await controller.toggleFlash();
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: result != null
                    ? Column(
                        children: [
                          Text('Result is:\n${result!.code}'),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Information(
                                      result: result!.code,
                                    ),
                                  ));
                            },
                            child: Text('get result'),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      )
                    : const Text('Scanning.....'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController p1) {
//called when View gets created.
    this.controller = p1;
    controller.scannedDataStream.listen((scanevent) {
      setState(() {
//UI gets created with new QR code.
        result = scanevent;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

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
        title: Text('Found your Package'),
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

void onFinalResult(result) {}
