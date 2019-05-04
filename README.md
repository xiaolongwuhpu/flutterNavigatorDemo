## 1.flutter路由导航

管理多个用户界面有两个核心概念和类：路由（Route）和导航器（Navigator），路由（Route）是应用程序的“屏幕”或“页面”的抽象，导航器（Navigator）管理着路由对象的堆栈并提供管理堆栈的方法。导航器（Navigator）可以推送（push）和弹出（pop）路由来帮助用户从当前屏幕移动到另一个屏幕。

为了导航到新的页面，我们需要调用 Navigator.push 方法。该方法将添加 Route 到路由栈中！
我们可以直接使用 MaterialPageRoute 创建路由，它是一种模态路由，可以通过平台自适应的过渡效果来切换屏幕。

```
Future push(
  BuildContext context,
  Route route
)
// 将给定的路由添加到最靠近给定上下文的导航器的历史记录，并过渡到它

bool pop(
  BuildContext context, [
  result
])
// 从导航器中弹出最靠近给定上下文的路由

```

```
  onTap: () {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new XXXX(),
      ),
    );
  }

```

## 2.路由中部分方法   

- **push**        将设置的router信息推送到Navigator上，实现页面跳转。
- **of**          主要是获取 Navigator最近实例好的状态。
- **pop**         导航到新页面，或者返回到上个页面。
- **canPop**      判断是否可以导航到新页面
- **maybePop**    可能会导航到新页面
- **popAndPushNamed**  指定一个路由路径，并导航到新页面。
- **popUntil** 反复执行pop  直到该函数的参数predicate返回true为止。
- **pushAndRemoveUntil**  将给定路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
- **pushNamed**   将命名路由推送到Navigator。
- **pushNamedAndRemoveUntil**  将命名路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
- **pushReplacement** 路由替换。
- **pushReplacementNamed**  替换路由操作。推送一个命名路由到Navigator，新路由完成动画之后处理上一个路由。
- **removeRoute**  从Navigator中删除路由，同时执行Route.dispose操作。
- **removeRouteBelow**  从Navigator中删除路由，同时执行Route.dispose操作，要替换的路由是传入参数anchorRouter里面的路由。
- **replace**  将Navigator中的路由替换成一个新路由。
- **replaceRouteBelow** 将Navigator中的路由替换成一个新路由，要替换的路由是是传入参数anchorRouter里面的路由。



## 3.自定义路由

通常，我们可能需要定制路由以实现自定义的过渡效果等。定制路由有两种方式：

- 继承路由子类，如：PopupRoute、ModalRoute 等。

- 使用 PageRouteBuilder 类通过回调函数定义路由。   

     

  在页面切换的时候，会有默认的自适应平台的过渡动画。 如果想自定义页面的进场和出场动画，那么需要使用PageRouteBuilder来创建路由。 PageRouteBuilder是主要的部分，一个是“pageBuilder”，用来创建所要跳转到的页面，另一个是**transitionsBuilder**，也就是我们可以自定义的转场效果。    

```
PageRouteBuilder({
    RouteSettings settings,
    @required this.pageBuilder,//构造页面
    this.transitionsBuilder = _defaultTransitionsBuilder,//创建转场动画
    this.transitionDuration = const Duration(milliseconds: 300),//转场动画的持续时间
    this.opaque = true,//是否是透明的
    this.barrierDismissible = false,//比如AlertDialog也是利用PageRouteBuilder进行创建的，barrierDismissible若为false，点击对话框周围，对话框不会关闭；若为true，点击对话框周围，对话框自动关闭。
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  }
```



```
下面使用 PageRouteBuilder 实现一个页面旋转淡出的效果。
onTap: () async {
  String result = await Navigator.push(
      context,
      new PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (context, _, __) =>
            new ContentScreen(articles[index]),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) =>
                new FadeTransition(
                  opacity: animation,
                  child: new RotationTransition(
                    turns: new Tween<double>(begin: 0.0, end: 1.0)
                        .animate(animation),
                    child: child,
                  ),
                ),
      ));

  if (result != null) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text("$result"),
        duration: const Duration(seconds: 1),
      ),
    );
  }
},


Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
            (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
          return new RefreshIndicatorDemo();
        }, transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          // 添加一个平移动画
          return BRouter.createTransition(animation, child);
        }));

平移的变换
/// 创建一个平移变换
  /// 跳转过去查看源代码，可以看到有各种各样定义好的变换
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, 
    );
  }

```

## 嵌套路由

一个 App 中可以有多个导航器，将一个导航器嵌套在另一个导航器下面可以创建一个内部的路由历史。例如：App 主页有底部导航栏，每个对应一个 Navigator，还有与主页处于同一级的全屏页面，如设置页面等。接下来，我们实现这样一个路由结构。

#####  

- 1. 添加 Home 页面 ，底部导航栏切换主页和我的页面。

```
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new PlaceholderWidget('Home'),
    new PlaceholderWidget('Profile'),
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
            title: new Text('Profile'),
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

class PlaceholderWidget extends StatelessWidget {
  final String text;

  PlaceholderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(text),
    );
  }
}
```



- 2. 然后我们将 Home 页面组件使用 Navigator 代替，Navigator 中有两个路由页面：home 和 login。home 显示一个按钮，点击按钮调转到前面的 login 页面。

```
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
```

- 3. 点击按钮跳转到 login 页面后，底部的 tab 栏并没有消失，因为这是在子导航器中进行的跳转。要想显示全屏页面覆盖底栏，我们需要通过根导航器进行跳转，也就是 `MaterialApp` 内部的导航器。

我们在 Profile 页面，点击该按钮会跳转到设置页面。

```
// profile.dart

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Profile'),
      ),
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


// main.dart

import './home.dart';
import './login.dart';
void main() => runApp(new MyApp());

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new MainApp(),
        '/setting': (BuildContext context) => new SettingPage()
      },
    );
  }
```



## 4.命名(静态)导航器路由



通常，移动应用管理着大量的路由，并且最容易的是使用名称来引用它们。路由名称通常使用路径结构：“/a/b/c”，主页默认为 “/”。
创建 MaterialApp 时可以指定 routes 参数，该参数是一个映射路由名称和构造器的 Map。MaterialApp 使用此映射为导航器的 onGenerateRoute 回调参数提供路由。

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomePage('首页'),
      
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new Screen1(),
        '/screen2': (BuildContext context) => new screen2(),
      },
      或者
      routes: <String, WidgetBuilder> {
          '/screen1': (BuildContext context) => new Screen1(),
          '/screen2' : (BuildContext context) => new Screen2(),
          '/screen3' : (BuildContext context) => new Screen3(),
          '/screen4' : (BuildContext context) => new Screen4()
        },
    );
  }
}

```

**Map<String, WidgetBuilder> routes**是应用程序的顶级路由表,当使用Navigator.pushNamed推送命名路由时，将在此映射中查找路由名称。如果名称存在，则相关联的WidgetBuilder将用于构造一个MaterialPageRoute，该新的路由执行适当的过渡。

如果应用程序只有一个页面，那么可以使用home指定它，如果指定了home，那么在此映射中为Navigator.defaultRouteName提供路由是一个错误。如果请求没有在此表中指定的路由（或通过home），则会调用onGenerateRoute回调来构建页面。

路由的跳转时调用 Navigator.pushNamed：

```
Navigator.of(context).pushNamed('/screen1');
```

**But**使用 Navigator.pushNamed 时无法直接给新页面传参数

- URL的拼接方式

可以在 onGenerateRoute 回调中利用 URL 参数自行处理。

```
onGenerateRoute: (RouteSettings settings) {
  WidgetBuilder builder;
  if (settings.name == '/') {
    builder = (BuildContext context) => new ArticleListScreen();
  } else {
    String param = settings.name.split('/')[2];
    builder = (BuildContext context) => new NewArticle(param);
  }

  return new MaterialPageRoute(builder: builder, settings: settings);
},
```

```
// 通过 URL 传递参数
Navigator.of(context).pushNamed('/new/xxx');
```

- map传参

  

```
Navigator.pushNamed(
     context,
     '/weather',
     arguments: <String, String>{
       'city': 'Berlin',
       'country': 'Germany',
     },
   );
   
   或者
   
class MyArguments {
  MyArguments(this.string1, this.string2);

  String string1;
  String string2;
}

TypedDictionary arguments = TypedDictionary..set<MyArguments>(MyArguments('string1', 'string2');

 
```

- bean对象传递

  - 首先定义一个bean对象;

  - 定义一个名字

    ```
    static const routeName = '/pushNameArguments';
    ```

  - **onGenerateRoute**过滤名字

    ```
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
    ```

  - 传递参数

  ```
    Navigator.pushNamed(
                    context,
                    PushNameArgumentsScreen.routeName,
                    arguments: ScreenArguments(
                      'by pushname',
                      '这条消息传递通过 pushName -> arguments',
                    ),
                  );
  
  ```





## 5.使用场景

#### pushReplacementNamed()和popAndPushNamed()

有下面的这种场景，我们进入到Screen3页面后，要跳转到Screen4页面，不过点击返回按钮，并不想回退到Screen3页面。也就是想将Screen4的元素插入栈顶的同时，将Screen3的元素夜进行移除。

![1replace_push](/Users/wujing/Desktop/mdimage/1replace_push.png)

这个时候，我们就要用到pushReplacementNamed()或者popAndPushNamed(),pushReplacement()都可以实现这个目的。

```
Navigator.of(context).pushReplacementNamed('/screen4');
Navigator.popAndPushNamed(context, '/screen4');
Navigator.of(context).pushReplacement(newRoute);
```

#### pushNamedAndRemoveUntil()

一般会有这种场景，我们在已经登录的情况下，在设置界面会有个退出用户登录的按钮，点击后会注销用户退出登录，并且会跳转到登录界面。那么路由栈的变化应该会如下图所示：

![2nameAndremove](/Users/wujing/Desktop/mdimage/2nameAndremove.png)



如果只是简单的进行push一个LoginScreen的操作的话，那么按返回键的话，会回到上一个页面，这样的逻辑是不对的。

所以我们应该删除掉路由栈中的所有route，然后再弹出LoginScreen。这个时候就要用到pushNamedAndRemoveUntil()或者pushAndRemoveUntil()了。

```
typedef RoutePredicate = bool Function(Route<dynamic> route);
//第一个参数context是上下文的context，
//第二个参数newRouteName是新的路由所命名的路径
//第三个参数predicate，返回值是bool类型，按照我的理解，就是用来判断Until所结
//束的时机，如果为false的话，就会一直继续执行Remove的操作，直到为true的时候，停止Remove操作，然后才执行push操作。
  static Future<T> pushNamedAndRemoveUntil<T extends Object>(BuildContext context, String newRouteName, RoutePredicate predicate) {
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(newRouteName, predicate);
  }
```

- 如果想在弹出新路由之前，删除路由栈中的所有路由，那可以使用下面的这种写法，(Route<dynamic> route) => false，这样能保证把之前所有的路由都进行删除，然后才push新的路由。

```
Navigator.of(context).pushNamedAndRemoveUntil('/LoginScreen', (Route<dynamic> route) => false);
```

- 如果想在弹出新路由之前，删除路由栈中的部分路由。比如只弹出Screen1路由上面的Screen3和Screen2，然后再push新的Screen4，堆栈的情况如下图：

![3pnaru](/Users/wujing/Desktop/mdimage/3pnaru.png)

利用ModalRoute.withName(name)，来执行判断，可以看下面的源码，当所传的name跟堆栈中的路由所定义的时候，会返回true值，不匹配的话，则返回false。

```
Navigator.of(context).pushNamedAndRemoveUntil('/screen4',ModalRoute.withName('/screen1'));
 
 //ModalRoute.withName的源码
   static RoutePredicate withName(String name) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally
          && route is ModalRoute
          && route.settings.name == name;
    };
  }
```

### popUntil()

popUntil()方法的过程其实跟上面差不多，就是是少了push一个新页面的操作，只是单纯的进行移除路由操作。

![4popuntil](/Users/wujing/Desktop/mdimage/4popuntil.png)

```
popUntil(RoutePredicate predicate);
Navigator.of(context).popUntil(ModalRoute.withName("/XXX"));
```

##  



```
路由属性详解: 
https://www.jianshu.com/p/31daaed64d8a
```
