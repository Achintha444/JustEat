import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_eat/Objects/Customer.dart';

class User {
  static User _user;
  String _uid;
  int _type;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  //static final GoogleSignIn _googleSignIn = new GoogleSignIn();

  User._({String uid,int type}) {
    this._uid = uid;
    _type = type;
  }

  static Future<User> createInstance(
      {String uid,int type=1}) async {
    if (_user == null) {
      await {
        _user = new User._(
            uid:uid,type: type)
      };
    }
    return User._user;
  }

  static Future<Customer> createCustomerInstance(
      {User user,String uid,String phoneNumber, String email, String userName}) async {
        Customer.createInstance(user: user,phoneNumber: phoneNumber,email: email,userName: userName);
        return Customer.getInstance;
  }

  static void signOut() async{
    _auth.signOut();
    User._user = null;
  }

  static User get getInstance {
    return User._user;
  }

  String get getID {
    return User._user._uid;
  }
  int get getType{
    return User._user._type;
  }

}