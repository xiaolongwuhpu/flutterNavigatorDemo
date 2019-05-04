import 'package:flutter/material.dart';
import 'package:navigator_learning/nest/nest_home.dart';
import 'package:navigator_learning/nest/setting_page.dart';
import 'package:navigator_learning/push_no_param.dart';
import 'package:navigator_learning/pushwithparam/main_push_with_param.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new MainApp(),
        '/setting': (BuildContext context) => new SettingPage()
      },
//      home: MainApp(),
    );
  }
}
TextStyle _style = TextStyle(color: Colors.white,fontSize: 18);
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text("noParam",style: _style),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PushNoParam(),
                  ),
                );
              },
            ),
            MaterialButton(
              child: Text("withParam",style: _style),
              onPressed: ()=> {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new PushWithParams(),
                  ),
                )
              },
            ),
            MaterialButton(
              child: Text("嵌套路由",style: _style),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NestHome(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
