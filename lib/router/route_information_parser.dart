import 'package:f_ui/router/router.dart';
import 'package:flutter/material.dart';

import 'router_path.dart';

/// @description: RouteInformationParser 内部含有一个钩子函数，接受路由信息（RouteInformation），我们可以在这里将它转换成指定的数据类型（BookRoutePath）并使用 Uri 解析：
/// @date: 2020-10-28 15:06:56
class ConfigRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    String path = routeInformation.location;
    Map<String, dynamic> untils = ConfigRouter.untils;
    if (RouterUtils.subStr(path) != null) {
      if ((untils[RouterUtils.subStr(path)] != null ? true : false)) {
        untils.remove(untils[RouterUtils.subStr(path)]);
      }
    }

    List<PageRouter> list = ConfigRouter.pageRouters
        .where((e) => e.path != untils[e.path])
        .toList();

    final uri = Uri.parse(routeInformation.location);
    if (uri.pathSegments.length == 0) {
      return RoutePath.home();
    }
    if (uri.pathSegments.length >= 1) {
      if (!list.any((e) => e.path == RouterUtils.subStr(path))) {
        return RoutePath.unknown();
      } else {
        return RoutePath.details(path);
      }
    }

    return RoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '${path.path}');
    }
    return null;
  }
}
