import 'package:flutter/material.dart';

/// @description: 弹出层动画
///
///@date: 2020/11/27 16

class PopRoute extends PopupRoute {
  final Duration duration;
  final Widget child;

  PopRoute({
    @required this.child,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => duration;
}
