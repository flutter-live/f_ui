import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: 输入框
///@date: 2021/1/12 08

class FuiInput extends StatefulWidget {
  @override
  _FuiInputState createState() => _FuiInputState();
}

class _FuiInputState extends State<FuiInput> {
  TextEditingController basicController;
  FocusNode basicFocusNode;
  TextEditingController passwordController;
  FocusNode passwordFocusNode;
  TextEditingController xzController;
  FocusNode xzFocusNode;
  TextEditingController iconController;
  FocusNode iconFocusNode;

  @override
  void initState() {
    basicController = TextEditingController();
    basicFocusNode = FocusNode();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
    xzController = TextEditingController();
    xzFocusNode = FocusNode();
    iconController = TextEditingController();
    iconFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Input 输入框', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 10),
          Text('通过鼠标或键盘输入字符', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 30),
          Text('基础用法(带清空按钮)', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FBorderSideFieldWidget(
                  controller: basicController,
                  focusNode: basicFocusNode,
                  hintText: '基础用法(带清空按钮)',
                  width: 250,
                  height: 45,
                  onTap: () {},
                ),
              ),
              SizedBox(width: 20),
              Text('禁用框', style: FuiSizeOrColor.secSize),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: FBorderSideFieldWidget(
                  hintText: '禁用框',
                  width: 250,
                  height: 45,
                  enabled: false,
                ),
              ),
              SizedBox(width: 20),
              Text('密码框', style: FuiSizeOrColor.secSize),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: FBorderSideFieldWidget(
                  focusNode: passwordFocusNode,
                  controller: passwordController,
                  hintText: '密码框',
                  width: 250,
                  height: 45,
                  obscureText: true,
                ),
              ),
              SizedBox(width: 20),
              Text('自定义图标框', style: FuiSizeOrColor.secSize),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: FBorderSideFieldWidget(
                  focusNode: iconFocusNode,
                  controller: iconController,
                  hintText: '自定义图标框',
                  width: 250,
                  height: 45,
                  suffixIcon: Icon(Icons.print),
                  prefixIcon: Icon(Icons.cancel),
                ),
              ),
              SizedBox(width: 20),
              Text('限制框(只允许输入字母)', style: FuiSizeOrColor.secSize),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: FBorderSideFieldWidget(
                  controller: xzController,
                  focusNode: xzFocusNode,
                  hintText: '限制框',
                  width: 250,
                  height: 45,
                  cursorColor: Colors.red,
                  onTap: () {},
                  inputFormatters: [
                    OnlyLetterTextInputFormatter()
                  ],
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
                Text('hintStyle'),
                Text('提示语样式'),
                Text('TextStyle'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('prefixIcon'),
                Text('左侧图标'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('hintText'),
                Text('提示语'),
                Text('String'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('obscureText'),
                Text('是否密码框'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('width'),
                Text('宽'),
                Text('double'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('height'),
                Text('高'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('textInputAction'),
                Text('输入框动作'),
                Text('TextInputAction'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('controller'),
                Text('输入框控制器'),
                Text('TextEditingController'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('validator'),
                Text('输入框验证'),
                Text('FormFieldValidator<String>'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('focusNode'),
                Text('鼠标触发控制器'),
                Text('FocusNode'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('onFieldSubmitted'),
                Text('提交表单回调'),
                Text('ValueChanged<String>'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('inputFormatters'),
                Text('输入框限制器'),
                Text('List<TextInputFormatter>'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('radius'),
                Text('圆角'),
                Text('double'),
                Text('-'),
                Text('5.0'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('cursorColor'),
                Text('指针颜色'),
                Text('Color'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('contentPadding'),
                Text('内边距'),
                Text('EdgeInsets'),
                Text('-'),
                Text('EdgeInsets.symmetric(horizontal: 10)'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('padding'),
                Text('外边距'),
                Text('Color'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('suffixIcon'),
                Text('右侧图标'),
                Text('Widget'),
                Text('-'),
                Text('-'),
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
                Text('readOnly'),
                Text('禁用（可点击）'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('enabled'),
                Text('禁用'),
                Text('bool'),
                Text('true/false'),
                Text('true'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('inputBackground'),
                Text('输入框背景颜色'),
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
