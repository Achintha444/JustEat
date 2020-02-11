import 'package:flutter/material.dart';
import 'package:just_eat/Constants/c.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Shop List'),
        ),
      backgroundColor: C.primaryColour,
      body: Column(
        children: <Widget>[
          Text('Gemi Gedara'),
          Text('at Kurunegala Town'),
          Image.asset(C.imageLink+'gemigedara.jpg'),
        ],
      ),
    );
  }
}
