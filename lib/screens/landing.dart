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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white, //Color(0xFF6200EE),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset("assets/img-txt.jpeg",
                  height: 52, width: 220), //con(Icons.music_note),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.location_on),
            ),
            // BottomNavigationBarItem(
            //   title: Text('News'),
            //   icon: Icon(Icons.library_books),
            // ),
          ],
        ));
  }
}
