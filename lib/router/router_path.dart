/// @description: 路由路径实体类
/// @date: 2020/11/3

class RoutePath {
  final String path;
  final bool isUnknown;

  RoutePath.home()
      : path = null,
        isUnknown = false;

  RoutePath.details(this.path) : isUnknown = false;

  RoutePath.unknown()
      : path = null,
        isUnknown = true;

  bool get isHomePage => path == null;

  bool get isDetailsPage => path != null;
}
