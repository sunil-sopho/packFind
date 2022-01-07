import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';
import 'package:get_it/get_it.dart';
import 'package:pack/controllers/services/package_handler.dart';

// void main() {
//   runApp(MyApp());
// }
List getInfo = [
  [1, 'pen1,pencil,brush', 'assets/logo-1.png'],
  [2, 'pen2,pencil,brush', 'assets/logo-1.png'],
  [3, 'pen3,pencil,brush', 'assets/logo-1.png'],
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
  final int selectedIndex = 2;
  late QRViewController controller;
  Barcode? result;
  final dataBloc = GetIt.instance<DataBloc>();
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
        title: const Text('Scan QR Code'),
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
                              // context.router.push(Information(result: result!.code));
                              context.router.push(PackageDetailScreen(
                                  packageList:
                                      dataBloc.getPackage(result!.code)));
                            },
                            child: const Text('get result'),
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
      bottomNavigationBar: BottomNavigator(
        selectedIndex: selectedIndex,
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

void onFinalResult(result) {}
