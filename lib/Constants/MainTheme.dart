import 'package:flutter/material.dart';
import './c.dart';

class MainTheme {
  static final ThemeData base = ThemeData.light();

  static ThemeData buildLightTheme() {
    return base.copyWith(
        primaryColor: C.primaryColour,
        secondaryHeaderColor: C.secondaryColour,
        buttonTheme: _buildButtonTheme(base.buttonTheme),
        primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
        accentColor: Colors.yellowAccent,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme:
            _buildInputDecorationTheme(base.inputDecorationTheme));
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline
          .copyWith(fontWeight: FontWeight.w600, color: Colors.white)
          .apply(color: Colors.white),
    );
  }

  static ButtonThemeData _buildButtonTheme(ButtonThemeData base) {
    return base.copyWith(
      buttonColor: C.secondaryColour,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(
      InputDecorationTheme base) {
    return base.copyWith(
      focusColor: C.secondaryColour,
      hoverColor: C.primaryColour,
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25),
        borderSide: new BorderSide(
          color: C.primaryColour,
          width: 2,
        ),
        gapPadding: 5,
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.red,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
      enabledBorder: new OutlineInputBorder(
        borderSide: new BorderSide(
          color: C.secondaryColour,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25),
        borderSide: new BorderSide(
          color: C.primaryColour,
          width: 2,
        ),
        gapPadding: 5,
      ),
      labelStyle: new TextStyle(
        color: C.primaryColour,
      ),
    );
  }
}
