import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:just_eat/Constants/PhoneAuth.dart';
import 'package:just_eat/Constants/c.dart';
import 'package:just_eat/Constants/FormValidator.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:just_eat/Interfaces/Home.dart';
import 'package:just_eat/Interfaces/Register.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _validationController = new TextEditingController();
  bool _autoActivate = false;
  MyBehavior _myBehavior = C.buildViewportChrome();
  String _phoneNumber;
  String _validation;
  static PhoneAuth _auth;

  void _showVerifyDialog(BuildContext tempContext) {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: Image(
                image: AssetImage(C.imageLink + "ok.jpg"),
              ),
              title: new Text(
                "Verification ID Sent",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: C.primaryColour),
              ),
              description: new Text(
                "Please Enter the sent Verification Id in the following box",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: C.primaryColour),
              ),
              //description: new TextField(),
              buttonOkColor: C.secondaryColour,
              cornerRadius: 15,
              onlyOkButton: true,

              onOkButtonPressed: () async {
                Navigator.pop(tempContext);
                //_auth.verifyPhoneNumber();
                showDialog(
                  context: tempContext,
                  child: new SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          TextField(
                            controller: _validationController,
                            decoration: new InputDecoration(
                              labelText: "Enter the Verification code",
                            ),
                          ),
                          RaisedButton(
                            child: new Text(
                              "OK",
                              style: new TextStyle(
                                  color: C.primaryColour,
                                  backgroundColor: C.secondaryColour),
                            ),
                            onPressed: () async {
                              _validation = _validationController.text;
                              _auth.setSmsCode = _validation;
                              try {
                                _auth.signInWithPhoneNumber();
                                
                                Navigator.pop(tempContext);
                                Navigator.of(tempContext).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Home()));
                                print(_validation);
                              } catch (e) {
                                _showFailedDialog(tempContext);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ));
  }

  void _showFailedDialog(BuildContext tempContext) {
    showDialog(
      context: tempContext,
      builder: (_) => NetworkGiffyDialog(
        image: new Image(
          image: new AssetImage(C.imageLink + "false.jpg"),
        ),
        title: new Text(
          "Verification Failed",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: C.primaryColour),
        ),
        description: new Text(
          "Please check your internt connection and try again!",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: C.primaryColour),
        ),
        onlyOkButton: true,
        buttonOkColor: C.secondaryColour,
        onOkButtonPressed: () {
          Navigator.pop(tempContext);
        },
      ),
    );
  }

  void _showGoToRegister(BuildContext tempContext) {
    showDialog(
      context: tempContext,
      builder: (_) => NetworkGiffyDialog(
        image: new Image(
          image: AssetImage(C.imageLink + "register.jpg"),
        ),
        title: new Text(
          "Please Register",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: C.primaryColour),
        ),
        description: new Text(
          "You have not registered , Please Register to continue!",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: C.primaryColour),
        ),
        buttonOkColor: C.secondaryColour,
        onlyOkButton: true,
        onOkButtonPressed: () {
          Navigator.pop(tempContext);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(34),
        child: ScrollConfiguration(
          behavior: _myBehavior,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(C.imageLink + "registerBackground.jpg"),
                fit: BoxFit.fill,
                repeat: ImageRepeat.noRepeat,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: _height / 8,
                  left: _width / 20,
                  right: _width / 20,
                  bottom: _height / 15),
              child: Padding(
                padding: EdgeInsets.only(top: _height / 6),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoActivate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: Center(
                          child: new Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontFamily: "Monoton",
                              fontSize: _height / 17,
                              fontWeight: FontWeight.w600,
                              color: C.secondaryColour,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: "Enter Phone number",
                          ),
                          validator: (value) {
                            return FormValidator.validatePhoneNumber(value);
                          },
                          onSaved: (String value) {
                            _phoneNumber = value;
                            _phoneNumber = _phoneNumber.substring(1, 10);
                            _phoneNumber = "+94" + _phoneNumber;
                          },
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 2 * (_width / 3.2),
                            child: RaisedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Register())),
                              child: Text('Register'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: _width / 24),
                            child: SizedBox(
                              width: _width / 4.29,
                              child: RaisedButton(
                                color: C.primaryColour,
                                textColor: C.secondaryColour,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    _auth = PhoneAuth(_phoneNumber);
                                    print ("qwwqqw"+_phoneNumber);
                                    bool _registerCheck =
                                        await _auth.checkIfUserRegistered();
                                    if (_registerCheck) {
                                      bool _check =
                                          await _auth.verifyPhoneNumber();
                                      if (_check) {
                                        _showVerifyDialog(context);
                                      } else {
                                        _showFailedDialog(context);
                                      }
                                    } else {
                                      _showGoToRegister(context);
                                    }

                                    print(_phoneNumber);
                                  } else {
                                    _autoActivate = true;
                                  }
                                },
                                child: Text('Login'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
