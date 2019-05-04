import 'package:flutter/material.dart';

//void main() => runApp(new PushNoParam());

class PushNoParam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //定义路由
      routes: {
        //Map<String, WidgetBuilder>
        "/login": (context) => new LoginPage(),
        "/home": (context) => new TestMainHome(),
        "/detail": (context) => new DetailPage(),
      },
      //没有路由可以进行匹配的时候
      onUnknownRoute: (RouteSettings setting) {
        String name = setting.name;
        print("onUnknownRoute:$name");
        return new MaterialPageRoute(builder: (context) {
          return new NotFoundPage();
        });
      },
      title: '假设这个是登录界面',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
    );
  }
}

//主页，显示一个列表
class TestMainHome extends StatelessWidget {
  TestMainHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: new AppBar(
            leading: CloseButton(),),
          body: Center(child: Text("假设这个就是主页了"),),),
   );
  }
}

//详细界面
class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: new Container(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text("详细界面"),
              new RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/login", (Route<dynamic> route) => false);
                },
                child: new Text("点击退出登录"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//登录界面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
        title: Text("假设这个是登录界面"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            new RaisedButton(
              child: new Text("点击登录成功，跳转到主页"),
              onPressed: () {
                TestMainHome();
                Navigator.of(context).pushNamed("/home");
//              Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            new RaisedButton(
              child: new Text("点击跳转到NotFoundPage"),
              onPressed: () {
//              跳转到路由错误的界面
                Navigator.of(context).pushNamed("/111");
              },
            ),
            new RaisedButton(
              child: new Text("点击登录成功，自定义动画，跳转到主页"),
              onPressed: () {
//              自定义跳转动画
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        opaque: true,
                        pageBuilder: (BuildContext context, _, __) {
                          return new TestMainHome();
                        },
                        transitionsBuilder: (context, Animation<double> animation,
                            Animation<double> secondaryAnimation, Widget child) {
//                          return FadeTransition(
                          return RotationTransition(
//                          opacity: animation,
                            turns: animation,
                            child: FadeTransition(
                              opacity: Tween<double>(begin: 0, end: 1.0)
                                  .animate(animation),
                              child: child,
                            ),
                          );
                        }));
              },
            ),

            new RaisedButton(
              child: new Text("点击弹出dialog对话框"),
              onPressed: () {
//                _showDialog(context);
               Navigator.push(
                    context,
                    PageRouteBuilder(
                      barrierColor:Color(0x88ffffff),
                        opaque: true,
                        barrierDismissible: true,
                        pageBuilder: (BuildContext context, _, __) {
                          return  _pushDialog(context);
                        },
                      ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

//路由跳转失败的页面
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CloseButton(),),
      body: new Container(
        child: new Center(
          child: new Text("NotFoundPage"),
        ),
      ),
    );
  }
}

//弹出提示框
Widget _pushDialog(BuildContext context) {
  return AlertDialog(
    title: Text('提示'),
    content: Text('这是一个Dialog！'),
    actions: <Widget>[
      FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消')),
      FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('确定'))
    ],
  );
}

  _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) =>_pushDialog(context));
}


////启动页面
//class SplashPage extends StatefulWidget {
//  @override
//  _SplashPageState createState() => _SplashPageState();
//}
//
//class _SplashPageState extends State<SplashPage> {
//  @override
//  void initState() {
//    Future.delayed(Duration(milliseconds: 1)).then((value) {
//      Navigator.of(context).pushReplacementNamed("/login");
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: new Container(
//        child: new Center(
//          child: new Text("splash"),
//        ),
//      ),
//    );
//  }
//}
