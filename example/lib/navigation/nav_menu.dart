import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart'
    hide
        NavigationRail,
        NavigationRailDestination,
        NavigationRailLabelType,
        ExpansionTile;

import '../main_layout.dart';

/// @description: 导航菜单
///@date: 2021/1/13 10

class FuiNavMenu extends StatefulWidget {
  @override
  _FuiNavMenuState createState() => _FuiNavMenuState();
}

class _FuiNavMenuState extends State<FuiNavMenu> {
  String _zIndex = '1-1';
  List<CreateRouter> list = [
    CreateRouter(
      active: '1',
      name: 'basic',
      icon: Icons.category_outlined,
      children: [
        CreateRouter(
          active: '1-1',
          name: 'Color 色彩',
          components: Text('Color 色彩'),
        ),
        CreateRouter(
          active: '1-2',
          name: 'Border 边线',
          components: Text('Border 边线'),
        ),
        CreateRouter(
          active: '1-3',
          name: 'Button 按钮',
          components: Text('Button 按钮'),
        ),
      ],
    ),
    CreateRouter(
      active: '2',
      name: 'Form',
      icon: Icons.format_align_justify_rounded,
      children: [
        CreateRouter(
          active: '2-1',
          name: 'Input 输入框',
          components: Text('Input 输入框'),
        ),
        CreateRouter(
          active: '2-2',
          name: 'Select 选择器',
          components: Text('Select 选择器'),
        ),
        CreateRouter(
          active: '2-3',
          name: 'Cascader 级联选择器',
          components: Text('Cascader 级联选择器'),
        ),
      ],
    ),
  ];

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
      expansionTiles(list, listTiles);
      return listTiles;
    }

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('NavMenu 导航菜单', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 10),
          Text('为网站提供导航功能的菜单。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 20),
          Text('侧栏', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Text('垂直菜单，可内嵌子菜单。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200,
              height: 500,
              child: FNavigationRail(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                direction: Axis.horizontal,
                selectedIndex: _zIndex,
                labelType: NavigationRailLabelType.all,
                hoverColor: Theme.of(context).primaryColor.withOpacity(0.3),
                minWidth: 50,
                onDestinationSelected: (String index) {
                  _zIndex = index;
                  setState(() {});
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
                destinations: expansionTileItem(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('参数说明', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Table(
            children: [
              TableRow(children: [
                Text('参数'),
                Text('说明'),
                Text('类型'),
                Text('可选值'),
                Text('默认值'),
                Text('是否必填'),
              ]),
              TableRow(children: [
                Text('backgroundColor'),
                Text('背景色'),
                Text('Color'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('leading'),
                Text('顶部部件'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('trailing'),
                Text('底部部件'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('destinations'),
                Text('导航数据'),
                Text('List<NavigationRailDestinationItem>'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('selectedIndex'),
                Text('默认选中'),
                Text('String'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('onDestinationSelected'),
                Text('点击回调'),
                Text('void Function(T value)'),
                Text('-'),
                Text('30'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('elevation'),
                Text('阴影'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('0'),
              ]),
              TableRow(children: [
                Text('unselectedLabelTextStyle'),
                Text('未选中样式'),
                Text('TextStyle'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('selectedLabelTextStyle'),
                Text('选中样式'),
                Text('TextStyle'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('minWidth'),
                Text('宽度'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('minExtendedWidth'),
                Text('展开宽度'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('direction'),
                Text('排列方式'),
                Text('Axis'),
                Text('-'),
                Text('Axis.vertical'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('padding'),
                Text('边距'),
                Text('EdgeInsets'),
                Text('-'),
                Text('EdgeInsets.all(0)'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('hoverColor'),
                Text('点击颜色，鼠标经过颜色'),
                Text('Color'),
                Text('-'),
                Text(''),
                Text('否'),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
