import 'dart:math';

import 'package:f_ui/router/router.dart';
import 'package:flutter/material.dart';

import 'page.dart';
import 'router_path.dart';

/// @description: 路由
/// @date: 2020-10-28 14:58:47

class PageRouter {
  final String path;
  final String pathName;
  final List<String> navigation;
  final Handler component;
  final List<PageRouter> children;
  final String description;

  PageRouter({
    @required this.path,
    this.component,
    this.pathName,
    @required this.navigation,
    this.children,
    this.description,
  }) : assert(path != null);
}

class Handler {
  Handler({this.type = TransitionType.fadeIn, this.handlerFunc});

  final TransitionType type;
  final HandlerFunc handlerFunc;
}

typedef Widget HandlerFunc(BuildContext context, dynamic data);

class ConfigRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKeyDefault;

  ConfigRouterDelegate(this.navigatorKeyDefault);

  ///是否显示404
  bool show404 = false;

  ///路径
  String _path;

  ///返回值数据
  Map<String, dynamic> _data;

  ///组合的数据
  List<Page<dynamic>> pages = [];

  ///处理数据
  List<PageRouter> list = [];

  ///转场动画
  TransitionType transitionType;

  RoutePath get currentConfiguration {
    if (show404) {
      return RoutePath.unknown();
    }
    return _path == null ? RoutePath.home() : RoutePath.details(_path);
  }

  @override
  Widget build(BuildContext context) {
    ConfigRouter.push = _handleBookTapped;
    _path = _path == null ? '/' : _path;

    list = ConfigRouter.pageRouters
        .where((e) => e.path != ConfigRouter.untils[e.path])
        .toList();

    List<DetailsPage> paths = [];
    if (show404) {
      paths.add(DetailsPage(
        key: ValueKey('UnknownPage${Random.secure()}'),
        transitionType: TransitionType.fadeIn,
        child: ConfigRouter.notFoundWidget(),
      ));
    } else {
      paths = list.map((e) {
        var router =
            ConfigRouter.insideNavigateTo(_path, context);
        if (e.path == router) {
          _path = router;
          return DetailsPage(
            child: e.component.handlerFunc(context, _data),
            transitionType: e.component.type,
            key: ValueKey('$_path${Random.secure()}'),
          );
        }
      }).toList();

      paths = paths.where((e) => e != null).toList();
    }
    return Navigator(
      key: navigatorKey,
      pages: paths,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        _path = null;
        _data = null;
        show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath path) async {
    if (path.isUnknown) {
      _path = null;
      _data = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (RouterUtils.subStr(path.path) == null ||
          !list.any((e) => e.path == RouterUtils.subStr(path.path))) {
        return show404 = true;
      }
      _data = RouterUtils.serialize(path.path);
      _path = path.path;
    } else {
      _path = null;
      _data = null;
    }
    show404 = false;
  }

  void _handleBookTapped(String path) {
    _path = path;
    _data = RouterUtils.serialize(path);
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => navigatorKeyDefault;
}
