import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:just_eat/Constants/c.dart';
import 'package:just_eat/Interfaces/Home.dart';
import 'package:just_eat/Objects/Food.dart';
import 'package:just_eat/Objects/Resturant.dart';
import 'package:just_eat/myAppDrawer/index.dart';

class ResturantView extends StatefulWidget {
  Resturant _resturant;

  ResturantView(this._resturant);

  @override
  _ResturantViewState createState() => _ResturantViewState(_resturant);
}

class _ResturantViewState extends State<ResturantView> {
  Resturant _resturant;

  _ResturantViewState(this._resturant);
  List<Food> _menu;

  @override
  void initState(){
    super.initState();
    setState(() {
      _menu = _resturant.getMenu;
    });
    print (_menu.length.toString() + "12121212qqqqqqqqqqqqqqqq");
  }

  Future<bool> _onWillPop() {
    return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home())) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: MyAppDrawer(),
        body: ScrollConfiguration(
          behavior: C.buildViewportChrome(),
          child: CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Hero(
                    tag: _resturant.getName,
                    child: InkWell(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                              _resturant.getImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                    transitionOnUserGestures: true,
                  ),
                  title: Container(
                    width: double.infinity,
                    color: C.primaryColour,
                    child: Text(
                      _resturant.getName,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Monoton",
                        fontSize: _height / 30,
                        color: C.secondaryColour,
                      ),
                    ),
                  ),
                ),
              ),
              SliverStickyHeader(
                header: new Container(
                  height: _height / 15,
                  color: C.secondaryColour,
                  padding: EdgeInsets.symmetric(horizontal: _height / 25),
                  alignment: Alignment.center,
                  child: new Text(
                    'About   Us',
                    style: TextStyle(
                        color: C.primaryColour,
                        fontSize: _height / 26,
                        fontFamily: "Monoton"),
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _resturant.getAddress,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: _height / 35,
                            color: C.secondaryColour,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                      margin: EdgeInsets.only(
                          left: _width / 20, right: _width / 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _resturant.getDesc,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: _height / 35,
                            color: C.secondaryColour,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                // sliver: SliverFixedExtentList(
                //   itemExtent: 2000,
                //   delegate: SliverChildBuilderDelegate(
                //     (BuildContext context, int index) {
                //       return Container(
                //         alignment: Alignment.center,
                //         color: Colors.lightBlue[100 * (index % 9)],
                //         child: Text('List Item $index'),
                //       );
                //     },
                //   ),
                // ),
              ),
              SliverStickyHeader(
                header: new Container(
                  height: _height / 15,
                  color: C.secondaryColour,
                  padding: EdgeInsets.symmetric(horizontal: _height / 25),
                  alignment: Alignment.center,
                  child: new Text(
                    'MENUS',
                    style: TextStyle(
                        color: C.primaryColour,
                        fontSize: _height / 26,
                        fontFamily: "Monoton"),
                  ),
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: _height / 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.6,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //print("asasasasas" + _allResturants.toString());
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: C.primaryColour),
                        alignment: Alignment.center,
                        //color: C.primaryColour,
                        child: new Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(
                                      _menu[index].getImage,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){null;},
                            ),
                            Text(
                              _menu[index].getName,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: _height / 35,
                                  color: C.secondaryColour,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rs. "+_menu[index].getPrice.toString(),
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: _height / 43,
                                  color: C.secondaryColour,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: _menu.length,
                  ),
                ),
              ),

/*               SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('Grid Item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('List Item $index'),
                    );
                  },
                ),
              ),
             */
            ],
          ),
        ),
      ),
    );
  }
}
