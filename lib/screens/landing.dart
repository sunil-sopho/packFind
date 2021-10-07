import 'package:flutter/material.dart';

class LandHome extends StatelessWidget {
  const LandHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Qr code"),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ScanQr');
              },
              child: const Text('Scan it to Find it'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/GenQr');
              },
              child: const Text('Create inventory'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Search');
              },
              child: const Text('Find inventory'),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
        ]),
      ]),
    );
  }
}
