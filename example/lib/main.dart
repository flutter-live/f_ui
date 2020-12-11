import 'dart:async';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

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
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Loading.show(context);

          new Timer(new Duration(seconds: 5), () async {
            Loading.hide(context);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  onChangeDropdownTests(selectedTest) {
    controller.text = selectedTest['keyword'];
    int index =
        _testList.indexWhere((e) => selectedTest['keyword'] == e['keyword']);
    print(index);
    setState(() {
      _selectedTest = index;
    });
  }
}
