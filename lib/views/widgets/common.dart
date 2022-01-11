// contains common widgets used

// inserts logo
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pack/config/constants.dart';
import 'package:pack/controllers/utils.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key, this.width = 210, this.height = 220})
      : super(key: key);
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/packFND_3_logo.png',
      width: width,
      height: height,
    );
  }
}

class QrCodeTrailing extends StatelessWidget {
  const QrCodeTrailing({Key? key, required this.textdata, required this.size})
      : super(key: key);
  final String textdata;
  final double size;
  @override
  Widget build(BuildContext context) {
    return QrImage(
      size: size, //size of the QrImage widget.
      data: textdata,
      //textdata used to create QR code
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
                data: textdata,
                // gapless: false,
                // embeddedImage: const AssetImage(
                //     'assets/packFND_mascot1.png') //textdata used to create QR code
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
              data: qrdata,
              version: QrVersions.auto,
              // backgroundColor: Colors.yellow, //background
              // gapless: true,
              // embeddedImage: const AssetImage(
              //     'assets/packFND_mascot1.png'), //textdata used to create QR code
              // embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
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

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);

  final String? text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    print(text);
    print(press);
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black, //kPrimaryColor,
          backgroundColor: kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: press,
        child: Text(
          text == null ? "null" : text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
