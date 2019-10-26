import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  final List<String> entries;

  MyListView(this.entries);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: null,
          padding: null,
          // color: Colors.amber[colorCodes[index]],
          // child: Center(
          child: Card(
            margin: null,
            child: ListTile(
                leading: Icon(Icons.work),
                title: Text(
              entries[index],
            )),
          ),
          // ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
