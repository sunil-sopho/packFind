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
  XFile? _image;
  final imagePicker = ImagePicker();
  Future getImagefromcamera() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }
  Future getImagefromGallery() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a picture of your package"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? const Text("No Image is picked")
                    : Image.file(
                  File(_image!.path),
                  width: 250,
                  fit: BoxFit.cover,),
              ),
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
                onPressed: getImagefromGallery,
                tooltip: "Pick Image",
                child: const Icon(Icons.image),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          OutlinedButton(
            onPressed: (){}, 
            child:const Text('Confirm'),
            ),
        ],
      ),
    );
  }
}