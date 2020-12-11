import 'dart:ui';

import 'package:f_ui/config/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description: f_ui 主题
///@date: 2020/11/27 14
class FUiThemeData extends InheritedWidget {
  final Color primaryColor;

  final Color accentColor;

  FUiThemeData({
    this.primaryColor,
    this.accentColor,
    Widget child,
  })  : assert(child != null),
        super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static FUiThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FUiThemeData>();
}
