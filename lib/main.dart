import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interoperabilidade/styles.android.dart';
import 'package:flutter/services.dart';
import 'package:interoperabilidade/styles.apple.dart';
import 'package:interoperabilidade/views/apple/search/search.apple.view.dart';
import 'package:interoperabilidade/views/search.view.dart';

void main() {
  //app só functiona na vertical
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: CupertinoColors.black, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
      statusBarBrightness: Brightness.light,
    ),
  );

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //para android
    if (Platform.isAndroid) {
      return MaterialApp(
        title: 'Flutter Stickers',
        debugShowCheckedModeBanner: false,
        theme: AndroidStyles.materialThemeData,
        home: SearchView(),
      );
    }

    //para ios
    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Flutter Stickers',
        debugShowCheckedModeBanner: false,
        theme: AppleStyles.cupertinoThemeData,
        home: SearchAppleView(),
      );
    }
  }
}
