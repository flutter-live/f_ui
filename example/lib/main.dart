import 'package:f_ui/cascader/cascader.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart' hide DropdownMenuItem;
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:oktoast/oktoast.dart';

import 'basic/basic_border.dart';
import 'basic/basic_button.dart';
import 'basic/basic_color.dart';
import 'from/fui_cascader.dart';
import 'from/fui_input.dart';
import 'from/fui_select.dart';
import 'main_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FUiApp(
      child: OKToast(
        dismissOtherOnShow: true,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Main(),
        ),
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  List<CreateRouter> list = [
    CreateRouter(
      active: '1',
      name: 'basic',
      icon: Icons.category_outlined,
      children: [
        CreateRouter(
          active: '1-1',
          name: 'Color 色彩',
          components: BasicColor(),
        ),
        CreateRouter(
          active: '1-2',
          name: 'Border 边线',
          components: BasicBorder(),
        ),
        CreateRouter(
          active: '1-3',
          name: 'Button 按钮',
          components: BasicButton(),
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
          components: FuiInput(),
        ),
        CreateRouter(
          active: '2-2',
          name: 'Select 选择器',
          components: FuiSelect(),
        ),
        CreateRouter(
          active: '2-3',
          name: 'Cascader 级联选择器',
          components: FuiCascader(),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: '1-1',
      title: 'F_UI',
      createRouter: list,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String encode;
  String decode;
  TextEditingController usernameCon;
  FocusNode usernameFocusNode;
  ImagePickerPlugin plugin;

  //FileSubmitControllerApi api;
  List _testList = [
    {'no': 1, 'keyword': 'blue'},
    {'no': 2, 'keyword': 'black'},
    {'no': 3, 'keyword': 'red'}
  ];
  List<DropdownMenuItem> _dropdownTestItems;
  int _selectedTest;
  TextEditingController controller;
  FocusNode focusNode;

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = List();
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    _dropdownTestItems = buildDropdownTestItems(_testList);
    usernameCon = TextEditingController();
    usernameFocusNode = FocusNode();
    plugin = ImagePickerPlugin();
    //api = FileSubmitControllerApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '弹出层',
              style: Theme.of(context).textTheme.headline4,
            ),
            FAlert(
              Text('还可以哦'),
              isShowIcon: true,
              type: FAlertType.error,
            ),
            FBorderSideFieldWidget(
              width: 250,
              height: 45,
              controller: usernameCon,
              focusNode: usernameFocusNode,
              textInputAction: TextInputAction.next,
              hintText: 'dome',
              unselectedBorderColor: Colors.black26,
              isBoxShadow: false,
              inputFormatters: [
                IntegerTextInputFormatter(),
                NoMinLengthTextInputFormatter(1),
                NoMaxLengthTextInputFormatter(2),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: FCascader(
                itemWidth: 250,
                itemTextstyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                height: 45,
                width: 250,
                readOnly: true,
                hintText: 'SELECTED',
                focusNode: focusNode,
                controller: controller,
                value: [],
                items: [
                  DropdownMenuItem(
                    value: {'id': 1},
                    child: Text('1'),
                    children: [
                      DropdownMenuItem(value: {'id': 2}, child: Text('1-1')),
                      DropdownMenuItem(
                        value: {'id': 33},
                        child: Text('1-2'),
                        children: [
                          DropdownMenuItem(
                              value: {'id': 3}, child: Text('1-1-1'))
                        ],
                      ),
                    ],
                  ),
                  DropdownMenuItem(
                    value: {'id': 4},
                    child: Text('2'),
                    children: [
                      DropdownMenuItem(value: {'id': 5}, child: Text('2-1')),
                      DropdownMenuItem(value: {'id': 6}, child: Text('2-2')),
                    ],
                  ),
                  DropdownMenuItem(
                    value: {'id': 7},
                    child: Text('3'),
                    children: [
                      DropdownMenuItem(value: {'id': 8}, child: Text('3-1')),
                      DropdownMenuItem(value: {'id': 9}, child: Text('3-2')),
                    ],
                  )
                ],
                onChanged: (item) {
                  print(item);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showToast('111');

          // await getFile();
          //   plugin.pickFile().then((value) async{
          //     print('------------------------------${value.path}');
          //
          //     //print(await MultipartFile.fromPath('file', value.path));
          //     api.uploadTestUsingPOST(await MultipartFile.fromPath('file', value.path));
          //  //   print('===============>>>${await value.readAsBytes()}');
          //   });
          // Loading.show(context);
          //
          // new Timer(new Duration(seconds: 5), () async {
          //   Loading.hide(context);
          // });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
