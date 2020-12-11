import 'package:f_ui/hover_border/hover_border.dart';
import 'package:f_ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';

double squareUnitWidth = 40;
double cntPerPageWidgetWidth = 180;

/// ====================================
///
///   页码分为以下几种显示格式：
///   b: 起始页数，即1
///   e: 最大页数
///   c: 当前页数
///   1. 1=<c<=4 :                  显示： 1,2,3,4,5 ... 50
///   2. 4<c<e-3 :                    显示：1 ... c-1, c, c+1 ... 50
///   3. e-3<=c<=e :               显示:   1 ... 46,47,48,49,50
///   4. e<=6 :                         显示： 1,2,3,4,5,6
///
/// ====================================

class FPager extends StatefulWidget {
  final int totalCnt;
  final int currentIndex;
  final int cntPerPage;
  final Function(int value) onCntPerPageChange;
  final Function(int index) onPageNumberChange;
  final bool isLoading;

  FPager({
    Key key,
    @required this.totalCnt,
    this.currentIndex = 1,
    this.cntPerPage = 20,
    this.onCntPerPageChange,
    this.onPageNumberChange,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _FPager createState() => _FPager(currentIndex, cntPerPage);
}

class _FPager extends State<FPager> with TickerProviderStateMixin {
  _FPager(this.currentIndex, this.cntPerPage);

  int currentIndex;
  int cntPerPage;
  int totalPageCnt;
  TextEditingController cntPerPageCon = TextEditingController();
  FocusNode cntPerPageFocus = FocusNode();
  bool isCntPerPageInputActive = false;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    cntPerPageFocus.addListener(() {
      //print('[pager] cnt per page focus: ${cntPerPageFocus.hasFocus}');
      if (cntPerPageFocus.hasFocus) {
        isCntPerPageInputActive = true;
        updateUI();
      } else {
        isCntPerPageInputActive = false;
        updateUI();
      }
    });

    /// 提交共两种途径：
    /// 1. 键盘的enter提交（包括手机端的虚拟键盘），使用 [_onCntPerPageSubmit] 函数执行
    /// 2. 点击屏幕其他区域取消输入栏激活状态时，进行提交，使用下列总线事件监听执行
    // EventBus().addListener(EventKey.submitCntPerPage, (value) {
    //   //print('[pager] submit new cntperpage');
    //   assert(value is int);
    //   if (value == cntPerPage) return;
    //   cntPerPage = value;
    //   if (widget.onCntPerPageChange != null) widget.onCntPerPageChange(value);
    //   cntPerPageCon.clear();
    //
    //   /// 清空以便下次输入时为空白状态
    //   updateUI();
    // });
  }

  void updateUI() {
    if (mounted) setState(() {});
  }

  /// 实时记录有效的每页数据值，以随时响应两种提交方式
  void _onCntPerPageChanged(String v) {
    if (!Utils.isInt(v)) {
      cntPerPageCon.clear();
      updateUI();
      return;
    }
    var text = int.parse(v);
  }

  /// 通过键盘enter提交
  void _onCntPerPageSubmit(String v) {
    if (!Utils.isInt(v)) {
      /// not int
      return;
    }
    var text = int.parse(v);
    cntPerPage = text;
    if (widget.onCntPerPageChange != null)
      widget.onCntPerPageChange(cntPerPage);
    cntPerPageCon.clear();

    /// 清空以便下次输入时为空白状态
    updateUI();
    // EventBus().commit(EventKey.deactivateInputFields);
  }

  Widget getCntPerPageWidget() {
    return GestureDetector(
      onTap: () {
        //FocusScope.of(context).requestFocus(cntPerPageFocus);
        cntPerPageFocus.requestFocus();
      },
      child: FHoverBorder(
        width: cntPerPageWidgetWidth,
        height: squareUnitWidth,
        isActive: isCntPerPageInputActive,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// cnt field
            Container(
                width: 40,
                //color: Colors.red,
                child: Stack(
                  children: [
                    /// cnt
                    Offstage(
                        offstage: isCntPerPageInputActive,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            cntPerPage.toString(),
                            style: TextStyle(color: Colors.black45),
                          ),
                        )),

                    /// input cnt
                    Offstage(
                      offstage: !isCntPerPageInputActive,
                      child: TextField(
                        controller: cntPerPageCon,
                        focusNode: cntPerPageFocus,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                          //focusedBorder: InputBorder.none,
//                              hintText: (cntPerPage).toString(),
//                              hintStyle: MenuTextStyle,
                        ),
                        onChanged: _onCntPerPageChanged,
                        onSubmitted: _onCntPerPageSubmit,
                        style: TextStyle(
                          height: 1.1,
                        ),
                      ),
                    )
                  ],
                )),

            /// text: "records per page"
            Expanded(
              child: Container(
                //color: Colors.yellow,
                alignment: Alignment.centerLeft,
                child: Text(
                  '条/页',
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getPreviousButton() {
    return Container(
        margin: EdgeInsets.only(right: 10),
        child: FHoverBorder(
          width: squareUnitWidth,
          onTap: () {
            if (currentIndex != 1) {
              currentIndex = max(1, currentIndex - 1);
              updateUI();
              _onPageNumChange();
            }
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black38),
        ));
  }

  Widget getNextButton() {
    return Container(
        margin: EdgeInsets.only(right: 10),
        child: FHoverBorder(
          width: squareUnitWidth,
          onTap: () {
            if (currentIndex != totalPageCnt) {
              currentIndex = min(totalPageCnt, currentIndex + 1);
              updateUI();
              _onPageNumChange();
            }
          },
          child: Icon(Icons.arrow_forward_ios, color: Colors.black38),
        ));
  }

  Widget getElipsis() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment(0, -1),
      child: Text(
        '...',
        style: TextStyle(color: Colors.black38, fontSize: 16),
      ),
    );
  }

  Widget getLoadingWidget() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment(0, -1),
      child: Container(
          width: squareUnitWidth,
          height: squareUnitWidth,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          //margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey.withOpacity(0.3))),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black38),
            strokeWidth: 3,
          )),
    );
  }

  void _onPageNumChange() {
    if (widget.onPageNumberChange != null)
      widget.onPageNumberChange(currentIndex);
  }

  Widget getPageNumberUnit(int num) {
    var active = false;
    if (num == currentIndex) {
      active = true;
    }
    //print('[page] in get page number unit: $num');
    return Container(
      key: Key(num.toString() + active.toString()),
      margin: EdgeInsets.only(right: 10),
      child: FHoverBorder(
        width: squareUnitWidth,
        isActive: active,
        onTap: () {
          if (!active) {
            currentIndex = num;
            updateUI();
            _onPageNumChange();
          }
        },
        child: Text(
          num.toString(),
          style: TextStyle(color: Colors.black38, fontSize: 16),
        ),
      ),
    );
  }

  List<Widget> getBody() {
    /// ====================================
    ///
    ///   页码分为以下几种显示格式：
    ///   b: 起始页数，即1
    ///   e: 最大页数
    ///   c: 当前页数
    ///   1. 1=<c<=4 :                  显示： 1,2,3,4,5 ... 50
    ///   2. 4<c<e-3 :                    显示：1 ... c-1, c, c+1 ... 50
    ///   3. e-3<=c<=e :               显示:   1 ... 46,47,48,49,50
    ///   4. e<=6 :                         显示： 1,2,3,4,5,6
    ///   5. is loading :                   显示： loading indicator
    ///
    /// ====================================

    List<Widget> children = [];

    /// 第5种情况
    if (widget.isLoading) {
      //print('[pager] 当前正在加载...}');
      children = [
        getPreviousButton(),
        getLoadingWidget(),
        getNextButton(),
        getCntPerPageWidget(),
      ];
    }

    /// 第4种情况
    else if (totalPageCnt <= 6 && !widget.isLoading) {
      //print('[pager] 总页数小于6: $totalPageCnt');
      var list = List<int>.generate(totalPageCnt, (index) => index + 1);
      //print('[pager] list: $list');
      children = list.map((e) => getPageNumberUnit(e)).toList();
      children.insert(0, getPreviousButton());
      children.add(getNextButton());
      children.add(getCntPerPageWidget());
    } else if (currentIndex >= 1 && currentIndex <= 4) {
      //print('[pager] 当前页码大于等于1小于等于4');
      var list = [1, 2, 3, 4, 5];
      children = list.map((e) => getPageNumberUnit(e)).toList();
      children.insert(0, getPreviousButton());
      children.add(getElipsis());
      children.add(getPageNumberUnit(totalPageCnt));
      children.add(getNextButton());
      children.add(getCntPerPageWidget());
    } else if (currentIndex > 4 && currentIndex < totalPageCnt - 3) {
      //print('[pager] 当前页码大于4小于${totalPageCnt-3}');
      var list = [currentIndex - 1, currentIndex, currentIndex + 1];
      children = list.map((e) => getPageNumberUnit(e)).toList();
      children.insert(0, getElipsis());
      children.insert(0, getPageNumberUnit(1));
      children.insert(0, getPreviousButton());
      children.add(getElipsis());
      children.add(getPageNumberUnit(totalPageCnt));
      children.add(getNextButton());
      children.add(getCntPerPageWidget());
    } else if (currentIndex >= totalPageCnt - 3 &&
        currentIndex <= totalPageCnt) {
      //print('[pager] 当前页码大于${totalPageCnt-3}小于$totalPageCnt');
      var list = [
        totalPageCnt - 4,
        totalPageCnt - 3,
        totalPageCnt - 2,
        totalPageCnt - 1,
        totalPageCnt
      ];
      children = list.map((e) => getPageNumberUnit(e)).toList();
      children.insert(0, getElipsis());
      children.insert(0, getPageNumberUnit(1));
      children.insert(0, getPreviousButton());
      children.add(getNextButton());
      children.add(getCntPerPageWidget());
    }
    //print('[pager] children done：$children');
    return children;
  }

  Widget build(BuildContext context) {
    totalPageCnt = (widget.totalCnt / cntPerPage).ceil();
    currentIndex = widget.currentIndex;
    return Row(
      children: getBody(),
    );
  }
}
