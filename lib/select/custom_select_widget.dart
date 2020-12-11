import 'package:f_ui/from_builder/borderside_field_widget.dart';
import 'package:f_ui/toggle_rotate/toggle_rotate.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// @description: 默认选择框
///@date: 2020/11/25 20
class FCustomSelectWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool readOnly;
  final Function() onTap;
  final AnimationController animationController;

  const FCustomSelectWidget({
    Key key,
    this.controller,
    this.hintText,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.animationController,
  }) : super(key: key);

  @override
  _FCustomSelectWidgetState createState() => _FCustomSelectWidgetState();
}

class _FCustomSelectWidgetState extends State<FCustomSelectWidget> {

  @override
  Widget build(BuildContext context) {
    return FBorderSideFieldWidget(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.next,
      hintText: widget.hintText,
      unselectedBorderColor: Colors.black26,
      isBoxShadow: false,
      readOnly: widget.readOnly,
      suffixIcon: FToggleRotate(
        curve: Curves.decelerate,
        durationMs: 300,
        //动画时长
        rad: pi,
        child: Icon(Icons.arrow_drop_down),
        animationController: widget.animationController,
        onTap: widget.onTap,
      ),
      onTap: widget.onTap,
    );
  }
}
