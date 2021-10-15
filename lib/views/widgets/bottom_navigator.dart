import 'package:flutter/material.dart';


class BottomNavigator extends StatefulWidget {
  const BottomNavigator({ Key? key }) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  @override
  Widget build(BuildContext context) {
    return (
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, //Color(0xFF6200EE),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: 1,
        onTap: (value) {
          // Respond to item press.
        },
        items: [
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.folder_shared),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset("assets/img-txt.jpeg", height: 52, width: 220),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.location_on),
          ),
          // BottomNavigationBarItem(
          //   title: Text('News'),
          //   icon: Icon(Icons.library_books),
          // ),
        ],
      )
    );
  }
}