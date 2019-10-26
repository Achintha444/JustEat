import 'User.dart';

class Customer{
  static Customer _user;
  String _phoneNumber;
  String _email;
  String _userName;
  User _userInstance;
  //static final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Customer._({String phoneNumber, String email, String userName = "temp"}) {
    // phoneNumber = phoneNumber.substring(3,11);
    // phoneNumber = "0"+phoneNumber;
    this._phoneNumber = phoneNumber;
    this._email = email;
    this._userName = userName;
  }

  static Future<Customer> createInstance(
      {String phoneNumber, String email, String userName}) async {
    if (_user == null) {
      await {
        _user = new Customer._(
           phoneNumber: phoneNumber, email: email, userName: userName)
      };
    }
    return Customer._user;
  }

  static Customer get getInstance {
    return Customer._user;
  }

  String get getEmail {
    return Customer._user._email;
  }

  String get getUserName {
    return Customer._user._userName;
  }

  String get getPhonenumber {
    return Customer._user._phoneNumber;
  }

  set setUserUser(User user){
    this._userInstance = user;
  }

}