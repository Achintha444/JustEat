import 'package:flutter/material.dart';

import 'package:just_eat/templates/AppDrawer.dart';
import 'package:just_eat/myAppDrawer/drawerList.dart';
class MyAppDrawer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return AppDrawer("Gayal",drawerList);
  }
}
