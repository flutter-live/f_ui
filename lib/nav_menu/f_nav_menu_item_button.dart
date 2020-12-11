import 'package:flutter/material.dart';

/// @description: 侧边导航栏子类
///@date: 2020/11/19 17

class FNavMenuItemButton extends StatefulWidget {
  final Function onTap;
  final String text;
  final double height;
  final double width;
  final Color color;

  const FNavMenuItemButton({
    Key key,
    this.onTap,
    this.text,
    this.height = 40.0,
    this.width,
    @required this.color,
  })  : assert(color != null, text != null),
        super(key: key);

  @override
  _FNavMenuItemButtonState createState() => _FNavMenuItemButtonState();
}

class _FNavMenuItemButtonState extends State<FNavMenuItemButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      ///widget.navList.isOpen ? Colors.blueAccent : HexColor('#344058')
      color: widget.color,
      child: InkWell(
        onTap: widget.onTap,
        hoverColor: Colors.grey.withOpacity(0.4),
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget.height,
          child: Text(
            widget.text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}