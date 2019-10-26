import 'package:flutter/material.dart';

import '../Constants/c.dart';
import 'package:just_eat/settings/index.dart';


// class ClassWrapper extends StatelessElement{
//   Widget realClass;
//   ClassWrapper(this.realClass.);
// }

class AppDrawer extends StatelessWidget {
  final List<List<Object>> drawerList;
  final String header;
  AppDrawer(this.header, this.drawerList);

  void handleTap(int key) {
    print('Hello');
    // ClassWrapper wrapper = new ClassWrapper(drawerList[ke][2]);
    Settings();
  }

  List<Widget> createDrawer() {
    List<Widget> listTileList = new List<Widget>();

    listTileList.add(
      DrawerHeader(
        child: Text(
          header,
          style: TextStyle(
            color: C.primaryColour,
            fontSize: 20,
          ),
        ),
        decoration: BoxDecoration(
          color: C.secondaryColour,
        ),
      ),
    );

    for (int i = 0; i < drawerList.length; i++) {
      listTileList.add(
        ListTile(
          title: Text(drawerList[i][1]),
          onTap: () {
            handleTap(i);
          },
        ),
      );
    }

    return listTileList;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: createDrawer(),
      ),
    );
  }
}
