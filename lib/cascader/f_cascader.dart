import 'package:f_ui/config/res/resources.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'custom_cascader_widget.dart';

/// @description: 选择器
///@date: 2020/11/25 19

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);

/// *[_kDropdownMenuDuration] which is dropdown button's drop down duration.

const double _kMenuItemHeight = 48.0;

/// *[_kMenuItemHeight] which is dropdown item's default height

const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);

/// *[_kMenuItemPadding] which is dropdown item's default padding.

const EdgeInsets _kAlignedMenuMargin = EdgeInsets.zero;

/// *[_kAlignedMenuMargin] which is dropdown item's default margin

const EdgeInsetsGeometry _kUnalignedMenuMargin =
    EdgeInsetsDirectional.only(start: 16.0, end: 24.0);

/// *[_kAlignedMenuMargin] which is dropdown item's default margin for align rule.

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    this.color,
    this.elevation,
    this.selectedIndex,
    this.resize,
  })  : _painter = new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(5),
                boxShadow: kElevationToShadow[elevation])
            .createBoxPainter(),
        super(repaint: resize);

  final Color color;

  /// *[color] which is dropdown item's background color

  final int elevation;

  /// *[elevation] which is dropdown whole item list's elevation

  final int selectedIndex;

  /// *[selectedIndex] which is selected item's index

  final Animation<double> resize;

  /// *[resize] which is resized animation value

  final BoxPainter _painter;

  /// *[_painter] which is panting value

  @override
  void paint(Canvas canvas, Size size) {
    final double selectedItemOffset =
        selectedIndex * _kMenuItemHeight + kMaterialListPadding.top;
    final Tween<double> top = new Tween<double>(
      begin: selectedItemOffset.clamp(0.0, size.height - _kMenuItemHeight),
      end: 0.0,
    );

    final Tween<double> bottom = new Tween<double>(
      begin:
          (top.begin + _kMenuItemHeight).clamp(_kMenuItemHeight, size.height),
      end: size.height,
    );

    final Rect rect = new Rect.fromLTRB(
        0.0, top.evaluate(resize), size.width, bottom.evaluate(resize));

    _painter.paint(
        canvas, rect.topLeft, new ImageConfiguration(size: rect.size));
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.resize != resize;
  }
}

class _DropdownScrollBehavior extends ScrollBehavior {
  const _DropdownScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) =>
      Theme.of(context).platform;

  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

class _DropdownMenu extends StatefulWidget {
  const _DropdownMenu({
    Key key,
    this.padding,
    this.route,
    this.selected,
  }) : super(key: key);

  final _DropdownRoute route;

  /// flutter's dropdown is same as go to new route.
  /// So *[route] means setting new route

  final EdgeInsets padding;
  final List<int> selected;

  /// padding.

  @override
  _DropdownMenuState createState() => new _DropdownMenuState();
}

class _DropdownMenuState extends State<_DropdownMenu> {
  CurvedAnimation _resize;
  Widget widget1;
  Widget widget2;
  Widget widget3;
  double width;
  Map<String, dynamic> result1;
  Map<String, dynamic> result2;
  Map<String, dynamic> result3;

  @override
  void initState() {
    super.initState();

    _resize = new CurvedAnimation(
      parent: widget.route.animation,
      curve: const Interval(0, 0),
      reverseCurve: const Threshold(0.0),
    );
  }

  Widget widgetFun1(route, localizations) {
    final List<Widget> children = <Widget>[];
    for (int itemIndex = 0; itemIndex < route.items.length; ++itemIndex) {
      bool flag = widget.selected.any(
          (e) => e.toString() == route.items[itemIndex].value['id'].toString());
      children.add(
        new InkWell(
          child: new Container(
            padding: widget.padding,
            child: DefaultTextStyle(
              style: TextStyle(
                  color: flag ? FColours.light_primaryColor : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  route.items[itemIndex],
                  if (route.items[itemIndex]?.children != null &&
                      route.items[itemIndex].children.length > 0)
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: flag ? FColours.light_primaryColor : Colors.black,
                    )
                  else if (flag)
                    Icon(
                      Icons.check,
                      size: 16,
                      color: FColours.light_primaryColor,
                    ),
                ],
              ),
            ),
          ),
          onTap: () {
            result1 = route.items[itemIndex].value;
            if (route.items[itemIndex]?.children == null &&
                route.items[itemIndex].children.length == 0) {
              Navigator.pop(
                context,
                new _DropdownRouteResult([result1]),
              );
            } else {
              widget3 = null;
              widget2 = widgetFun2(route.items[itemIndex].children, localizations);

              setState(() {});
            }
          },
        ),
      );
    }
    return Container(
      width: widget.route.itemWidth,
      height: 250,
      child: new CustomPaint(
        painter: new _DropdownMenuPainter(
          color: Colors.white,
          selectedIndex: widget.route.selectedIndex,
          resize: _resize,
        ),
        child: new Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: new Material(
            type: MaterialType.transparency,
            textStyle: widget.route.style,
            child: new ScrollConfiguration(
              behavior: const _DropdownScrollBehavior(),
              child: new Scrollbar(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 250,
                  ),
                  child: new ListView(
                    controller: widget.route.scrollController,
                    padding: kMaterialListPadding,
                    itemExtent: _kMenuItemHeight,
                    shrinkWrap: true,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetFun2(items, localizations) {
    final List<Widget> children = <Widget>[];
    for (int itemIndex = 0; itemIndex < items.length; ++itemIndex) {
      bool flag = widget.selected
          .any((e) => e.toString() == items[itemIndex].value['id'].toString());

      children.add(
        new InkWell(
          child: new Container(
            padding: widget.padding,
            child: DefaultTextStyle(
              style: TextStyle(
                  color: flag ? FColours.light_primaryColor : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  items[itemIndex],
                  if (items[itemIndex]?.children != null &&
                      items[itemIndex].children.length > 0)
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: flag ? FColours.light_primaryColor : Colors.black,
                    )
                  else if (flag)
                    Icon(
                      Icons.check,
                      size: 16,
                      color: FColours.light_primaryColor,
                    ),
                ],
              ),
            ),
          ),
          onTap: () {
            result2 = items[itemIndex].value;
            if (items[itemIndex]?.children == null ||
                items[itemIndex].children.length == 0) {
              Navigator.pop(
                context,
                new _DropdownRouteResult([result1, result2]),
              );
            } else {
              widget3 = widgetFun3(items[itemIndex].children, localizations);

              setState(() {});
            }
          },
        ),
      );
    }

    return Container(
      width: widget.route.itemWidth,
      height: 250,
      child: new CustomPaint(
        painter: new _DropdownMenuPainter(
          color: Colors.white,
          selectedIndex: widget.route.selectedIndex,
          resize: _resize,
        ),
        child: new Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: new Material(
            type: MaterialType.transparency,
            textStyle: widget.route.style,
            child: new ScrollConfiguration(
              behavior: const _DropdownScrollBehavior(),
              child: new Scrollbar(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 250,
                  ),
                  child: new ListView(
                    controller: widget.route.scrollController,
                    padding: kMaterialListPadding,
                    itemExtent: _kMenuItemHeight,
                    shrinkWrap: true,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetFun3(items, localizations) {
    final List<Widget> children = <Widget>[];
    for (int itemIndex = 0; itemIndex < items.length; ++itemIndex) {
      bool flag = widget.selected
          .any((e) => e.toString() == items[itemIndex].value['id'].toString());
      children.add(
        new InkWell(
          child: new Container(
            padding: widget.padding,
            child: DefaultTextStyle(
              style: TextStyle(
                  color: flag ? FColours.light_primaryColor : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  items[itemIndex],
                  if (items[itemIndex]?.children != null &&
                      items[itemIndex].children.length > 0)
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: flag ? FColours.light_primaryColor : Colors.black,
                    )
                  else if (flag)
                    Icon(
                      Icons.check,
                      size: 16,
                      color: FColours.light_primaryColor,
                    ),
                ],
              ),
            ),
          ),
          onTap: () {
            result3 = items[itemIndex].value;
            Navigator.pop(
              context,
              new _DropdownRouteResult([result1, result2, result3]),
            );
          },
        ),
      );
    }

    return Container(
      width: widget.route.itemWidth,
      height: 250,
      child: new CustomPaint(
        painter: new _DropdownMenuPainter(
          color: Colors.white,
          selectedIndex: widget.route.selectedIndex,
          resize: _resize,
        ),
        child: new Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: new Material(
            type: MaterialType.transparency,
            textStyle: widget.route.style,
            child: new ScrollConfiguration(
              behavior: const _DropdownScrollBehavior(),
              child: new Scrollbar(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 250,
                  ),
                  child: new ListView(
                    controller: widget.route.scrollController,
                    padding: kMaterialListPadding,
                    itemExtent: _kMenuItemHeight,
                    shrinkWrap: true,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final _DropdownRoute route = widget.route;

    widget1 = widgetFun1(route, localizations);
    if (widget1 != null) {
      width = widget.route.itemWidth;
    }

    if (widget1 != null && widget2 != null) {
      width = widget.route.itemWidth * 2;
    }

    if (widget1 != null && widget2 != null && widget3 != null) {
      width = widget.route.itemWidth * 3;
    }

    return Container(
      width: width,
      height: 250,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(0),
        child: Row(
          children: [
            if (widget1 != null) widget1,
            if (widget2 != null) widget2,
            if (widget3 != null) widget3,
          ],
        ),
      ),
    );
  }
}

class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T result;

  @override
  bool operator ==(dynamic other) {
    if (other is! _DropdownRouteResult<T>) return false;
    final _DropdownRouteResult<T> typedOther = other;
    return result == typedOther.result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _DropdownRoute extends PopupRoute<_DropdownRouteResult> {
  _DropdownRoute({
    this.items,
    this.itemWidth,
    this.padding,
    this.buttonRect,
    this.selectedIndex,
    this.elevation = 8,
    this.theme,
    @required this.style,
    this.barrierLabel,
    this.selected,
  }) : assert(style != null);

  final List<DropdownMenuItem> items;

  /// item's list

  final EdgeInsetsGeometry padding;

  final Rect buttonRect;

  /// buttons rectangle

  final int selectedIndex;

  /// selected Index

  final int elevation;
  final ThemeData theme;
  final TextStyle style;
  final List<int> selected;

  ScrollController scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  final String barrierLabel;

  final double itemWidth;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    assert(debugCheckHasDirectionality(context));
    final double screenHeight = MediaQuery.of(context).size.height;
    final double maxMenuHeight = screenHeight - 2.0 * _kMenuItemHeight;
    final double preferredMenuHeight =
        (items.length * _kMenuItemHeight) + kMaterialListPadding.vertical;
    final double menuHeight = math.min(maxMenuHeight, preferredMenuHeight);

    final double buttonTop = buttonRect.top;
    final double selectedItemOffset =
        selectedIndex * _kMenuItemHeight + kMaterialListPadding.top;
    double menuTop = (buttonTop - selectedItemOffset) -
        (_kMenuItemHeight - buttonRect.height) / 2.0;
    const double topPreferredLimit = _kMenuItemHeight;
    if (menuTop < topPreferredLimit)
      menuTop = math.min(buttonTop, topPreferredLimit);
    double bottom = menuTop + menuHeight;
    final double bottomPreferredLimit = screenHeight - _kMenuItemHeight;
    if (bottom > bottomPreferredLimit) {
      bottom = math.max(buttonTop + _kMenuItemHeight, bottomPreferredLimit);
      //menuTop = bottom - menuHeight;
    }

    if (scrollController == null) {
      double scrollOffset = 0.0;
      if (preferredMenuHeight > maxMenuHeight)
        scrollOffset = selectedItemOffset - (buttonTop - menuTop);
      scrollController =
          new ScrollController(initialScrollOffset: scrollOffset);
    }

    final TextDirection textDirection = Directionality.of(context);

    Widget menu = new _DropdownMenu(
      route: this,
      selected: selected,
      padding: padding.resolve(textDirection),
    );

    if (theme != null) menu = new Theme(data: theme, child: menu);

    Size size = MediaQuery.of(context).size;

    double left;
    return new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: new Builder(
        builder: (BuildContext context) {
          switch (textDirection) {
            case TextDirection.rtl:
              left = buttonRect.right.clamp(0.0, size.width) - itemWidth * 3;
              break;
            case TextDirection.ltr:
              left = buttonRect.left.clamp(0.0, size.width - itemWidth * 3);
              break;
          }

          return Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: menuTop + 13, left: left + 15),
              child: menu,
            ),
          );
          // return new CustomSingleChildLayout(
          //   delegate: new _DropdownMenuRouteLayout<T>(
          //     itemWidth: itemWidth * 3,
          //     buttonRect: buttonRect,
          //     menuTop: menuTop,
          //     menuHeight: menuHeight,
          //     textDirection: textDirection,
          //   ),
          //   child: menu,
          // );
        },
      ),
    );
  }

  void _dismiss() {
    navigator?.removeRoute(this);
  }
}

typedef ValueWidgetBuilder = Widget Function(
    BuildContext context, Widget child);

class FCascader extends StatefulWidget {
  FCascader({
    Key key,
    @required this.items,
    this.value,
    this.itemTextstyle,
    this.itemWidth,
    this.height,
    this.width,
    this.selectTextStyle,
    @required this.onChanged,
    this.elevation = 8,
    this.style,
    this.iconSize = 24.0,
    this.isDisable = true,
    this.builder,
    this.hintText,
    this.controller,
    this.readOnly = false,
    this.focusNode,
  })  : assert(controller != null),
        super(key: key);
  final List<DropdownMenuItem> items;

  /// item list

  final List<int> value;

  /// printed value

  final double itemWidth;

  /// each item width

  final double height;

  final double width;

  final TextStyle selectTextStyle;

  /// default box text style

  final TextStyle itemTextstyle;

  /// default each item's text style

  final ValueChanged onChanged;

  /// click item then, function triggered

  final int elevation;
  final TextStyle style;
  final double iconSize;

  /// if you use icon this value designate icon size

  final bool isDisable;

  ///add custom widget
  final ValueWidgetBuilder builder;

  ///hintText
  final String hintText;

  final TextEditingController controller;

  final bool readOnly;

  final FocusNode focusNode;

  @override
  _FCascaderState createState() => new _FCascaderState();
}

class _FCascaderState extends State<FCascader>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  _DropdownRoute _dropdownRoute;
  bool isOnTap = false;
  AnimationController _controller;

  @override
  void initState() {
    widget.focusNode?.addListener(() {
      if (isOnTap) {
        FocusScope.of(context).requestFocus(widget.focusNode);
      }
    });
    WidgetsBinding.instance.addObserver(this);
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeDropdownRoute();
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _removeDropdownRoute();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
  }

  TextStyle get _textStyle =>
      widget.style ?? Theme.of(context).textTheme.subhead;

  void _handleTap() {
    isOnTap = true;
    _controller.forward();
    final RenderBox itemBox = context.findRenderObject();
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsetsGeometry menuMargin =
        ButtonTheme.of(context).alignedDropdown
            ? _kAlignedMenuMargin
            : _kUnalignedMenuMargin;

    assert(_dropdownRoute == null);
    _dropdownRoute = new _DropdownRoute(
        itemWidth: widget.itemWidth,
        items: widget.items,
        buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
        padding: _kMenuItemPadding.resolve(textDirection),
        selectedIndex: -1,
        elevation: widget.elevation,
        theme: Theme.of(context),
        style: _textStyle,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        selected: widget.value);
    Navigator.push(context, _dropdownRoute)
        .then<void>((_DropdownRouteResult newValue) {
      isOnTap = false;
      widget.focusNode?.unfocus();
      _controller.reverse();
      _dropdownRoute = null;
      if (!mounted || newValue == null) return;
      if (widget.onChanged != null) widget.onChanged(newValue.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return new Semantics(
      button: true,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: FCustomCascaderWidget(
          controller: widget.controller,
          hintText: widget.hintText,
          readOnly: widget.readOnly,
          enabled: widget.isDisable,
          animationController: _controller,
          focusNode: widget.focusNode,
          onTap: _handleTap,
        ),
      ),
    );
  }
}

class DropdownMenuItem extends _DropdownMenuItemContainer {
  /// Creates an item for a dropdown menu.
  ///
  /// The [child] argument is required.
  const DropdownMenuItem({
    Key key,
    this.onTap,
    this.value,
    this.children,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  /// Called when the dropdown menu item is tapped.
  final VoidCallback onTap;

  /// The value to return if the user selects this menu item.
  ///
  /// Eventually returned in a call to [DropdownButton.onChanged].
  final Map<String, dynamic> value;

  final List<DropdownMenuItem> children;
}

class _DropdownMenuItemContainer extends StatelessWidget {
  /// Creates an item for a dropdown menu.
  ///
  /// The [child] argument is required.
  const _DropdownMenuItemContainer({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: _kMenuItemHeight),
      alignment: AlignmentDirectional.centerStart,
      child: child,
    );
  }
}
