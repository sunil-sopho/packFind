// contains common widgets used

// inserts logo
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pack/config/constants.dart';
import 'package:pack/controllers/utils.dart';
import 'package:share_plus/share_plus.dart';

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

class QrShareButton extends StatelessWidget {
  const QrShareButton({Key? key, required this.textdata}) : super(key: key);
  final String textdata;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        child: const Text('Share'),
        onPressed: () async {
          try {
            var image = await QrPainter(
              emptyColor: Colors.white,
              data: textdata,
              version: QrVersions.auto,
              gapless: true,
            ).toImage(200);

            ByteData? byteData =
                await image.toByteData(format: ImageByteFormat.png);
            print("step 2");

            Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
            final appDir = await getApplicationDocumentsDirectory();
            print("step 3");
//current time

//qr image file creation
            var file =
                await File('${appDir.path}/qr_code(packFND).png').create();
            print("step 4");
//appending data
            await file.writeAsBytes(pngBytes);
//Shares QR image
            await Share.shareFiles([file.path],
                mimeTypes: ["image/png"],
                text: "Qr code for package",
                subject: "Qr code for package");
          } catch (e) {
            print(e.toString());
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ))));
  }
}

class IconAppBar extends StatelessWidget {
  const IconAppBar(
      {Key? key,
      required this.icon,
      this.color = const Color(0xff8192A3),
      this.size = 20,
      this.padding = 10,
      this.isOutLine = false,
      required this.onPressed})
      : super(key: key);
  final IconData icon;
  final Color color;
  final double size;
  final double padding;
  final bool isOutLine;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(padding),
          // margin: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            border: Border.all(
                color: color,
                style: isOutLine ? BorderStyle.solid : BorderStyle.none),
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            color: isOutLine
                ? Colors.transparent
                : Theme.of(context).backgroundColor,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color(0xfff8f8f8),
                  blurRadius: 5,
                  spreadRadius: 10,
                  offset: Offset(5, 5)),
            ],
          ),
          child: Icon(icon, color: color, size: size),
        ),
        onTap: () {
          if (onPressed != null) {
            onPressed();
          }
        },
        borderRadius: const BorderRadius.all(Radius.circular(13)));
  }
}
