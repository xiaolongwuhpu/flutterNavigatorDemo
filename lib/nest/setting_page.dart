import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CloseButton(),),
      body: new Container(
        child: new Center(
          child: new Text("设置界面"),
        ),
      ),
    );
  }
}
