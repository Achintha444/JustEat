import 'package:flutter/material.dart';

import 'package:just_eat/templates/TabController.dart';
import 'package:just_eat/settings/settingList.dart';
import 'package:just_eat/MyAppDrawer/index.dart';
class Settings extends StatelessWidget {
  final String _label = "Settings";
  final List<String> _textList = ["Profile","Location","Help"];
  final List<IconData> _iconList = [Icons.account_box,Icons.edit_location,Icons.help];
    @override
  Widget build(BuildContext context) { 


    return Scaffold(
      drawer: MyAppDrawer(),
      body:MyTabController(_label,_textList,_iconList,settingList),

    );
  }

  
}
