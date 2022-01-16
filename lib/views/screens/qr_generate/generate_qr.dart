import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pack/views/routes/routes.gr.dart';
import 'package:pack/views/widgets/common.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pack/models/package.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:pack/views/widgets/bottom_navigator.dart';

import 'package:get_it/get_it.dart';

class QRGeneratorSharePage extends StatefulWidget {
  final Package? package;

  const QRGeneratorSharePage({Key? key, this.package}) : super(key: key);

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
  final _name = TextEditingController();
  File? file;

  var userID = '1';

  @override
  void dispose() {
    _itemList.dispose();
    _location.dispose();
    _name.dispose();
    // imageBloc.dispose();
    // dataBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dataBloc.eventSink.add(DataEvent(DataAction.init));
    imageBloc.eventSink.add(
        ImageEvent(ImageAction.addStringImages, [], -1, widget.package?.image));
    imageBloc.eventSink.add(ImageEvent(ImageAction.init));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _locationText = "";
    String _nameText = "";
    String _itemListText = "";
    String _packageIdText = getCounter().toString();
    print("build qr page");
    if (widget.package != null) {
      _packageIdText = widget.package!.packageId;
      textdata = widget.package!.packageId;
      userID = widget.package!.uid;
      _locationText = widget.package!.location;
      _nameText = widget.package!.name;
      _itemListText = widget.package!.itemList;
      // List<Image> _images =
      //     getImagesfromStringListForEditing(widget.package!.image);
      // List<XFile> _imageList =
      //     _images.map((e) => e.image).cast<XFile>().toList();

    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(slivers: <Widget>[
        const SliverToBoxAdapter(
          child: SizedBox(),
        ),

        SliverToBoxAdapter(
            child: Container(
                child: Column(children: [
          LogoWidget(width: 180, height: 170),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(
              child: TextFormField(
                enabled: false,
                decoration: const InputDecoration(labelText: 'Package id'),
                controller: _packageId..text = _packageIdText,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            QrCodeWidget(textdata: textdata),
          ]),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                  suffixIcon: Icon(Icons.person, color: Colors.blue),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                  labelText: 'Name',
                  hintText: 'Name of person or Package'),
              controller: _name..text = _nameText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                suffixIcon: Icon(Icons.book, color: Colors.blue),
                border: UnderlineInputBorder(
                    // borderRadius: BorderRadius.all(
                    // Radius.circular(30),
                    // ),
                    ),
                labelText: 'List of items',
              ),
              controller: _itemList..text = _itemListText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Location of packaging',
                  fillColor: Color(0xFFFFFFFF),
                  suffixIcon: Icon(Icons.map, color: Colors.blue),
                  border: UnderlineInputBorder()),
              controller: _location..text = _locationText,
            ),
          )
        ]))),
        SliverToBoxAdapter(
          child: Row(children: [
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

                  dynamic imgList = imageBloc.getImageStringList();
                  Package newpackage = Package(
                    packageId: _packageId.text,
                    name: _name.text,
                    uid: userID,
                    itemList: _itemList.text,
                    location: _location.text,
                    image: imgList,
                  );

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
            QrShareButton(textdata: textdata)
          ]),
        ),
        const SliverPadding(
          padding: const EdgeInsets.only(bottom: 20.0),
        ),
        SliverToBoxAdapter(
            child: Container(
                height: 200.0,
                width: 50.0,
                // shrinkWrap: true,
                // width: double.infinity,
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
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    snapshot.data![index],
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding:
                                            const EdgeInsetsDirectional.all(0),
                                        color: const Color.fromRGBO(
                                            255, 255, 254, 0.4),
                                        child: IconButton(
                                          onPressed: () {
                                            imageBloc.eventSink.add(ImageEvent(
                                                ImageAction.deleteImage,
                                                [],
                                                index));
                                          },
                                          icon: const Icon(Icons.cancel),
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                    }))),

        // SliverToBoxAdapter(child: const Spacer()),
      ]),
//
      bottomNavigationBar: BottomNavigator(
        selectedIndex: selectedIndex,
      ),
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
