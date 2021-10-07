import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagePicker = ImagePicker();
  final List<XFile>? _imageList = [];
  Future getImagefromcamera() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageList!.add(image!);
    });
  }
  void getImagefromGallery() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    setState((){
      if(selectedImages!.isNotEmpty){
        _imageList!.addAll(selectedImages);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(File(_imageList![index].path),
                    fit: BoxFit.cover,
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
                tooltip: "pickImage",
                child: const Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                onPressed: (){
                  getImagefromGallery();
                },
                tooltip: "Pick Image",
                child: const Icon(Icons.image),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton(
            onPressed: () {}, 
            child:const Text('Confirm'),
            ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
