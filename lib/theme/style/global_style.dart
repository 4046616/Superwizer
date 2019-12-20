import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class GlobalStyle {
  // Global Variables
  static const Color iconColor = Colors.white70;
  static const Color buttonsColor = Colors.red;
  static const Color inputIconColort = Colors.black26;
  static const Color inputFilColor = Colors.white;

  // Default Color Scheme
  static final ThemeData themeSettings = ThemeData(
    primaryColor: Colors.deepPurple,
    brightness: Brightness.light,
  );

  // Rounded
  static final RoundedRectangleBorder round = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(40.0),
    ),
  );

// Outline Inputs
  static final OutlineInputBorder outline = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(40.0)),
  );

  // Text Style
  static final TextStyle textStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    color: Colors.white,
  );

  // Button Text Style
  static final TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    color: Colors.white70,
  );
}
