import 'package:flutter/material.dart';

import 'package:just_eat/templates/ListView.dart';

class MyTabController extends StatelessWidget {
  final List<String> _textList;
  final List<IconData> _iconList;
  final String _label;
  final List<List<String>> dataList;
  MyTabController(this._label, this._textList, this._iconList, this.dataList);

  List<MyListView> createListView() {
    List<MyListView> listViewList = new List<MyListView>();
    for (int i = 0; i < dataList.length; i++) {
      listViewList.add(MyListView(dataList.elementAt(i)));
    }   
    return listViewList;
  }

  @override
  Widget build(BuildContext context) {
    int _tabListLength = _textList.length;
    List<Tab> _tabList = [];
    for (int i = 0; i < _tabListLength; i++) {
      _tabList.add(Tab(
        text: _textList[i],
        icon: Icon(_iconList[i]),
      ));
    }

    return Container(
      child: DefaultTabController(
        // The number of tabs / content sections to display.
        length: _tabListLength,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: _tabList,
            ),
            title: Text(_label),
          ),
          body: TabBarView(
            children: createListView(),
          ),
        ),
      ),
    );
  }
}
