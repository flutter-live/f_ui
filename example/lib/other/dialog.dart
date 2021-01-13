import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: 折叠面板
///@date: 2021/1/13 13

class _OpenDialog extends StatefulWidget {
  @override
  __OpenDialogState createState() => __OpenDialogState();
}

class __OpenDialogState extends State<_OpenDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FDialog(
        margin: const EdgeInsets.all(20),
        children: [Text('这是一个弹出框')],
        cancelWidget: Text('返回'),
        confirmWidget: Text('确认'),
        confirm: () {
          Navigator.of(context).pop(true);
        },
        cancel: () => Navigator.pop(context, false),
      ),
    );
  }
}

class FuiDialog extends StatefulWidget {
  @override
  _FuiDialogState createState() => _FuiDialogState();
}

class _FuiDialogState extends State<FuiDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Collapse 折叠面板', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 10),
          Text('通过折叠面板收纳内容区域。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 20),
          Text('基础用法', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FCommonButtons(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('点击打开 Dialog'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CustomRoute(
                    opaque: false,
                    child: _OpenDialog(),
                  ),
                );
              },
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
                Text('width'),
                Text('宽'),
                Text('double'),
                Text('-'),
                Text('500.0'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('height'),
                Text('高'),
                Text('double'),
                Text('-'),
                Text('250.0'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('alignment'),
                Text('对齐方式'),
                Text('Alignment'),
                Text('-'),
                Text('Alignment.center'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('children'),
                Text('内容'),
                Text('List<Widget>'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('margin'),
                Text('边距'),
                Text('EdgeInsets'),
                Text('-'),
                Text('EdgeInsets.only(top: 30)'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('contentAlignment'),
                Text('内容对齐方式'),
                Text('EdgeInsets'),
                Text('-'),
                Text('Alignment.center'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('buttons'),
                Text('底部按钮'),
                Text('List<Widget>'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('confirmWidget'),
                Text('确认按钮'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('cancelWidget'),
                Text('取消按钮'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('confirm'),
                Text('点击确认按钮回调'),
                Text('Function()'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('cancel'),
                Text('取消确认按钮回调'),
                Text('Function()'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('footerButtonHeight'),
                Text('底部高度'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('child'),
                Text('内容'),
                Text('Widget'),
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
