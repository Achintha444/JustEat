import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_eat/Objects/Customer.dart';
import 'package:just_eat/Objects/Databse.dart';
import 'package:just_eat/Objects/User.dart';

class PhoneAuth {
  String _phoneNumber;
  String _smsCode;
  String _verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;

  PhoneAuth(this._phoneNumber);

  Future<bool> checkIfUserRegistered() async {
    Database _database = await Database.createInstance();
    List<String> _phoneNumbers = await _database.getAllUsersPhoneNumbers();
    // String _tempPhone = _phoneNumber;
    // _tempPhone  = _tempPhone .substring(1, 10);
    // _tempPhone  = "+94" + _tempPhone ;
    //_phoneNumber =
    print(_phoneNumbers.toString());
    print(_phoneNumber);
    bool _check = _phoneNumbers.contains(_phoneNumber);
    return _check;
  }

  Future<bool> verifyPhoneNumber() async {
    bool _completed = true;
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      print('Received phone auth credential: $phoneAuthCredential');
      // setState(() {
      //   _message = ;
      // });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      _completed = false;
      // setState(() {
      //   _message =
      //       ;
      // });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      // widget._scaffold.showSnackBar(const SnackBar(
      //   content: Text('Please check your phone for the verification code.'),

      // ));
      print("VID SENT");
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    return _completed;
  }

  // Example code of how to sign in with phone.
  void signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print(user);
    print("CHECK");
    // Database _database = await Database.createInstance();
    // await _database.setRestuants();
    if (user != null) {
       Database _database = await Database.createInstance();
      await  _database.setRestuants();
      print('Successfully signed in, uid: ' + user.uid);
      User.createInstance(uid: user.uid);
      if (Customer.getInstance == null) {
        List<String> _temp =
            await _database.getCustomerEmailPhoneNumberUserName(_phoneNumber);
        print("asasaasaassa" + _temp.toString());
        Customer.createInstance(
            phoneNumber: _phoneNumber, email: _temp[1], userName: _temp[2]);
      }
      //User.createInstance(uid: user.uid, phoneNumber: user.phoneNumber, email: user.email);
      print(User.getInstance.getID);
    } else {
      print('Sign in failed');
    }
    //setState(() {});
  }

  set setSmsCode(String smsCode) {
    this._smsCode = smsCode;
  }
}
