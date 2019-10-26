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
      print ("12345"+_currentDocId.toString());
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
        print (_customerCount.toString()+"121234");
        print (phoneNumber+"12131144");
        if ((phoneNumber == f.data["phoneNumber"]) && (f.data["type"] == 1)) {
          _currentDocId = _customerCount;
          print ("asaassaaaqqqqqqq"+_currentDocId.toString());
          return;
        }
      });
    });
  }
  // void insertUid(String uid) {

  //   _firestoreInstance
  //       .collection("user")
  //       .document(_totUsers.toString())
  //       .setData({"uid": uid});

  // }
}
