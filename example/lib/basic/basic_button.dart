import 'package:example/res/res.dart';
import 'package:f_ui/button/button.dart';
import 'package:f_ui/model/button_model.dart';
import 'package:flutter/material.dart';

/// @description: 按钮
///@date: 2021/1/11 20
class BasicButton extends StatefulWidget {
  @override
  _BasicButtonState createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Button 按钮', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 20),
          Text('填充按钮 Elevated', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FCommonButtons(
                  child: Text('填充按钮'),
                  radius: 10,
                  padding: const EdgeInsets.all(20),
                  elevation: 2,
                  onTap: (){},
                ),
              ),
              SizedBox(width: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: FCommonButtons(
                  child: Text('填充按钮'),
                  radius: 10,
                  padding: const EdgeInsets.all(20),
                  elevation: 2,
                ),
              ),
            ],
          ),
          Text('边框按钮 Outlined', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FCommonButtons(
                  child: Text('填充按钮'),
                  radius: 10,
                  buttonType: ButtonType.Outlined,
                  padding: const EdgeInsets.all(20),
                  elevation: 2,
                  onTap: (){},
                ),
              ),
              SizedBox(width: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: FCommonButtons(
                  child: Text('填充按钮'),
                  radius: 10,
                  buttonType: ButtonType.Outlined,
                  padding: const EdgeInsets.all(20),
                  elevation: 2,
                ),
              ),
            ],
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
                Text('onTap'),
                Text('点击回调的方法, 不填写就是禁用状态'),
                Text('Function'),
                Text('-'),
                Text('-'),
                Text('否'),
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
