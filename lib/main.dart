import 'package:flutter/material.dart';
import 'package:pack/screens/generate.dart';
import 'package:pack/screens/home.dart';
import 'package:pack/screens/landing.dart';
import 'package:pack/screens/scan.dart';
import 'package:pack/screens/search.dart';

void main() => runApp(MaterialApp(
      home: const Home(),
      routes: {
        '/landHome': (context) => LandHome(),
        '/ScanQr': (context) => ScanQRPage(),
        '/GenQr': (context) => QRGeneratorSharePage(),
        '/Search': (context) => SearchPage(title: 'Find'),
      },
    ));
