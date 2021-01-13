import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: 下拉菜单
///@date: 2021/1/13 10
class FuiDropdown extends StatefulWidget {
  @override
  _FuiDropdownState createState() => _FuiDropdownState();
}

class _FuiDropdownState extends State<FuiDropdown> {
  GlobalKey btnKey = GlobalKey();
  MenuItem menuItem;
  List<FMenuItemProvider> list;
  int index = 0;

  @override
  void initState() {
    menuItem = MenuItem(title: 'dome1');
    list = [
      MenuItem(
        title: 'dome1',
        isActive: true,
      ),
      MenuItem(
        title: 'dome2',
        isActive: false,
      ),
      MenuItem(
        title: 'dome3',
        isActive: false,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onClickMenu(FMenuItemProvider item, BuildContext context) {
      index = list.indexWhere((element) => element.menuTitle == item.menuTitle);
      setState(() {
        menuItem.title = item.menuTitle;
      });
    }

    void menuData(GlobalKey btnKey, BuildContext context) {
      List<FMenuItemProvider> setData = new List<FMenuItemProvider>();
      setData.clear();
      for (int i = 0; i <list.length; i++) {
        setData.add(MenuItem(
            title: list[i].menuTitle,
            isActive: index == i));
      }
      FSpearMenu menu = FSpearMenu(
        context: context,
        items: setData,
        onClickMenu: (FMenuItemProvider item) => onClickMenu(item, context),
      );
      menu.show(widgetKey: btnKey);
    }

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Dropdown 下拉菜单', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 10),
          Text('将动作或菜单折叠到下拉菜单中。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 20),
          Text('基础用法', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Text('移动到下拉菜单上，展开更多操作。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 150,
              height: 50,
              child: MaterialButton(
                color: Colors.blueAccent,
                key: btnKey,
                onPressed: () {
                  menuData(btnKey, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menuItem.menuTitle ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.expand_more, size: 20, color: Colors.white)
                  ],
                ),
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
                Text('onClickMenu'),
                Text('点击选项回调'),
                Text('Function(FMenuItemProvider item)'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('context'),
                Text('上下文'),
                Text('BuildContext'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('onDismiss'),
                Text('下拉框取消回调'),
                Text(' Function()'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('backgroundColor'),
                Text('背景颜色'),
                Text('Color'),
                Text('-'),
                Text('Colors.white'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('highlightColor'),
                Text('点击颜色'),
                Text('Color'),
                Text('-'),
                Text('Colors.grey'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('iconColor'),
                Text('图标颜色'),
                Text('Color'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('stateChanged'),
                Text('下拉框显示回调'),
                Text('Function(bool isShow)'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('items'),
                Text('数据源'),
                Text('List<FMenuItemProvider>'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
