import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_eat/Interfaces/Cart.dart';
import 'package:just_eat/Interfaces/Login.dart';
import 'package:just_eat/Objects/Customer.dart';
import 'package:just_eat/Objects/User.dart';

import '../Constants/c.dart';
import 'package:just_eat/settings/index.dart';

import '../Interfaces/Home.dart';

// class ClassWrapper extends StatelessElement{
//   Widget realClass;
//   ClassWrapper(this.realClass.);
// }

class AppDrawer extends StatelessWidget {
  final List<List<Object>> drawerList;
  //final String header;

  //User _user = User.getInstance;
  Customer _cus = Customer.getInstance;
  AppDrawer(this.drawerList);

  List<Widget> createDrawer(BuildContext context) {
    List<Widget> listTileList = new List<Widget>();

    listTileList.add(
      DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _cus.getUserName,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: C.primaryColour,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _cus.getEmail,
                style: TextStyle(
                  color: C.primaryColour,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _cus.getPhonenumber,
                style: TextStyle(
                  color: C.primaryColour,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: C.secondaryColour,
        ),
      ),
    );

    for (int i = 0; i < drawerList.length; i++) {
      listTileList.add(
          // Row(children: [
          // Icon(drawerList[i][0]),
          ListTile(
              title: Text(drawerList[i][1]),
              onTap: () {
                switch (i) {
                  case 0:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (Home())));
                    break;
                  case 1:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (Cart())));
                    break;
                  case 2:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (Cart())));
                    break;
                  case 3:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (Settings())));
                    break;
                  case 4:
                    User.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (Login())));
                    break;
                  default:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (Settings())));
                    break;
                }
                // typedef drawerList.elementAt(i).elementAt(2)  page();
              }));
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
        // padding: EdgeInsets.zero,
        children: createDrawer(context),
      ),
    );
  }
}
