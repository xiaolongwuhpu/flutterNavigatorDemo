import 'package:flutter/material.dart';
import 'home_navigator.dart';
import 'profile.dart';

class NestHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _NestHomeState();
  }
}

class _NestHomeState extends State<NestHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new HomeNavigator(),
    new Me(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Me'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}