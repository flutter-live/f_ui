import 'dart:collection';
import 'package:flutter/material.dart';

import 'config/res/colors.dart';
import 'provider/f_ui_theme.dart';

/// @description: ui 入口
///@date: 2020/11/27 14

LinkedHashMap<_FUiAppState, BuildContext> contextMap = LinkedHashMap();

class FUiApp extends StatefulWidget {
  final Widget child;

  final FUiThemeData themeData;

  const FUiApp({Key key, this.themeData, this.child}) : super(key: key);

  @override
  _FUiAppState createState() => _FUiAppState();
}

class _FUiAppState extends State<FUiApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    contextMap.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget overlay = Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (ctx) {
            contextMap[this] = ctx;
            return widget.child;
          },
        ),
      ],
    );
    TextDirection direction = TextDirection.ltr;
    Widget w = Directionality(
      child: overlay,
      textDirection: direction,
    );

    Color accentColor = widget.themeData?.primaryColor ?? FColours.light_primaryColor;

    Color primaryColor = widget.themeData?.primaryColor ?? FColours.light_primaryColor;

    return FUiThemeData(
      child: w,
      primaryColor: primaryColor,
      accentColor: accentColor,
    );
  }
}
