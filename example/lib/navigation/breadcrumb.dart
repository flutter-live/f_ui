import 'package:example/res/res.dart';
import 'package:f_ui/bread_crumb/bread_crumb.dart';
import 'package:flutter/material.dart';

/// @description: 面包屑
///@date: 2021/1/13 10
class FuiBreadcrumb extends StatefulWidget {
  @override
  _FuiBreadcrumbState createState() => _FuiBreadcrumbState();
}

class _FuiBreadcrumbState extends State<FuiBreadcrumb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Breadcrumb 面包屑', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 10),
          Text('显示当前页面的路径', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 20),
          Text('基础用法', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Text('适用广泛的基础用法。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FBreadCrumb(
              currentPosition: '当前位置:',
              titleColor: Colors.red,
              children: [
                Text('首页/'),
                Text('活动列表/'),
                Text('活动列表/'),
                Text('活动列表'),
              ],
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
                Text('children'),
                Text('页面路径'),
                Text('List<Widget>'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('height'),
                Text('高'),
                Text('double'),
                Text('-'),
                Text('50'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('currentPosition'),
                Text('标题'),
                Text('String'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('titleColor'),
                Text('标题颜色'),
                Text('Color'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
