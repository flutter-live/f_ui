import 'package:flutter/material.dart';

import 'router_delegate.dart';
import 'router_utils.dart';
export 'route_information_parser.dart';
export 'router_delegate.dart';
export 'router_utils.dart';
export 'custom_router_animated.dart';

/// @description: 路由参数配置
/// 注意： 点击跳转拦截和内部路由跳转拦截有可能会重复执行拦截方法
/// 点击拦截路由 先执行 不能拦截web手动输入的路由，拦截的内容可能会丢失
/// 内部拦截后执行 可以拦截到在web手动输入的路由，拦截的比较全面
/// ******建议统一用内部拦截
/// ******点击跳转拦截会性能更好些，因为在路由跳转的一些逻辑之前就拦截，路由少性能方面可忽略不计
/// @date: 2020-10-28 15:06:56

typedef bool Intercept(String path);

typedef String InsideIntercept(String path, BuildContext context);

class ConfigRouter {
  static Function(String path) push;

  static List<PageRouter> pageRouters;

  static Intercept intercept;

  static Widget Function() notFoundWidget;

  static InsideIntercept insideIntercept;

  static Map<String, dynamic> untils = Map();

  ///设置点击跳转拦截路由
  setIntercept(Intercept fun) => intercept = fun;

  ///设置内部路由跳转拦截路由
  setInsideIntercept(InsideIntercept fun) => insideIntercept = fun;

  ///添加路由
  setPageRouters(List<PageRouter> routers) => pageRouters = routers;

  ///沒有找到页面
  notFound(Widget Function() fun) => notFoundWidget = fun;

  ///点击跳转跳转拦截
  navigateTo(String path, {String pushAndRemoveUntil}) {
    if (pushAndRemoveUntil != null && pushAndRemoveUntil.isNotEmpty) {
      untils.addAll({
        RouterUtils.subStr(pushAndRemoveUntil):
            RouterUtils.subStr(pushAndRemoveUntil)
      });
    }
    if (RouterUtils.subStr(path) != null) {
      if ((untils[RouterUtils.subStr(path)] != null ? true : false)) {
        untils.remove(untils[RouterUtils.subStr(path)]);
      }
    }
    push(path);
  }

  ///内部路由跳转拦截
  static String insideNavigateTo(String path, BuildContext context) => insideIntercept(path, context);

}
