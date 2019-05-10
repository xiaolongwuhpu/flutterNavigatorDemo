import 'package:flutter/material.dart';

class PushName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      onGenerateRoute: (settings) {
//        if (settings.name == PushNameArgumentsScreen.routeName) {
//          final ScreenArguments args = settings.arguments;
//          return MaterialPageRoute(
//            builder: (context) {
//              return PushNameArgumentsScreen(
//                title: args.title,
//                message: args.message,
//              );
//            },
//          );
//
//      },
      routes: {
        '/homescreen': (BuildContext context) => HomeScreen(),
        '/screen1': (BuildContext context) => Screen1(),
        '/screen2': (BuildContext context) => Screen2(),
        '/screen3': (BuildContext context) => Screen3(),
        '/screen4': (BuildContext context) => Screen4()
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
      body: CommonWidget(context),
    );
  }

  @override
  StatelessElement createElement() {
    // TODO: implement createElement

    return super.createElement();
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Screen1'),
      ),
      body: CommonWidget(context),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen2'),
      ),
      body: CommonWidget(context),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen3'),
      ),
      body: CommonWidget(context),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen4'),
      ),
      body: CommonWidget(context),
    );
  }
}

Widget CommonWidget(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text("to1"),
          onPressed: () {
            Navigator.of(context).pushNamed("/screen1");
          },
        ),
        RaisedButton(
          child: Text("to2"),
          onPressed: () {
            Navigator.of(context).pushNamed("/screen2");
          },
        ),
        RaisedButton(
          child: Text("to3"),
          onPressed: () {
            Navigator.of(context).pushNamed("/screen3");
          },
        ),
        RaisedButton(
          child: Text("to4"),
          onPressed: () {
            Navigator.of(context).pushNamed("/screen4");
          },
        ),
        RaisedButton(
          child: Text("pushNamedAndRemoveUntil"),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/screen4', ModalRoute.withName('/screen1'));
          },
        ),
      ],
    ),
  );
}
