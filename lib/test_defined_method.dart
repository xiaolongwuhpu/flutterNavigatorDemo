import 'package:flutter/material.dart';
import 'push_no_param.dart';

class DefinedMethod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DefinedMethodState();
  }
}
class DefinedMethodState extends State<DefinedMethod> {
  @override
  void initState() {
//                - push**        将设置的router信息推送到Navigator上，实现页面跳转。
//                - **of**          主要是获取 Navigator最近实例好的状态。
//                - **pop**         导航到新页面，或者返回到上个页面。
//                - **canPop**      判断是否可以导航到新页面
//                - **maybePop**    可能会导航到新页面
//                - **popAndPushNamed**  指定一个路由路径，并导航到新页面。
//                - **popUntil** 反复执行pop  直到该函数的参数predicate返回true为止。
//                - **pushAndRemoveUntil**  将给定路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
//                - **pushNamed**   将命名路由推送到Navigator。
//                - **pushNamedAndRemoveUntil**  将命名路由推送到Navigator，删除先前的路由，直到该函数的参数predicate返回true为止。
//                - **pushReplacement** 路由替换。
//                - **pushReplacementNamed**  替换路由操作。推送一个命名路由到Navigator，新路由完成动画之后处理上一个路由。
//                - **removeRoute**  从Navigator中删除路由，同时执行Route.dispose操作。
//                - **removeRouteBelow**  从Navigator中删除路由，同时执行Route.dispose操作，要替换的路由是传入参数anchorRouter里面的路由。
//                - **replace**  将Navigator中的路由替换成一个新路由。
//                - **replaceRouteBelow** 将Navigator中的路由替换成一个新路由，要替换的路由是是传入参数anchorRouter里面的路由。

    Navigator.push(context,MaterialPageRoute(builder: (context) => PushNoParam(),));
//                Navigator.of(context),
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
