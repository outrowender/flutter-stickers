import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class AppleStyles {
  static const TextStyle productRowItemName = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle productRowTotal = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static CupertinoThemeData cupertinoThemeData = CupertinoThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    //primaryColor: CupertinoColors.activeBlue,

    // textTheme: CupertinoTextThemeData(

    //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    // ),
  );
}
