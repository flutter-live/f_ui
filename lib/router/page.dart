import 'package:flutter/material.dart';

/// @description: 继承Page  可以自定义动画
/// @date: 2020/11/3

enum TransitionType {
  native,
  nativeModal,
  inFromLeft,
  inFromTop,
  inFromRight,
  inFromBottom,
  fadeIn,
  scaleFade,
  custom,
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,
  none,
}

class DetailsPage extends Page {
  final Widget child;
  final TransitionType transitionType;

  DetailsPage(
      {Key key, this.child, this.transitionType = TransitionType.fadeIn})
      : super(key: key);

  Route createRoute(BuildContext context) {
    switch (transitionType) {

      ///渐显
      case TransitionType.fadeIn:
        return PageRouteBuilder(
          settings: this,
          pageBuilder: (context, animation, animation2) {
            var curveTween = CurveTween(curve: Curves.easeIn);
            return FadeTransition(
              opacity: animation.drive(curveTween),
              child: child,
            );
          },
        );
      default:

        ///渐显
        return PageRouteBuilder(
          settings: this,
          pageBuilder: (context, animation, animation2) {
            var curveTween = CurveTween(curve: Curves.easeIn);
            return FadeTransition(
              opacity: animation.drive(curveTween),
              child: child,
            );
          },
        );
    }
  }
}
