import 'package:f_ui/model/button_model.dart';
import 'package:f_ui/provider/f_ui_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  final Color textColor;
  final Color disTextColor;
  final Color disColor;
  final Color borderColor;
  final Color hoverColor;
  final Color hoverTextColor;

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
    this.textColor = Colors.white,
    this.disTextColor,
    this.disColor,
    this.borderColor,
    this.hoverColor,
    this.hoverTextColor = Colors.white,
  })  : assert(child != null),
        super(key: key);

  @override
  _FCommonButtonsState createState() => _FCommonButtonsState();
}

class _FCommonButtonsState extends State<FCommonButtons> {
  ThemeData them;
  Color colorData;
  Color textCustomColor;
  Color borderCustomColor;

  @override
  Widget build(BuildContext context) {
    final them = FUiThemeData.of(context);
    colorData = widget.onTap == null
        ? widget.disColor ??
            (widget.color?.withOpacity(0.5) ??
                them?.primaryColor?.withOpacity(0.5))
        : (widget.color ?? them?.primaryColor);

    textCustomColor = widget.onTap == null
        ? widget.disTextColor ?? widget.textColor?.withOpacity(0.5)
        : widget.textColor;

    borderCustomColor = widget.borderColor ?? them?.primaryColor;

    switch (widget.buttonType) {
      case ButtonType.Text:
        return TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
            ),
            foregroundColor: MaterialStateProperty.all(textCustomColor),
            elevation: MaterialStateProperty.all(widget.elevation),
            backgroundColor: MaterialStateProperty.all<Color>(colorData),
            padding: MaterialStateProperty.all(widget.padding),
            textStyle: MaterialStateProperty.all(widget.textStyle),
          ),
          child: widget.child,
          onPressed: widget.onTap == null
              ? null
              : (() async => await intercept() ? widget.onTap() : null),
        );
      case ButtonType.Outlined:
        return OutlineButton(
          highlightElevation: widget.elevation,
          padding: widget.padding,
          onPressed: widget.onTap == null
              ? null
              : (() async => await intercept() ? widget.onTap() : null),
          child: widget.child,
          textColor: colorData,
          borderSide: BorderSide(
            color: colorData,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        );
      default:
        return ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
              ),
            ),
            foregroundColor: MaterialStateProperty.all(textCustomColor),
            elevation: MaterialStateProperty.all(widget.elevation),
            backgroundColor: MaterialStateProperty.all<Color>(colorData),
            padding: MaterialStateProperty.all(widget.padding),
            textStyle: MaterialStateProperty.all(widget.textStyle),
          ),
          child: widget.child,
          onPressed: widget.onTap == null
              ? null
              : (() async => await intercept() ? widget.onTap() : null),
        );
    }
  }

  ///按钮拦截
  Future<bool> intercept({dynamic data}) async {
    return true;
  }
}
