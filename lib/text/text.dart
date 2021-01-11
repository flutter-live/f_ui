import 'package:f_ui/f_ui_app.dart';
import 'package:f_ui/provider/f_ui_theme.dart';
import 'package:flutter/material.dart';

TextStyle defaultTextStyle = TextStyle(
  fontSize: 14,
);

TextStyle footerTextStyle =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w500);

TextStyle footerNumberTextStyle = footerTextStyle.copyWith(
  fontSize: 19,
);

TextStyle pageMainTitleStyle = TextStyle(
  fontSize: 35,
  fontWeight: FontWeight.w700,
);

TextStyle menuTextStyle = defaultTextStyle.copyWith(
  fontWeight: FontWeight.w700,
);

TextStyle loginSubmitTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

TextStyle pageMainTitleWithShadowStyle = TextStyle(
    color: Colors.white,
    fontSize: 55,
    fontWeight: FontWeight.w700,
    shadows: [
      /// shadow
      Shadow(
        color: Colors.black.withOpacity(0.5),
        offset: Offset(3.5, 2.5),
        blurRadius: 3.2,
      ),
    ]);

TextStyle pageMainTitleWithBorderAndShadowStyle = TextStyle(
  color: Colors.white,
  fontSize: 45,
  fontWeight: FontWeight.w700,
  shadows: [
    /// borders
    Shadow(
        // bottomLeft
        offset: Offset(-1.5, -1.5),
        color: Colors.black),
    Shadow(
        // bottomRight
        offset: Offset(1.5, -1.5),
        color: Colors.black),
    Shadow(
        // topRight
        offset: Offset(1.5, 1.5),
        color: Colors.black),
    Shadow(
        // topLeft
        offset: Offset(-1.5, 1.5),
        color: Colors.black),

    /// shadow
    Shadow(
      color: Colors.black.withOpacity(0.5),
      offset: Offset(3.5, 2.5),
      blurRadius: 3.2,
    ),
  ],
);

/// @description: 带有下划线文字
/// @date: 2020-11-12 11:51:02
class FHyperLinkWidget extends StatefulWidget {
  final String text;
  final Color color;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextStyle textStyle;
  final Function() onTap;
  final Color hoverColor;

  FHyperLinkWidget({
    Key key,
    @required this.text,
    this.onTap,
    this.color,
    this.fontSize = 16.0,
    this.textStyle,
    this.fontWeight,
    this.borderColor,
    this.hoverColor,
  })  : assert(text != null),
        super(key: key);

  @override
  _FHyperLinkWidget createState() => _FHyperLinkWidget();
}

class _FHyperLinkWidget extends State<FHyperLinkWidget>
    with TickerProviderStateMixin {
  bool isHover = false;

  void updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context ??= contextMap.values.first;
    final theme = FUiThemeData.of(context);
     Color borderColorCustom = widget.borderColor ?? theme.primaryColor;
     Color colorCustom = isHover ? widget.hoverColor ?? theme.primaryColor : widget.color ?? theme.primaryColor;

    return MouseRegion(
      onEnter: (_) {
        isHover = true;
        updateUI();
      },
      onExit: (_) {
        isHover = false;
        updateUI();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: Container(
            height: 23,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: isHover
                  ? Border(
                      top: BorderSide(color: Colors.transparent),
                      bottom: BorderSide(color: borderColorCustom))
                  : Border(
                      top: BorderSide(color: Colors.transparent),
                      bottom: BorderSide(color: Colors.transparent)),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: colorCustom,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// @description: 带有引用缩放的字体
///@date: 2020/11/19 13
class FZoomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final BoxFit boxFit;

  const FZoomTextWidget(
      {Key key,
      @required this.text,
      this.boxFit = BoxFit.contain,
      this.textStyle})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var style =
        textStyle ?? TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
    return FittedBox(
      fit: boxFit,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

///主页菜单阴影字体
class FPageMainTitleWithBorderAndShadow extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const FPageMainTitleWithBorderAndShadow(
      {Key key, this.text, this.color, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = pageMainTitleWithBorderAndShadowStyle.copyWith(
        //color: color??Colors.black,
        fontSize: fontSize ?? 32);
    if (color != null)
      style = pageMainTitleWithBorderAndShadowStyle.copyWith(
          color: color, fontSize: fontSize ?? 32);
    return Text(
      text,
      style: style,
    );
  }
}

///带有阴影的字体
class FShadowTitleText extends StatelessWidget {
  final String text;
  final Color color;
  final bool withShadow;

  const FShadowTitleText({
    Key key,
    this.text,
    this.color,
    this.withShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = loginSubmitTextStyle.copyWith(
        shadows: withShadow
            ? [
                Shadow(
                  color: Colors.grey,
                  offset: Offset(1, 0.5),
                )
              ]
            : null);
    if (color != null)
      style = loginSubmitTextStyle.copyWith(
          color: color ?? Colors.white,
          shadows: withShadow
              ? [
                  Shadow(
                    color: Colors.grey,
                    offset: Offset(1, 0.5),
                  )
                ]
              : null);
    return Text(text, style: style);
  }
}

///主要字体大小
class FMenuText extends StatelessWidget {
  final String text;
  final Color color;

  const FMenuText({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = menuTextStyle.copyWith();
    if (color != null)
      style = menuTextStyle.copyWith(color: color ?? Colors.black);
    return Text(text, style: style);
  }
}
