import 'package:f_ui/pop_router_animation/pop_router_animation.dart';
import 'package:f_ui/provider/f_ui_theme.dart';
import 'package:flutter/material.dart';

import '../f_ui_app.dart';
import 'loading_indicator.dart';
import 'model/loading_model.dart';

/// @description: 加载
///@date: 2020/11/27 10

class Loading {
  static bool _isShowing = false;

  ///显示系统默认加载
  static show(
    BuildContext context, {
    Duration duration,
    Indicator indicator,
    Color maskColor,
    Color color,
    double radius,
    List<Color> colors,
    bool handleTouch = true,
    Text textWidget,
  }) {
    context ??= contextMap.values.first;

    final theme = FUiThemeData.of(context);
    maskColor ??= Colors.black26;
    color ??= theme.primaryColor;
    indicator ??= Indicator.lineSpinFadeLoader;
    handleTouch ??= true;
    duration ??= const Duration(milliseconds: 200);
    radius ??= 30;

    Widget widget = LoadingIndicator(
      indicatorType: indicator,
      maskColor: maskColor,
      color: color,
      colors: colors,
      radius: radius,
      textWidget: textWidget,
    );

    return showLoadingWidget(
      widget,
      context,
      duration: duration,
      handleTouch: handleTouch,
    );
  }

  ///自定义动画
  static showLoadingWidget(
    Widget widget,
    BuildContext context, {
    Duration duration,
    bool handleTouch,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context ??= contextMap.values.first;
      duration ??= const Duration(milliseconds: 200);
      handleTouch ??= true;

      if (!_isShowing) {
        _isShowing = true;
        Navigator.push(
          context,
          PopRoute(
            duration: duration,
            child: IgnorePointer(
              ignoring: !handleTouch,
              child: widget,
            ),
          ),
        );
      }
    });
  }

  ///关闭加载框
  static void hide(BuildContext context) {
    context ??= contextMap.values.first;
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}
