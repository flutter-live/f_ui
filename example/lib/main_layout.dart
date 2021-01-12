import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart'
    hide
        NavigationRail,
        NavigationRailDestination,
        NavigationRailLabelType,
        ExpansionTile;

/// @description:
///@date: 2020/12/30 18

class CreateRouter {
  final String active;
  final String name;
  final IconData icon;
  final String pathname;
  final Widget components;
  final List<CreateRouter> children;

  CreateRouter({
    @required this.active,
    @required this.name,
    this.children = const <CreateRouter>[],
    this.icon,
    this.pathname,
    this.components,
  });
}

class MainLayout extends StatefulWidget {
  final String selectedIndex;
  final List<CreateRouter> createRouter;
  final String title;

  const MainLayout({
    Key key,
    @required this.selectedIndex,
    @required this.createRouter,
    @required this.title,
  }) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String _zIndex;
  String _selectedIndex;
  PageController controller;
  List<CreateRouter> firstPages = [];
  List<CreateRouter> secPages = [];
  List<CreateRouter> list = [];
  List<CreateRouter> pages = [];
  String subTitle;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex.split('-')[0];
    _zIndex = widget.selectedIndex;
    list = widget.createRouter;
    setFirstRouter();
    setSecRouter();
    pages = getPages(list);
    int index = pages.indexWhere((item) => item.active == _zIndex);
    controller = PageController(initialPage: index);
    if (_selectedIndex != null &&
        _selectedIndex.isNotEmpty &&
        int.parse(_selectedIndex) > 0) {
      CreateRouter item = list.elementAt(int.parse(_selectedIndex) - 1);
      subTitle = item.name;
    }

    updateUI();
    super.initState();
  }

  void setFirstRouter() {
    firstPages.clear();
    list.forEach((e) {
      CreateRouter map = CreateRouter();
      map = e;
      if (map.children != null && map.children.length > 0) {
        map.children.addAll([]);
      }
      firstPages.add(map);
    });
  }

  ///根据一级菜单获取子集
  void setSecRouter() {
    List<String> l = _zIndex.split('-');
    CreateRouter map = list.firstWhere((item) => item.active == l[0]);
    secPages = map.children ?? [];
    updateUI();
  }

  void updateUI() {
    if (mounted) setState(() {});
  }

  List<CreateRouter> getPages(List<CreateRouter> list) {
    List<CreateRouter> ls = [];
    setPages(list, ls);
    return ls;
  }

  void setPages(List<CreateRouter> list, List<CreateRouter> ls) {
    list.forEach((e) {
      if (e.children == null || e.children.length == 0) {
        ls.add(e);
      } else {
        setPages(e.children, ls);
      }
    });
  }

  ///获取最后一层active
  String getLastActive(String i) {
    List<String> l = i.split('-');
    CreateRouter map = list.firstWhere((item) => item.active == l[0]);
    if (map.children != null && map.children.length > 0) {
      return getActive(map.children);
    } else {
      return i;
    }
  }

  String getActive(List<CreateRouter> ls) {
    if (ls[0].children != null && ls[0].children.length > 0) {
      return getActive(ls[0].children);
    }
    return ls[0].active;
  }

  @override
  Widget build(BuildContext context) {
    NavigationRailDestinationItem setExpansionTile(CreateRouter item) {
      ///判斷是否有子集
      bool isChildren =
          item.children != null && item.children.length > 0 ? true : false;
      return NavigationRailDestinationItem(
        index: item.active,
        item: NavigationRailDestination(
          icon: isChildren
              ? (item.icon == null
                  ? SizedBox.shrink()
                  : Icon(item.icon, size: 16))
              : SizedBox.shrink(),
          selectedIcon: isChildren
              ? (item.icon == null
                  ? SizedBox.shrink()
                  : Icon(item.icon, size: 16))
              : SizedBox.shrink(),
          label: Text(
            item.name,
            overflow: TextOverflow.ellipsis,
            textAlign: isChildren ? null : TextAlign.center,
          ),
        ),
        children: [],
      );
    }

    void expansionTiles(
        List<CreateRouter> ls, List<NavigationRailDestinationItem> lt) {
      ls.forEach((e) {
        var d = setExpansionTile(e);

        if (e.children != null && e.children.length > 0) {
          expansionTiles(e.children, d.children);
        }
        lt?.add(d);
      });
    }

    List<NavigationRailDestinationItem> expansionTileItem() {
      List<NavigationRailDestinationItem> listTiles = [];
      expansionTiles(secPages, listTiles);
      return listTiles;
    }

    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                blurRadius: 2.0, //阴影模糊程度
                spreadRadius: 0.5, //阴影扩散程度
              ),
            ]),
            child: Row(
              children: [
                SizedBox(
                  width: 65,
                  child: FNavigationRail(
                    hoverColor: Colors.white.withOpacity(0.2),
                    selectedLabelTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 0.8,
                      decorationThickness: 2.0,
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 0.8,
                      decorationThickness: 2.0,
                    ),
                    unselectedIconTheme: IconThemeData(color: Colors.white),
                    selectedIconTheme: IconThemeData(color: Colors.white),
                    backgroundColor: Theme.of(context).primaryColor,
                    selectedIndex: _selectedIndex,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: (String index) {
                      _selectedIndex = index;
                      _zIndex = getLastActive(index);
                      setSecRouter();
                      int i =
                          pages.indexWhere((item) => item.active == _zIndex);
                      controller.jumpToPage(i);
                      if (int.parse(index) > 0) {
                        CreateRouter item =
                            list.elementAt(int.parse(index) - 1);
                        subTitle = item.name;
                      }

                      updateUI();
                    },
                    destinations: List.generate(
                      firstPages.length,
                      (index) => NavigationRailDestinationItem(
                        index: firstPages[index].active,
                        item: NavigationRailDestination(
                          icon: firstPages[index].icon == null
                              ? SizedBox.shrink()
                              : Icon(firstPages[index].icon),
                          selectedIcon: firstPages[index].icon == null
                              ? SizedBox.shrink()
                              : Icon(firstPages[index].icon),
                          label: Text(firstPages[index].name),
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(thickness: 1, width: 1),
                Offstage(
                  offstage: expansionTileItem().length > 0 ? false : true,
                  child: SizedBox(
                    width: 200,
                    child: FNavigationRail(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      direction: Axis.horizontal,
                      selectedIndex: _zIndex,
                      labelType: NavigationRailLabelType.all,
                      hoverColor:
                          Theme.of(context).primaryColor.withOpacity(0.3),
                      minWidth: 50,
                      onDestinationSelected: (String index) {
                        int i = pages.indexWhere((ele) => ele.active == index);
                        if (i > -1) {
                          _zIndex = index;
                          updateUI();
                          controller.jumpToPage(i);
                        }
                      },
                      selectedLabelTextStyle: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.8,
                        decorationThickness: 2.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.8,
                        color: Colors.black,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(child: Divider()),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        subTitle,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      ),
                                    )),
                                Expanded(child: Divider()),
                              ],
                            )
                          ],
                        ),
                      ),
                      destinations: expansionTileItem(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2.0, 0.0), //阴影xy轴偏移量
                      blurRadius: 2.0, //阴影模糊程度
                      spreadRadius: 0.5, //阴影扩散程度
                    ),
                  ]),
                  child: FAppBar(
                    backgroundColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: List.generate(
                        pages.length, (index) => pages[index].components),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
