import 'package:f_ui/config/res/resources.dart';
import 'package:flutter/material.dart';
import 'f_nav_menu_item_button.dart';

/// @description: 导航菜单组
///@date: 2020/11/19 16
class FNavMenuGroup extends StatefulWidget {
  final List<FNavMenuItemButton> children;
  final Widget child;
  final Color background;
  final EdgeInsets padding;

  const FNavMenuGroup({
    Key key,
    this.children = const <FNavMenuItemButton>[],
    this.background,
    this.padding = const EdgeInsets.symmetric(vertical: 5),
    this.child,
  })  : assert(children != null),
        super(key: key);

  @override
  _FNavMenuGroupState createState() => _FNavMenuGroupState();
}

class _FNavMenuGroupState extends State<FNavMenuGroup> {
  @override
  Widget build(BuildContext context) {
    Color color = widget.background ?? FColours.navBackColor;

    return Container(
      color: color,
      padding: widget.padding,
      child: widget.child ?? Column(
        children: widget.children,
      ),
    );
  }
}
