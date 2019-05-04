import 'package:flutter/material.dart';


class PushWithParams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == PushNameArgumentsScreen.routeName) {
          final ScreenArguments args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return PushNameArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
      },
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("push -> arguments"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PushArgumentsScreen(),
                    settings: RouteSettings(
                      arguments: ScreenArguments(
                        'by push',
                        '这条消息传递通过 push -> arguments',
                      ),
                    ),
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text("pushnamed -> arguments"),
              onPressed: () {
                // When the user taps the button, navigate to a named route
                // and provide the arguments as an optional parameter.
                Navigator.pushNamed(
                  context,
                  PushNameArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    ' by pushname ',
                    '这条消息传递通过 pushName -> arguments',
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

class PushArgumentsScreen extends StatelessWidget {
//  static const routeName = '/puishArguments';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}


class PushNameArgumentsScreen extends StatelessWidget {
  static const routeName = '/pushNameArguments';

  final String title;
  final String message;

  const PushNameArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
