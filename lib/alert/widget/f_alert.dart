import 'package:f_ui/config/res/resources.dart';
import 'package:f_ui/f_ui_app.dart';
import 'package:f_ui/provider/f_ui_theme.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'alert_icon.dart';

/// @description: 提示框
/// @date: 2020/11/4

enum FAlertType {
  success,
  info,
  warning,
  error,
}

enum Effect {
  dark,
  light
}

typedef void CloseFunc();

class FAlert extends StatefulWidget {
  final Text title;
  final double width;
  final Color backgroundColor;
  final Icon icon;
  final bool isLeading;
  final BuildContext context;
  final FAlertType type;
  final double radius;
  final Widget closeWidget;
  final CloseFunc close;
  final MainAxisAlignment alignment;
  final Widget description;
  final EdgeInsetsGeometry textPadding;
  final TextStyle textStyle;

  const FAlert(this.title, {
    Key key,
    @required this.type,
    this.backgroundColor,
    this.closeWidget,
    this.isLeading = true,
    this.close,
    this.alignment = MainAxisAlignment.start,
    this.description,
    this.context,
    this.radius = 10,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    this.icon,
    this.textStyle,
    this.width = 600.0,
  }) : super(key: key);


  @override
  _FAlertState createState() => _FAlertState();
}

class _FAlertState extends State<FAlert> {
  double radius;
  EdgeInsetsGeometry textPadding;
  TextStyle textStyle;
  double maxHeight;

  @override
  void initState() {
    BuildContext context = widget.context ?? contextMap.values.first;
    final theme = FUiThemeData.of(context);
    radius = widget.radius;
    textPadding = widget.textPadding;
    textStyle = widget.textStyle ?? TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white);
    maxHeight = widget.description == null ? 50.0 : 60.0;
    super.initState();
  }

  ///获取颜色
  Color getColors() {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor;
    }
    switch (widget.type) {
      case FAlertType.success:
        return FColours.success;
      case FAlertType.info:
        return FColours.info;
      case FAlertType.warning:
        return FColours.warning;
      case FAlertType.error:
        return FColours.error;
      default:
        return widget.backgroundColor;
    }
  }

  ///获取图标
  Widget getIcons() {
    if (widget.icon != null) {
      return widget.icon;
    }
    switch (widget.type) {
      case FAlertType.success:
        return SuccessWidget();
      case FAlertType.info:
        return InfoWidget();
      case FAlertType.warning:
        return WarningWidget();
      case FAlertType.error:
        return ErrorWidget();
      default:
        return widget.icon;
    }
  }

  @override
  Widget build(BuildContext context) {
    ///左侧图标 加按钮
    Widget leftWidget = Row(
      mainAxisAlignment: widget.alignment,
      children: [
        if(widget.isLeading)
          Container(margin: const EdgeInsets.only(right: 15), child: IconTheme(
            data: IconThemeData(
              color: Colors.white,
              size: 24,
            ),
            child: getIcons(),
          ),),
        if(widget.title != null)
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: DefaultTextStyle(
                      style: textStyle,
                      child: widget.title,
                    )
                ),
                if(widget.description != null)
                  Container(child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                    child: widget.description,
                  ),
                    margin: const EdgeInsets.only(top: 5),)
              ]
          )
      ],
    );

    Widget rightWidget = Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: widget.close,
        child: widget.closeWidget,
      ),
    );

    return Container(
      margin: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
          color: getColors(),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 5.0, //阴影大小
                offset: Offset.lerp(Offset(0, 0), Offset(0, 10), 0.2)
            ),
          ]
      ),
      constraints: BoxConstraints(
        minHeight: 50,
        maxHeight: maxHeight,
        maxWidth: widget.width,
        minWidth: 10,
      ),
      padding: textPadding,
      child: ClipRect(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: leftWidget,),
            if(widget.closeWidget != null)
            rightWidget
          ],
        ),
      ),
    );
  }
}

