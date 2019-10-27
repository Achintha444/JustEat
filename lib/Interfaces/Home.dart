import 'package:flutter/material.dart';
import 'package:just_eat/Constants/c.dart';
import 'package:just_eat/Interfaces/RestruantView.dart';
import 'package:just_eat/MyAppDrawer/index.dart';
import 'package:just_eat/Objects/Databse.dart';
import 'package:just_eat/Objects/Resturant.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Database _db;
  List<Resturant> _allResturants;

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
    super.initState();
    _allResturants = Database.getResturants();
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
                  'RESTURANTS',
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
                    print("asasasasas" + _allResturants.toString());
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: C.primaryColour),
                      alignment: Alignment.center,
                      //color: C.primaryColour,
                      child: new Column(
                        children: <Widget>[
                          Hero(
                            tag: _allResturants[index].getName,
                            child: InkWell(
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(
                                      _allResturants[index].getImage,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (BuildContext context)=>
                                          ResturantView(_allResturants[index]))),
                            ),
                            transitionOnUserGestures: true,
                          ),
                          Text(
                            _allResturants[index].getName,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontSize: _height / 35,
                                color: C.secondaryColour,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _allResturants[index].getAddress,
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
                  childCount: _allResturants.length,
                ),
              ),
            ),


/*             SliverFixedExtentList(
              itemExtent: 50,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('List Item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 100.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100.0,
                      child: Card(
                        child: Text('data'),
                      ),
                    );
                  },
                ),
              ),
            ),
           */
          ],
        ),
      ),
    );
  }
}
