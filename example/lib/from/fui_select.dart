import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: 选择器
///@date: 2021/1/12 08
class FuiSelect extends StatefulWidget {
  @override
  _FuiSelectState createState() => _FuiSelectState();
}

class _FuiSelectState extends State<FuiSelect> {
  TextEditingController basicController;
  FocusNode basicFocusNode;
  TextEditingController xzController;
  FocusNode xzFocusNode;

  @override
  void initState() {
    basicController = TextEditingController();
    basicFocusNode = FocusNode();
    xzController = TextEditingController(text: '默认值');
    xzFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Select 输入框', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 30),
          Text('基础用法', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FSelect(
                  itemWidth: 250,
                  itemTextstyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  height: 45,
                  width: 250,
                  readOnly: false,
                  hintText: '请选择',
                  focusNode: basicFocusNode,
                  controller: basicController,
                  value: 1,
                  items: [
                    DropdownMenuItem(value: 1, child: Text('1')),
                    DropdownMenuItem(value: 2, child: Text('2')),
                  ],
                  onChanged: (item) {
                    basicController.text = item.toString();
                  },
                ),
              ),
              SizedBox(height: 20),
              Text('禁用选择', style: FuiSizeOrColor.secSize),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: FSelect(
                  itemWidth: 250,
                  itemTextstyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  height: 45,
                  width: 250,
                  isDisable: false,
                  hintText: '请选择',
                  focusNode: xzFocusNode,
                  controller: xzController,
                  value: 1,
                  items: [
                    DropdownMenuItem(value: 1, child: Text('1')),
                    DropdownMenuItem(value: 2, child: Text('2')),
                  ],
                  onChanged: (item) {
                    xzController.text = item.toString();
                  },
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
                Text('items'),
                Text('下拉值'),
                Text('List<DropdownMenuItem<T>>'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('value'),
                Text('选中值'),
                Text('int'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('itemTextstyle'),
                Text('下拉框样式'),
                Text('TextStyle'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('itemWidth'),
                Text('下拉框宽度'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('width'),
                Text('输入框宽'),
                Text('double'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('height'),
                Text('输入框高'),
                Text('double'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('onChanged'),
                Text('选择回调方法'),
                Text('Widget Function(BuildContext context, Widget child)'),
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
                Text('controller'),
                Text('输入框控制器'),
                Text('TextEditingController'),
                Text('-'),
                Text('-'),
                Text('是'),
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
                Text('readOnly'),
                Text('禁用（可点击）'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('isDisable'),
                Text('禁用'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),

            ],
          ),
        ],
      ),
    );
  }
}
