import 'package:flutter/material.dart';
import 'nest/nest_home.dart';
import 'nest/setting_page.dart';
import 'push_no_param.dart';
import 'pushname/push_name.dart';
import 'pushwithparam/main_push_with_param.dart';

void main() => runApp(Material(child:MyApp()));

class MyApp extends StatelessWidget {
  GlobalKey<NavigatorState> _navigatorKey=new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mTheme,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new MainApp(),
        '/setting': (BuildContext context) => new SettingPage()
      },
//      navigatorKey,   //navigatorKey.currentState相当于Navigator.of(context)
//      onGenerateRoute,//当通过Navigation.of(context).pushNamed跳转路由时，在routes查找不到时，会调用该方法
//      onUnknownRoute,//效果跟onGenerateRoute一样调用顺序为onGenerateRoute ==> onUnknownRoute
      navigatorObservers: [
        MyObserver(),
      ], //路由观察器，当调用Navigator的相关方法时，会回调相关的操作
    );
  }
}

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
            MaterialButton(
              child: Text("路由场景测试",style: _style),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PushName(),
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



//继承NavigatorObserver
class MyObserver extends NavigatorObserver{
  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    if ((previousRoute is TransitionRoute) && previousRoute.opaque) {
      //全屏不透明，通常是一个page
      if(route !=null && route?.settings.name!=null)
        print("push:不透明的 "+route.settings.name);
    } else {
      //全屏透明，通常是一个弹窗
      if(route !=null && route?.settings.name!=null)
        print("push:透明的 "+route.settings.name);
    }


  }
  @override
  void didPop(Route route, Route previousRoute) {
    // 当调用Navigator.pop时回调
    super.didPop(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    if(route?.settings!=null && route?.settings.name!=null)
    print("pop: "+route?.settings?.name??"");
  }
}

final ThemeData mTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.blue,
  primaryColorBrightness: Brightness.light,
);
TextStyle _style = TextStyle(color: Colors.deepPurpleAccent,fontSize: 18);