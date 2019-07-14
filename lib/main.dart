import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interoperabilidade/styles.android.dart';
import 'package:flutter/services.dart';
import 'package:interoperabilidade/styles.apple.dart';
import 'package:interoperabilidade/views/search.view.dart';

void main() {
  //app só functiona na vertical
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
          home: CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                const CupertinoSliverNavigationBar(
                  largeTitle: const Text('Flutter stickers'),
                ),
                SliverSafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(top: 4),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('aaa'),
                      );
                    }),
                  ),
                )
              ],
            ),
          ));
    }
  }
}
