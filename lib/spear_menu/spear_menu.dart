library spear_menu;
import 'dart:core';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

abstract class FMenuItemProvider {
  String get menuTitle;

  bool get activeStatus;

  actStatus(bool value);

  TextStyle get menuTextStyle;
}

class MenuItem extends FMenuItemProvider {
  String title; // Menu title
  TextStyle textStyle;
  bool isActive;

  MenuItem({this.title, this.textStyle, this.isActive});

  @override
  String get menuTitle => title;

  @override
  bool get activeStatus => isActive ?? false;

  @override
//  TextStyle get menuTextStyle => textStyle ?? TextStyle(color: Color(0xffc5c5c5), fontSize: 14.0);
  TextStyle get menuTextStyle =>
      textStyle ?? TextStyle(color: Colors.black87, fontSize: 14.0);

  @override
  actStatus(bool value) {
    // TODO: implement actStatus
    isActive = value;
  }
}

typedef MenuClickCallback = Function(FMenuItemProvider item);
typedef SpearMenuStateChanged = Function(bool isShow);

class FSpearMenu {
//  static var itemWidth = 152.0;
  static var itemWidth = 150.0;
  static var itemHeight = 40.0;
  static var arrowHeight = 10.0;
  OverlayEntry _entry;
  List<FMenuItemProvider> items;

  /// row count
  int _row;

  /// The left top point of this menu.
  Offset _offset;

  /// Menu will show at above or under this rect
  Rect _showRect;

  /// if false menu is show above of the widget, otherwise menu is show under the widget
  bool _isDown = true;

  /// callback
  VoidCallback dismissCallback;
  MenuClickCallback onClickMenu;
  SpearMenuStateChanged stateChanged;
  Color iconColor;

  Size _screenSize; // Screen size

  /// Cannot be null
  static BuildContext context;

  /// style
  Color _backgroundColor;
  Color _highlightColor;
  Color _lineColor;

  /// It's showing or not.
  bool _isShow = false;

  bool get isShow => _isShow;

  FSpearMenu(
      {MenuClickCallback onClickMenu,
      BuildContext context,
      VoidCallback onDismiss,
      Color backgroundColor,
      Color highlightColor,
      Color lineColor,
      Color iconColor,
      SpearMenuStateChanged stateChanged,
      List<FMenuItemProvider> items}) {
    this.onClickMenu = onClickMenu;
    this.dismissCallback = onDismiss;
    this.stateChanged = stateChanged;
    this.items = items;
    this.iconColor = iconColor;
    this._backgroundColor = backgroundColor ?? Colors.white;
    this._lineColor = lineColor ?? Colors.grey;
    this._highlightColor = highlightColor ?? Colors.grey;
    if (context != null) {
      FSpearMenu.context = context;
    }
  }

  void show({Rect rect, GlobalKey widgetKey, List<FMenuItemProvider> items}) {
    if (rect == null && widgetKey == null) {
      print("'rect' and 'key' can't be both null");
      return;
    }

    this.items = items ?? this.items;
    this._showRect = rect ?? FSpearMenu.getWidgetGlobalRect(widgetKey);
    this._screenSize = window.physicalSize / window.devicePixelRatio;
    this.dismissCallback = dismissCallback;

    _calculatePosition(FSpearMenu.context);

    _entry = OverlayEntry(builder: (context) {
      return buildSpearMenuLayout(_offset);
    });

    Overlay.of(FSpearMenu.context).insert(_entry);
    _isShow = true;
    if (this.stateChanged != null) {
      this.stateChanged(true);
    }
  }

  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  void _calculatePosition(BuildContext context) {
    _row = items.length;
    _offset = _calculateOffset(FSpearMenu.context);
  }

  Offset _calculateOffset(BuildContext context) {
    double dx = _showRect.left + _showRect.width / 2.0 - menuWidth() / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + menuWidth() > _screenSize.width && dx > 10.0) {
      double tempDx = _screenSize.width - menuWidth() - 10;
      if (tempDx > 10) dx = tempDx;
    }

    double dy = _showRect.top - menuHeight();
    if (dy <= MediaQuery.of(context).padding.top + 10) {
      // The have not enough space above, show menu under the widget.
      dy = arrowHeight + _showRect.height + _showRect.top;
      _isDown = false;
    } else {
      dy -= arrowHeight;
      _isDown = true;
    }

    return Offset(dx, dy);
  }

  double menuWidth() {
    return itemWidth;
  }

  // This height exclude the arrow
  double menuHeight() {
    return itemHeight * _row;
  }

  LayoutBuilder buildSpearMenuLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dismiss();
        },
        onVerticalDragStart: (DragStartDetails details) {
          dismiss();
        },
        onHorizontalDragStart: (DragStartDetails details) {
          dismiss();
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              // triangle arrow
              // Container(
              //   child: Positioned(
              //     left: _showRect.left + _showRect.width / 2.0 - 7.5,
              //     top: _isDown
              //         ? offset.dy + menuHeight()
              //         : offset.dy - arrowHeight,
              //     child: Container(
              //       decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black12,
              //             blurRadius: 10.0, //阴影模糊程度
              //             spreadRadius: 1.0, //阴影扩散程度
              //           ),
              //         ],
              //       ),
              //       child: CustomPaint(
              //         size: Size(15.0, arrowHeight),
              //         painter:
              //             TrianglePainter(isDown: _isDown, color: _backgroundColor),
              //       ),
              //     ),
              //   ),
              // ),
              // menu content
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: Container(
                  width: menuWidth(),
                  height: menuHeight(),
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0, //阴影模糊程度
                        spreadRadius: 5.0, //阴影扩散程度
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: menuWidth(),
                          height: menuHeight(),
                          decoration: BoxDecoration(
                            color: _backgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: _createRows(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  // Create line
  List<Widget> _createRows() {
    List<Widget> rows = [];
    for (int i = 0; i < _row; i++) {
      Color color =
          (i < _row - 1 && _row != 1) ? _lineColor : Colors.transparent;
      Widget rowWidget = Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: color, width: 0.5))),
        height: itemHeight,
        child: Row(
          children: _createRowItems(i),
        ),
      );

      rows.add(rowWidget);
    }

    return rows;
  }

  //Create a line of item,  row Count from 0
  List<Widget> _createRowItems(int row) {
    List<FMenuItemProvider> subItems =
        items.sublist(row, min(row + 1, items.length));
    List<Widget> itemWidgets = [];
    for (var item in subItems) {
      itemWidgets.add(_createMenuItem(item));
    }

    return itemWidgets;
  }

  Widget _createMenuItem(FMenuItemProvider item) {
    return _MenuItemWidget(
      item: item,
      clickCallback: itemClicked,
      iconColor: iconColor,
      backgroundColor: _backgroundColor,
      highlightColor: _highlightColor,
    );
  }

  void itemClicked(FMenuItemProvider item) {
    if (onClickMenu != null) {
      onClickMenu(item);
    }

    dismiss();
  }

  void dismiss() {
    if (!_isShow) {
      // Remove method should only be called once
      return;
    }

    _entry.remove();
    _isShow = false;
    if (dismissCallback != null) {
      dismissCallback();
    }

    if (this.stateChanged != null) {
      this.stateChanged(false);
    }
  }
}

class _MenuItemWidget extends StatefulWidget {
  final FMenuItemProvider item;

//  final Color lineColor;
  final Color backgroundColor;
  final Color highlightColor;
  final Color iconColor;

  final Function(FMenuItemProvider item) clickCallback;

  _MenuItemWidget({
    this.item,
    this.clickCallback,
    this.backgroundColor,
    this.highlightColor,
    this.iconColor,
  });

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
  var highlightColor = Color(0x55000000);
  var color = Color(0xff232323);

  @override
  void initState() {
    color = widget.backgroundColor;
    highlightColor = widget.highlightColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        color = highlightColor;
        setState(() {});
      },
      onTapUp: (details) {
        color = widget.backgroundColor;
        setState(() {});
      },
      onLongPressEnd: (details) {
        color = widget.backgroundColor;
        setState(() {});
      },
      onTap: () {
        if (widget.clickCallback != null) {
          widget.clickCallback(widget.item);
        }
      },
      child: Container(
          width: FSpearMenu.itemWidth,
          height: FSpearMenu.itemHeight,
          decoration: BoxDecoration(
            color: color,
          ),
          child: _createContent()),
    );
  }

  Widget _createContent() {
    bool activeMode = widget.item.activeStatus;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: Text(widget.item.menuTitle,
                  style: widget.item.menuTextStyle.copyWith(
                      fontWeight:
                          activeMode ? FontWeight.bold : FontWeight.normal)),
            ),
          ),
          Visibility(
            visible: activeMode,
            child: Icon(
              Icons.check,
              color: widget.iconColor ?? Colors.blueAccent.shade700,
            ),
          )
        ],
      ),
    );
  }
}
