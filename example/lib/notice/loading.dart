import 'dart:async';

import 'package:example/res/res.dart';
import 'package:f_ui/button/button.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: 加载
///@date: 2021/1/13 10

class FuiLoading extends StatefulWidget {
  @override
  _FuiLoadingState createState() => _FuiLoadingState();
}

class _FuiLoadingState extends State<FuiLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Loading 加载', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 10),
          Text('加载数据时显示动效。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 20),
          Text('整页加载', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Text('页面数据加载时显示。', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FCommonButtons(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('指令方式'),
              ),
              onTap: () {
                Loading.show(context);
                new Timer(new Duration(seconds: 3), () async {
                  Loading.hide(context);
                });
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
                Text('context'),
                Text('上下文'),
                Text('BuildContext'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('duration'),
                Text('出现动画时间'),
                Text('Duration'),
                Text('-'),
                Text('Duration(milliseconds: 200)'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('indicator'),
                Text('动画样式'),
                Text('Indicator'),
                Text('-'),
                Text('Indicator.lineSpinFadeLoader'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('maskColor'),
                Text('背景颜色'),
                Text('Color'),
                Text('-'),
                Text('Colors.black26'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('color'),
                Text('图标颜色'),
                Text('Color'),
                Text('-'),
                Text('跟随主题'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('radius'),
                Text('圆角'),
                Text('double'),
                Text('-'),
                Text('30'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('colors'),
                Text('渐变颜色'),
                Text('List<Color>'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('textWidget'),
                Text('带文本的加载层'),
                Text('Text'),
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
