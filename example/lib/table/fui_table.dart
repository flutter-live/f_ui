import 'dart:math';

import 'package:example/res/res.dart';
import 'package:f_ui/f_ui.dart';
import 'package:flutter/material.dart';

/// @description: 表格
///@date: 2021/1/12 19

class FuiTable extends StatefulWidget {
  @override
  _FuiTableState createState() => _FuiTableState();
}

class _FuiTableState extends State<FuiTable> {
  List<FDatatableHeader> _headers = [
    FDatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.right),
    FDatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 2,
        editable: true,
        sortable: true,
        textAlign: TextAlign.left),
    FDatatableHeader(
        text: "SKU",
        value: "sku",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    FDatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    FDatatableHeader(
        text: "Price",
        value: "price",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    FDatatableHeader(
        text: "Margin",
        value: "margin",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    FDatatableHeader(
        text: "In Stock",
        value: "in_stock",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    FDatatableHeader(
        text: "Alert",
        value: "alert",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    FDatatableHeader(
        text: "Received",
        value: "received",
        show: true,
        sortable: false,
        sourceBuilder: (value, row, index) {
          List list = List.from(value);
          return Container(
            child: Column(
              children: [
                Container(
                  width: 85,
                  child: LinearProgressIndicator(
                    value: list.first / list.last,
                  ),
                ),
                Text("${list.first} of ${list.last}")
              ],
            ),
          );
        },
        textAlign: TextAlign.center),
  ];

  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  int _currentPerPage = 20;
  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _source = List<Map<String, dynamic>>();
  List<int> _selecteds = List<int>();
  String _selectableKey = "id";

  String _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;

  List<Map<String, dynamic>> _generateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    var i = _source.length;
    for (var data in source) {
      temps.add({
        "id": i,
        "sku": "$i\000$i",
        "name": "Product Product Product Product $i",
        "category": "Category-$i",
        "price": "${i}0.00",
        "cost": "20.00",
        "margin": "${i}0.20",
        "in_stock": "${i}0",
        "alert": "5",
        "received": [i + 20, 150]
      });
      i++;
    }
    return temps;
  }

  _initData() async {
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _source.addAll(_generateData(n: 1000));
      setState(() => _isLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Cascader 级联选择器', style: FuiSizeOrColor.firstSize),
          SizedBox(height: 30),
          Text('基础用法', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Container(
            height: 500,
            child: FResponsiveDatatable(
                title: !_isSearch
                    ? RaisedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text("ADD CATEGORY"))
                    : null,
                actions: [
                  if (_isSearch)
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  _isSearch = false;
                                });
                              }),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search), onPressed: () {})),
                    )),
                  if (!_isSearch)
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _isSearch = true;
                          });
                        })
                ],
                headers: _headers,
                source: _source,
                selecteds: _selecteds,
                showSelect: _showSelect,
                autoHeight: false,
                hideUnderline: false,
                onTabRow: (data) {},
                onSort: (value) {
                  setState(() {
                    _sortColumn = value;
                    _sortAscending = !_sortAscending;
                    if (_sortAscending) {
                      _source.sort((a, b) =>
                          b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                    } else {
                      _source.sort((a, b) =>
                          a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                    }
                  });
                },
                sortAscending: _sortAscending,
                sortColumn: _sortColumn,
                isLoading: _isLoading,
                onSelect: (value, item) {
                  if (value) {
                    setState(() => _selecteds.add(item['id']));
                  } else {
                    setState(() =>
                        _selecteds.removeAt(_selecteds.indexOf(item['id'])));
                  }
                },
                onSelectAll: (value) {
                  if (value) {
                    setState(() => _selecteds =
                        _source.map((entry) => entry['id']).toList().cast());
                  } else {
                    setState(() => _selecteds.clear());
                  }
                },
                footers: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: FPager(
                      isLoading: _isLoading,
                      totalCnt: _total,
                      cntPerPage: _currentPerPage,
                      currentIndex: _currentPage,
                      onCntPerPageChange: (v) async {
                        setState(() {
                          _currentPerPage = v;
                        });
                      },
                      onPageNumberChange: (i) async {
                        setState(() {
                          _currentPage = i;
                        });
                      },
                    ),
                  )
                ]),
          ),
          SizedBox(height: 20),
          Text('参数说明(FDatatableHeader)', style: FuiSizeOrColor.secSize),
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
                Text('text'),
                Text('显示的文本'),
                Text('String'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('textWidget'),
                Text('自定义显示的文本'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('value'),
                Text('数据显示的值（要与数据key值对应）'),
                Text('String'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('show'),
                Text('是否显示此列'),
                Text('bool'),
                Text('true/false'),
                Text('true'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('sortable'),
                Text('排序'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('editable'),
                Text('是否开修改表格'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('flex'),
                Text('列所占百分比'),
                Text('int'),
                Text('-'),
                Text('1'),
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
                Text('headerBuilder'),
                Text('自定义头部'),
                Text('Widget Function(dynamic value)'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('sourceBuilder'),
                Text('自定义数据表格'),
                Text('Widget Function(dynamic value, Map<String, dynamic> row, int index)'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
            ],
          ),
          SizedBox(height: 20),
          Text('参数说明(FResponsiveDatatable)', style: FuiSizeOrColor.secSize),
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
                Text('showSelect'),
                Text('是否选中选中'),
                Text('bool'),
                Text('true/false'),
                Text('true'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('headers'),
                Text('表格列头部'),
                Text('List<FDatatableHeader>'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('source'),
                Text('数据原'),
                Text('List<Map<String, dynamic>>'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('selecteds'),
                Text('多选选中数据'),
                Text('List<int>'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('totalCnt'),
                Text('总数'),
                Text('int'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('title'),
                Text('头部'),
                Text('Widget'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('footers'),
                Text('底部选择栏'),
                Text('List<Widget>'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('onSelectAll'),
                Text('全选回调'),
                Text('Function(bool value)'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('onSelect'),
                Text('选中回调'),
                Text('Function(bool value, Map<String, dynamic> data)'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('onTabRow'),
                Text('点击行回调'),
                Text('Function(dynamic value)'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('onSort'),
                Text('点击排序回调'),
                Text('Function(dynamic value)'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('sortColumn'),
                Text('选中的列title'),
                Text('String'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('sortAscending'),
                Text('判断显示排序的图标'),
                Text('String'),
                Text('-'),
                Text('-'),
                Text('否（开启排序功能为必填）'),
              ]),
              TableRow(children: [
                Text('isLoading'),
                Text('记载显示'),
                Text('bool'),
                Text('true/false'),
                Text('false'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('autoHeight'),
                Text('默认高度'),
                Text('bool'),
                Text('true/false'),
                Text('true'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('hideUnderline'),
                Text('编辑框（开启编辑功能）'),
                Text('bool'),
                Text('true/false'),
                Text('true'),
                Text('否'),
              ]),
              TableRow(children: [
                Text('maxSelect'),
                Text('最大选择数'),
                Text('int'),
                Text('-'),
                Text('-'),
                Text('否'),
              ]),
            ],
          ),
          SizedBox(height: 20),
          Text('参数说明(FPager)', style: FuiSizeOrColor.secSize),
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
                Text('totalCnt'),
                Text('总数'),
                Text('int'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('currentIndex'),
                Text('当前页'),
                Text('int'),
                Text('-'),
                Text('1'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('cntPerPage'),
                Text('每页显示的条数'),
                Text('int'),
                Text('-'),
                Text('20'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('onCntPerPageChange'),
                Text('自定义显示条数回调'),
                Text('Function(int value)'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('onPageNumberChange'),
                Text('切换页数回调'),
                Text('Function(int index)'),
                Text('-'),
                Text('-'),
                Text('是'),
              ]),
              TableRow(children: [
                Text('isLoading'),
                Text('加载动画'),
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
