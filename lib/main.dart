import 'package:flutter/material.dart';
import 'package:pack/screens/camera.dart';
import 'package:pack/screens/generate.dart';
import 'package:pack/screens/home.dart';
import 'package:pack/screens/landing.dart';
import 'package:pack/screens/scan.dart';

void main()=> runApp(MaterialApp(
  home: const Home(),
  routes: {
    '/landHome' : (context) => const LandHome() ,
    '/ScanQr': (context) => const ScanQRPage(),
    '/GenQr' : (context) => const QRGeneratorSharePage(),
    '/Camera' : (context) => MyHomePage(),
  },
));
