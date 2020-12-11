import 'package:f_ui/button/button.dart';
import 'package:f_ui/config/res/resources.dart';
import 'package:flutter/material.dart';

/// @description: 弹出层
///@date: 2020/12/7 09

class FDialog extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Alignment alignment;
  final List<Widget> children;
  final EdgeInsets margin;
  final Alignment contentAlignment;
  final List<Widget> buttons;
  final Widget confirmWidget;
  final Widget cancelWidget;
  final VoidCallback confirm;
  final VoidCallback cancel;
  final double footerButtonHeight;

  const FDialog({
    Key key,
    this.width = 500.0,
    this.height = 250.0,
    this.color,
    this.children,
    this.alignment = Alignment.center,
    this.margin = const EdgeInsets.only(top: 30),
    this.contentAlignment = Alignment.center,
    this.buttons,
    this.confirmWidget,
    this.cancelWidget,
    this.confirm,
    this.cancel,
    this.footerButtonHeight = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background = color ?? FColours.dialogTransparent;
    return Material(
      color: background,
      child: Align(
        alignment: alignment,
        child: Card(
          child: Container(
            margin: margin,
            constraints: BoxConstraints(
              maxHeight: height,
              maxWidth: width,
            ),
            alignment: contentAlignment,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: footerButtonHeight),
                  child: ListView(
                    children: children,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    height: footerButtonHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buttons ??
                          [
                            Container(
                              width: 80.0,
                              child: FCommonButtons(
                                child: confirmWidget,
                                onTap: confirm,
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 80.0,
                              child: FCommonButtons(
                                color: Colors.red,
                                child: cancelWidget,
                                onTap: cancel,
                              ),
                            ),
                          ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
