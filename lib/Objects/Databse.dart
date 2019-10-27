import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_eat/Objects/Customer.dart';
import 'package:just_eat/Objects/Food.dart';
import 'package:just_eat/Objects/Resturant.dart';

class Database {
  static Database _database;
  static Firestore _firestoreInstance;
  static int _totUsers;
  static int _currentDocId;
  static List<Resturant> _allResturants;
  //String _uid;
  //int _type;
  //static final FirebaseAuth _auth = FirebaseAuth.instance;
  //static final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Database._({Firestore firestoreInstance}) {
    _firestoreInstance = firestoreInstance;
  }

  static Future<Database> createInstance() async {
    if (_database == null) {
      Firestore _firestoreInstance = Firestore.instance;
      await {_database = new Database._(firestoreInstance: _firestoreInstance)};
    }
    return Database._database;
  }

  Future<List<String>> getAllUsersPhoneNumbers() async {
    List<String> _allPhoneNumbers = new List();
    //_allPhoneNumbers.
    await _firestoreInstance
        .collection("user")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents
          .forEach((f) => _allPhoneNumbers.add(f.data["phoneNumber"]));
    });
    _totUsers = _allPhoneNumbers.length;
    return _allPhoneNumbers;
  }

  Future<int> getTotUsers() async {
    if (_totUsers == null) {
      List<String> _allPhoneNumbers = new List();
      //_allPhoneNumbers.
      await _firestoreInstance
          .collection("user")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents
            .forEach((f) => _allPhoneNumbers.add(f.data["phoneNumber"]));
      });
      _totUsers = _allPhoneNumbers.length;
    }
    return _totUsers;
  }

  void insertUser(String email, String phoneNumber, String userName) async {
    phoneNumber = phoneNumber.substring(1, 10);
    phoneNumber = "+94" + phoneNumber;
    int _temp = await getTotUsers();
    _totUsers += 1;
    _currentDocId = _totUsers;
    await _firestoreInstance
        .collection("user")
        .document(_totUsers.toString())
        .setData({"type": 1, "phoneNumber": phoneNumber});
    _firestoreInstance
        .collection("customer")
        .document(_totUsers.toString())
        .setData({"email": email, "userName": userName});
    Customer.createInstance(
        email: email, phoneNumber: phoneNumber, userName: userName);
  }

  Future<List<String>> getCustomerEmailPhoneNumberUserName(
      String phoneNumber) async {
    List<String> _temp = new List();
    _temp.add(phoneNumber);
    // phoneNumber = phoneNumber.substring(1, 10);
    // phoneNumber = "+94" + phoneNumber;
    await _setDocId(phoneNumber);
    DocumentReference documentReference = Firestore.instance
        .collection("customer")
        .document(_currentDocId.toString());
    await documentReference.get().then((datasnapshot) {
      print("12345" + _currentDocId.toString());
      if (datasnapshot.exists) {
        _temp.add(datasnapshot.data['email'].toString());
        _temp.add(datasnapshot.data['userName'].toString());
      }
    });
    return _temp;
  }

  void _setDocId(String phoneNumber) async {
    int _customerCount = 0;
    await _firestoreInstance
        .collection("user")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        _customerCount += 1;
        print(_customerCount.toString() + "121234");
        print(phoneNumber + "12131144");
        if ((phoneNumber == f.data["phoneNumber"]) && (f.data["type"] == 1)) {
          _currentDocId = _customerCount;
          print("asaassaaaqqqqqqq" + _currentDocId.toString());
          return;
        }
      });
    });
  }

  void setRestuants() async {
    if (_allResturants == null) {
      List<Resturant> _resturants = new List();

      await _firestoreInstance
          .collection("resturant")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) async {
          //String _temp = f.data["image"];
          Resturant _tempResturant = new Resturant(f.data["image"],
              f.data["name"], f.data["address"], f.data["desc"]);
          List _foods = List.from(f.data["food"]);
          List<Food> _menu = new List();
          _foods.forEach((g) async{
            if (g != ""){
              DocumentSnapshot snapShot = await  g.get();
              int _tempX = snapShot.data["price"];
              Food _tempFood =
                new Food(snapShot.data["image"],snapShot.data["name"], _tempX);
              _menu.add(_tempFood);

            }

            
          });
          _tempResturant.setMenu = _menu;
          print (_tempResturant.getMenu.length.toString()+"122121qwqwdadwqeqwdqada");
          //print(_menu[0].getName);
          _resturants.add(_tempResturant);
          //_tempResturant = await _tempFunction9(_foods, _tempResturant);
          //_resturants.add(_tempFunction9(_foods, _tempResturant));
        });
      });

      _allResturants = _resturants;
    }

    // void insertUid(String uid) {

    //   _firestoreInstance
    //       .collection("user")
    //       .document(_totUsers.toString())
    //       .setData({"uid": uid});

    // }
  }

/*   Future<Resturant> _tempFunction9(List foods, Resturant tempResturant) async {
    print(foods.length.toString() + "Foods Length");
    foods.forEach((g) async {
      if (g != "" && g != null) {
        print("a");
        //DocumentReference _temp = g;
        

            .collection("food")
            .get()
            .then((QuerySnapshot snapShot) {
          List<Food> _temp1 = new List();
          snapShot.documents.forEach((m) async {
            // await m
            // .collection("")
            Food _tempFood =
                new Food(m.data["image"], m.data["name"], m.data["price"]);
            print(_tempFood.getName + "Fooood111111111111");
            _temp1.add(_tempFood);
          });
          print(_temp1[0].getName + "Foodsssss");
          tempResturant.setMenu = _temp1;
        });
      } else {
        tempResturant.setMenu = [];
      }

      //print ("trtrtr"+g.toString());
    });
    return tempResturant;
  }

   */
  static List<Resturant> getResturants() {
    return _allResturants;
  }
}
