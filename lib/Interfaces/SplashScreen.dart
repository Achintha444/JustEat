import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_eat/Constants/c.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.primaryColour,
      body: Center(
        child: Image.asset(C.imageLink+'logo.png'),
      ),
    );
  }
}