import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pack/controllers/services/package_handler.dart';
import 'package:get_it/get_it.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagePicker = ImagePicker();
  final List<XFile>? _imageList = [];
  final imageBloc = GetIt.instance<ImageBloc>();
  Future getImagefromcamera() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      print("camera image added");
      _imageList!.add(image!);
    });
  }

  void getImagefromGallery() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    setState(() {
      if (selectedImages!.isNotEmpty) {
        _imageList!.addAll(selectedImages);
      }
    });
  }

  @override
  void initState() {
    // imageBloc.eventSink.add(ImageEvent(ImageAction.init));
    // _imageList!.addAll(imageBloc.updateImageList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Take a picture of your package"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? const Text("No Image is picked")
                    : Image.file(
                  File(_imageList![index].path),
                  width: 200,
                  fit: BoxFit.cover,),
              ),
            ),
          ),*/
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: _imageList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                File(_imageList![index].path),
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsetsDirectional.all(0),
                                  color:
                                      const Color.fromRGBO(255, 255, 254, 0.4),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _imageList!.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.cancel),
                                    color: Colors.red[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: getImagefromcamera,
                    tooltip: "Pick Image from Camera",
                    heroTag: 'openCameraBtn',
                    child: const Icon(Icons.add_a_photo),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      getImagefromGallery();
                    },
                    heroTag: 'openGalleryBtn',
                    tooltip: "Pick Image from Gallery",
                    child: const Icon(Icons.image),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              OutlinedButton(
                onPressed: () {
                  print("confirm clicked");
                  print(_imageList);
                  imageBloc.eventSink
                      .add(ImageEvent(ImageAction.addImages, _imageList));
                  // _imageList!.clear();
                  Navigator.pop(context);
                },
                child: const Text('Confirm'),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
