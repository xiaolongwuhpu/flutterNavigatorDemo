

import 'package:flutter/material.dart';
import 'package:navigator_learning/nest/nest_home.dart';
void main() => runApp(new MyNestApp());

class MyNestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        body: NestHome(),
      ),
    );
  }
}