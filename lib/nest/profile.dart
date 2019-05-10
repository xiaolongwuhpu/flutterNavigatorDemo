import 'package:flutter/material.dart';

class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child: new Text('setting'),
          onPressed: () {
            Navigator.of(context).pushNamed('/setting');
          },
        ),
      ),
    );
  }
}
