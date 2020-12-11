import 'package:flutter/material.dart';

/// @description: 图标
/// @date: 2020/11/4

///成功
class SuccessWidget extends StatelessWidget {
  final Color color;
  final double size;

  const SuccessWidget({Key key, this.color = Colors.green, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.check_circle_outline, size: size,),
    );
  }
}


///消息
class InfoWidget extends StatelessWidget {
  final Color color;
  final double size;

  const InfoWidget({Key key, this.color = Colors.grey, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.info_outline_rounded, size: size,),
    );
  }
}


///警告
class WarningWidget extends StatelessWidget {
  final Color color;
  final double size;

  const WarningWidget({Key key, this.color = Colors.orange, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.warning_amber_sharp, size: size,),
    );
  }
}


///错误
class ErrorWidget extends StatelessWidget {
  final Color color;
  final double size;

  const ErrorWidget({Key key, this.color = Colors.red, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.cancel_outlined, size: size,),
    );
  }
}