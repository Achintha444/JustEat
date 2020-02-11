import 'package:flutter/material.dart';
import 'package:just_eat/Constants/MainTheme.dart';
//import 'package:just_eat/Interfaces/SplashScreen.dart';
import 'package:just_eat/Interfaces/ShopScreen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Eat',
      theme: MainTheme.buildLightTheme(),
      home: ShopScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}