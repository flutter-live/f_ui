import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: 边线
///@date: 2021/1/11 20

class BasicBorder extends StatefulWidget {
  @override
  _BasicBorderState createState() => _BasicBorderState();
}

class _BasicBorderState extends State<BasicBorder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Border 边框', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 20),
          Text('鼠标经过添加边框', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FHoverBorder(
              width: 300,
              height: 50,
              isActive: false,
              child: Text('鼠标经过出现边框'),
              onTap: () {},
            ),
          ),
          SizedBox(height: 20),
          Text('参数说明', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Table(
            columnWidths: const {
              //列宽
              0: FixedColumnWidth(100.0),
              1: FixedColumnWidth(200.0),
              2: FixedColumnWidth(100.0),
            },
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
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('height'),
                Text('高'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('margin'),
                Text('边距'),
                Text('EdgeInsets'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('isActive'),
                Text('是否被选中'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('onTap'),
                Text('点击回调的方法'),
                Text('Function'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('child'),
                Text('需要显示的小部件'),
                Text('Widget'),
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
