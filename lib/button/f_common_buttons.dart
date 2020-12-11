import 'package:f_ui/model/button_model.dart';
import 'package:flutter/material.dart';

///公共按钮
///所有按钮都已此基础进行扩展
///可以进行拦截，进行埋点操作
class FCommonButtons extends StatefulWidget {
  final VoidCallback onTap;
  final double radius;
  final Color color;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final TextStyle textStyle;
  final ButtonType buttonType;

  const FCommonButtons({
    Key key,
    this.onTap,
    this.radius = 5.0,
    this.color,
    @required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
    this.elevation,
    this.buttonType = ButtonType.Elevated,
    this.textStyle,
  })  : assert(child != null),
        super(key: key);

  @override
  _FCommonButtonsState createState() => _FCommonButtonsState();
}

class _FCommonButtonsState extends State<FCommonButtons> {
  ThemeData them;
  Color colorData;

  @override
  Widget build(BuildContext context) {
    them = Theme.of(context);
    colorData = widget.color ?? them.primaryColor;

    switch (widget.buttonType) {
      case ButtonType.Text:
        return TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
            ),
            elevation: MaterialStateProperty.all(widget.elevation),
            backgroundColor: MaterialStateProperty.all<Color>(colorData),
            padding: MaterialStateProperty.all(widget.padding),
          ),
          child: widget.child,
          onPressed: () async => await intercept() ? widget.onTap() : null,
        );
      case ButtonType.Outlined:
        return OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(widget.textStyle),
            elevation: MaterialStateProperty.all(widget.elevation),
            padding: MaterialStateProperty.all(widget.padding),
          ),
          child: widget.child,
          onPressed: () async => await intercept() ? widget.onTap() : null,
        );
      default:
        return ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
            ),
            elevation: MaterialStateProperty.all(widget.elevation),
            backgroundColor: MaterialStateProperty.all<Color>(colorData),
            padding: MaterialStateProperty.all(widget.padding),
          ),
          child: widget.child,
          onPressed: () async => await intercept() ? widget.onTap() : null,
        );
    }
  }

  ///按钮拦截
  Future<bool> intercept({dynamic data}) async {
    return true;
  }
}