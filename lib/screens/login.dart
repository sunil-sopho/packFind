
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=> _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Center(
        child:Text('Login Screen') ,
      ),
    );
  }
}