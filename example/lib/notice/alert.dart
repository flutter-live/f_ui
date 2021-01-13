import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: alert 警告
///@date: 2021/1/13 08

class FuiAlert extends StatefulWidget {
  @override
  _FuiAlertState createState() => _FuiAlertState();
}

class _FuiAlertState extends State<FuiAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Alert 警告', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 10),
          Text('用于页面展示重要的提示信息', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 20),
          Text('基本用法', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('还可以哦'),
              type: FAlertType.error,
              isLeading: false,
            ),
          ),
          SizedBox(height: 20),
          Text('自定义关闭按钮', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Text('自定义关闭按钮为文字或其他符号。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('自定义 close-text'),
              type: FAlertType.error,
              isLeading: false,
              closeWidget: Text('知道了', style: TextStyle(color: Colors.white, fontSize: 13),),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('设置了回调的 alert'),
              isLeading: false,
              closeWidget: const Icon(Icons.clear, color: Colors.white, size: 18),
              type: FAlertType.error,
              close: (){
                print('回调了');
              },
            ),
          ),
          SizedBox(height: 20),
          Text('带有 icon', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Text('表示某种状态时提升可读性。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('成功提示的文案'),
              type: FAlertType.success,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('错误提示的文案'),
              type: FAlertType.error,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('警告提示的文案'),
              type: FAlertType.warning,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('消息提示的文案'),
              type: FAlertType.info,
            ),
          ),
          SizedBox(height: 20),
          Text('带有 icon 和辅助性文字介绍', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FAlert(
              Text('成功提示的文案'),
              closeWidget: const Icon(Icons.clear, color: Colors.white, size: 18),
              description: Text('文字说明文字说明文字说明', overflow: TextOverflow.ellipsis,),
              type: FAlertType.success,
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
                Text('title'),
                Text('标题'),
                Text('Text'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('width'),
                Text('宽'),
                Text('double'),
                Text('-'),
                Text('600'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('backgroundColor'),
                Text('主题颜色'),
                Text('Color'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('icon'),
                Text('自定义图标'),
                Text('Icon'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('isLeading'),
                Text('是否显示图标'),
                Text('bool'),
                Text('true/false'),
                Text('true'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('type'),
                Text('主题'),
                Text('FAlertType'),
                Text('success/warning/info/error'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('radius'),
                Text('圆角'),
                Text('double'),
                Text('-'),
                Text('10'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('closeWidget'),
                Text('自定义关闭文本'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('close'),
                Text('关闭回调'),
                Text('CloseFunc'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('alignment'),
                Text('对齐方式'),
                Text('MainAxisAlignment'),
                Text('-'),
                Text('MainAxisAlignment.start'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('description'),
                Text('描述文本'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('textPadding'),
                Text('边距'),
                Text('EdgeInsetsGeometry'),
                Text('-'),
                Text('const EdgeInsets.symmetric(horizontal: 20, vertical: 0)'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('textStyle'),
                Text('文本样式'),
                Text('TextStyle'),
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
