import 'package:f_ui/config/res/resources.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'custom_select_widget.dart';

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

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    Key key,
    this.padding,
    this.route,
    this.selected,
  }) : super(key: key);

  final _DropdownRoute<T> route;

  /// flutter's dropdown is same as go to new route.
  /// So *[route] means setting new route

  final EdgeInsets padding;
  final T selected;

  /// padding.

  @override
  _DropdownMenuState<T> createState() => new _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  CurvedAnimation _fadeOpacity;
  CurvedAnimation _resize;

  @override
  void initState() {
    super.initState();
    _fadeOpacity = new CurvedAnimation(
      parent: widget.route.animation,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = new CurvedAnimation(
      parent: widget.route.animation,
      curve: const Interval(0.25, 0.5),
      reverseCurve: const Threshold(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;
    final double unit = 0.5 / (route.items.length + 1.5);
    final List<Widget> children = <Widget>[];
    for (int itemIndex = 0; itemIndex < route.items.length; ++itemIndex) {
      CurvedAnimation opacity;
      if (itemIndex == route.selectedIndex) {
        opacity = new CurvedAnimation(
            parent: route.animation, curve: const Threshold(0.0));
      } else {
        final double start = (0.5 + (itemIndex + 1) * unit).clamp(0.0, 1.0);
        final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
        opacity = new CurvedAnimation(
            parent: route.animation, curve: new Interval(start, end));
      }
      children.add(new FadeTransition(
        opacity: opacity,
        child: new InkWell(
          child: new Container(
            padding: widget.padding,
            child: DefaultTextStyle(
              style: TextStyle(
                  color: itemIndex == widget.selected
                      ? FColours.light_primaryColor
                      : Colors.black),
              child: route.items[itemIndex],
            ),
          ),
          onTap: () => Navigator.pop(
            context,
            new _DropdownRouteResult<T>(route.items[itemIndex].value),
          ),
        ),
      ));
    }

    return new FadeTransition(
      opacity: _fadeOpacity,
      child: new CustomPaint(
        painter: new _DropdownMenuPainter(
          color: Colors.white,
          elevation: 2,
          selectedIndex: route.selectedIndex,
          resize: _resize,
        ),
        child: new Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: new Material(
            type: MaterialType.transparency,
            textStyle: route.style,
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
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    @required this.buttonRect,
    @required this.menuTop,
    @required this.menuHeight,
    @required this.textDirection,
    @required this.itemWidth,
  });

  final double itemWidth;

  /// dropdown button's each item's width

  final Rect buttonRect;

  /// dropdown button's whole list rect.

  final double menuTop;
  final double menuHeight;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxHeight =
        math.max(0.0, constraints.maxHeight - 2 * _kMenuItemHeight);
    return new BoxConstraints(
      minWidth: itemWidth,
      maxWidth: itemWidth,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        assert(menuTop >= 0.0);
      }
      return true;
    }());
    assert(textDirection != null);
    double left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = buttonRect.right.clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = buttonRect.left.clamp(0.0, size.width - childSize.width);
        break;
    }
    return new Offset(left + 15, menuTop + 13);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        menuTop != oldDelegate.menuTop ||
        menuHeight != oldDelegate.menuHeight ||
        textDirection != oldDelegate.textDirection;
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

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
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

  final List<DropdownMenuItem<T>> items;

  /// item's list

  final EdgeInsetsGeometry padding;

  final Rect buttonRect;

  /// buttons rectangle

  final int selectedIndex;

  /// selected Index

  final int elevation;
  final ThemeData theme;
  final TextStyle style;
  final T selected;

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
    Widget menu = new _DropdownMenu<T>(
      route: this,
      selected: selected,
      padding: padding.resolve(textDirection),
    );

    if (theme != null) menu = new Theme(data: theme, child: menu);

    return new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: new Builder(
        builder: (BuildContext context) {
          return new CustomSingleChildLayout(
            delegate: new _DropdownMenuRouteLayout<T>(
              itemWidth: itemWidth,
              buttonRect: buttonRect,
              menuTop: menuTop,
              menuHeight: menuHeight,
              textDirection: textDirection,
            ),
            child: menu,
          );
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

class FSelect<T> extends StatefulWidget {
  FSelect({
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
  })  : assert(
            controller != null,
            items
                    .where((DropdownMenuItem<T> item) => item.value == value)
                    .length ==
                1),
        super(key: key);
  final List<DropdownMenuItem<T>> items;

  /// item list

  final T value;

  /// printed value

  final double itemWidth;

  /// each item width

  final double height;

  final double width;

  final TextStyle selectTextStyle;

  /// default box text style

  final TextStyle itemTextstyle;

  /// default each item's text style

  final ValueChanged<T> onChanged;

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
  _FSelectState<T> createState() => new _FSelectState<T>();
}

class _FSelectState<T> extends State<FSelect<T>>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  _DropdownRoute<T> _dropdownRoute;
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
    _dropdownRoute = new _DropdownRoute<T>(
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
        .then<void>((_DropdownRouteResult<T> newValue) {
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
        child: FCustomSelectWidget(
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
