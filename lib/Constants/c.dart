import 'package:flutter/material.dart';

class C {
  static final Color primaryColour = Color.fromRGBO(6, 84, 113, 1);
  static final Color secondaryColour = Color.fromRGBO(255, 192, 69, 1);
  static final String imageLink = "assets/images/";

  static MyBehavior buildViewportChrome(){
    return MyBehavior();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
