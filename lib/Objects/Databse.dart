import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_eat/Objects/Customer.dart';

class Database {
  static Database _database;
  static Firestore _firestoreInstance;
  static int _totUsers;
  static int _currentDocId;
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

  List<String> getAllUsersPhoneNumbers() {
    List<String> _allPhoneNumbers = new List();
    //_allPhoneNumbers.
    _firestoreInstance
        .collection("user")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents
          .forEach((f) => _allPhoneNumbers.add(f.data["phoneNumber"]));
    });
    _totUsers = _allPhoneNumbers.length;
    return _allPhoneNumbers;
  }

  void insertUser(String email, String phoneNumber, String userName) {
    _totUsers += 1;
    _currentDocId = _totUsers;
    _firestoreInstance
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

  List<String> getCustomerEmailPhoneNumber() {
    int _customerCount = 0;
    _firestoreInstance
        .collection("books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
  // void insertUid(String uid) {

  //   _firestoreInstance
  //       .collection("user")
  //       .document(_totUsers.toString())
  //       .setData({"uid": uid});

  // }
}
