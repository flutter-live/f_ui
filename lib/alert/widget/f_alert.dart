import 'package:f_ui/config/res/resources.dart';
import 'package:f_ui/f_ui_app.dart';
import 'package:f_ui/provider/f_ui_theme.dart';
import 'package:flutter/material.dart' hide ErrorWidget;

import 'alert_icon.dart';


/// @description: 提示框
/// @date: 2020/11/4

enum  FAlertType{
  success,
  info,
  warning,
  error,
}

enum Effect{
  dark,
  light
}

typedef void CloseFunc();

class FAlert extends StatefulWidget {
  final Text title;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final Icon icon;
  final BuildContext context;
  final FAlertType type;
  final Effect effect;
  final double radius;
  final bool closable;
  final Text closeText;
  final CloseFunc close;
  final bool isShowIcon;
  final MainAxisAlignment alignment;
  final Text description;
  final EdgeInsetsGeometry textPadding;
  final TextStyle textStyle;

  const FAlert(
      this.title, {
      Key key,
      this.type,
        this.backgroundColor = Colors.green,
        this.effect = Effect.light,
        this.closable = false,
        this.closeText, this.close,
        this.isShowIcon = false,
        this.alignment = MainAxisAlignment.start,
        this.description,
        this.context,
        this.radius = 10,
        this.textPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        this.icon,
        this.textColor,
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
    textStyle = widget.textStyle ?? TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white);
    maxHeight = widget.description == null ? 50.0 : 60.0;
    super.initState();
  }

  ///获取颜色
  Color getColors(){
    switch(widget.type){
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
  Widget getIcons(){
    switch(widget.type){
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
    ///控制右侧按钮显示位置，当有描述文件按钮顶部剧中否则上下左右居中
    Alignment closeAlignment = widget.description == null ? Alignment.center : Alignment.topCenter;

    ///左侧图标 加按钮
    Widget leftWidget = Row(
      mainAxisAlignment: widget.alignment,
      children: [
        if(widget.isShowIcon)
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

    ///右侧按钮
    Widget closeWidget = Container();
    if(widget.closable || widget.closeText != null){
      if(widget.closable){
        closeWidget = Icon(Icons.clear, color: Colors.white, size: 18);
      }else if(widget.closeText != null){
        closeWidget = widget.closeText;
      }
    }
    Widget rightWidget = Container(
      alignment: closeAlignment,
      child: GestureDetector(
        onTap: widget.close,
        child: closeWidget,
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
            blurRadius: 5.0,//阴影大小
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
            rightWidget
          ],
        ),
      ),
    );
  }
}

