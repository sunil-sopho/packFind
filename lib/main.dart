import 'package:flutter/material.dart';

void main()=> runApp(MaterialApp(
  home: Scaffold(
    /*appBar: AppBar(
      title: Text('packFind'),
      centerTitle: true,
      backgroundColor: Colors.pinkAccent,
    ),*/
    body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img-home1.jpeg',
                width: 300,
                height: 300,

              ),
              Image.asset('assets/img-txt.jpeg',
                width: 200,
                height: 200,
              ),
              ElevatedButton.icon(
                onPressed: (){},
                label:const Text('Login to Find'),
                icon: const Icon(Icons.verified_user_rounded),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                          )
                      )
                  )
              ),
            ]
        ),
    ]
    ),
  ),
));
