import 'package:flutter/material.dart';

import 'package:just_eat/Constants/c.dart';
import 'package:just_eat/MyAppDrawer/index.dart';
import 'package:just_eat/Objects/Databse.dart';
import 'package:just_eat/Objects/Food.dart';
import 'package:just_eat/Objects/Resturant.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:just_eat/Interfaces/foodList.dart';
class Cart extends StatefulWidget {
  Cart({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  //Database _db;
  List<Food> ordered = foodList;

  

  // void _setAtrributes() async{
  //   Database _tempDb = await Database.createInstance();
  //   setState(() {
  //    _db = _tempDb;
  //    //_allResturants  = _tempAllResturants;
  //   });
  // }

  @override
  void initState() {
    //_setAtrributes();
    ordered = foodList; //Database.getResturants();
    super.initState();
  }

  // @override
  // void setState(){
  //   super.setState();
  // }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(

      drawer: MyAppDrawer(),
      body: ScrollConfiguration(
        behavior: C.buildViewportChrome(),
        child: CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: _height / 3,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: new Image(
                  image: AssetImage(C.imageLink + "logo1.png"),
                ),
                title: Container(
                  child: Text(
                    'Just    Eat',
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
                  'Orders',
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
                    // print("asasasasas" + _allResturants.toString());
                    return InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: C.primaryColour
                        ),
                        alignment: Alignment.center,
                        //color: C.primaryColour,
                        child: new Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              width: 200,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new AssetImage(
                                    ordered[index].getImage //.getImage,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              ordered[index].getName,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: _height / 25,
                                  color: C.secondaryColour,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Quantity: "+ordered.length.toString(),
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: _height / 43,
                                  color: C.secondaryColour,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Price: Rs. "+ordered[index].getPrice.toString(),
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: _height / 35,
                                  color: C.secondaryColour,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        null;
                      },
                    );
                  },
                  childCount: ordered.length,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


