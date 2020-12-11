import 'package:f_ui/router/page.dart';
import 'package:flutter/material.dart';

/// @description: 1.0路由动画
/// @date: 2020-11-12 14:54:37
class CustomRoute extends PageRouteBuilder {
  final Widget child;
  final TransitionType transitionType;
  final bool opaque;
  final int milliseconds;

  CustomRoute({
    @required this.child,
    this.transitionType = TransitionType.fadeIn,
    this.opaque = true,
    this.milliseconds = 1000,
  })  : assert(child != null),
        super(
          // 设置过度时间
          transitionDuration: Duration(milliseconds: milliseconds),
          opaque: opaque,
          // 构造器
          pageBuilder: (
            // 上下文和动画
            BuildContext context,
            Animation<double> animaton1,
            Animation<double> animaton2,
          ) {
            return child;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animaton1,
            Animation<double> animaton2,
            Widget child,
          ) {
            switch (transitionType) {
              case TransitionType.fadeIn:
                // 渐变效果
                return FadeTransition(
                  // 从0开始到1
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    // 传入设置的动画
                    parent: animaton1,
                    // 设置效果，快进漫出   这里有很多内置的效果
                    curve: Curves.fastOutSlowIn,
                  )),
                  child: child,
                );
              case TransitionType.scaleFade:
                // 缩放动画效果
                return ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animaton1, curve: Curves.fastOutSlowIn)),
                  child: child,
                );
              default:
                // 渐变效果
                return FadeTransition(
                  // 从0开始到1
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    // 传入设置的动画
                    parent: animaton1,
                    // 设置效果，快进漫出   这里有很多内置的效果
                    curve: Curves.fastOutSlowIn,
                  )),
                  child: child,
                );
            }

            // 缩放动画效果
            // return ScaleTransition(
            //   scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
            //     parent: animaton1,
            //     curve: Curves.fastOutSlowIn
            //   )),
            //   child: child,
            // );

            // 左右滑动动画效果
            // return SlideTransition(
            //   position: Tween<Offset>(
            //     // 设置滑动的 X , Y 轴
            //     begin: Offset(-1.0, 0.0),
            //     end: Offset(0.0,0.0)
            //   ).animate(CurvedAnimation(
            //     parent: animaton1,
            //     curve: Curves.fastOutSlowIn
            //   )),
            //   child: child,
            // );
          },
        );
}
