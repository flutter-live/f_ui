import 'package:flutter/material.dart';

/// @description: 选择
///@date: 2020/12/7 16
class FSelectChip extends StatelessWidget {
  final Text text;
  final VoidCallback onDeleted;
  final Widget icon;
  final Color iconColor;
  final String message;
  final double radius;

  const FSelectChip({
    Key key,
    @required this.text,
    this.onDeleted,
    this.icon = const Icon(
      Icons.highlight_remove,
      size: 16,
      color: Colors.black26,
    ),
    this.iconColor = Colors.black26,
    this.message,
    this.radius = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: text,
      onDeleted: onDeleted,
      deleteIcon: icon,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      deleteIconColor: iconColor,
      deleteButtonTooltipMessage: message,
    );
  }
}
