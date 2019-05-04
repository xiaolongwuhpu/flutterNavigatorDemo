import 'package:flutter/material.dart';
import 'package:navigator_learning/nest/login.dart';


class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Navigator(
      initialRoute: 'home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home':
            builder = (BuildContext context) => new HomePage();
            break;
          case 'login':
            builder = (BuildContext context) => Login();
            break;
          default:
            throw new Exception('Invalid route: ${settings.name}');
        }

        return new MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child: new Text('go->login'),
          onPressed: () {
            Navigator.of(context).pushNamed('login');
          },
        ),
      ),
    );
  }
}