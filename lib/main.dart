import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:interoperabilidade/views/home.view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stickers',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeView(),
    );
  }
}
