import 'package:f_ui/from_builder/borderside_field_widget.dart';
import 'package:f_ui/toggle_rotate/toggle_rotate.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// @description: 默认选择框
///@date: 2020/11/25 20
class FCustomCascaderWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool readOnly;
  final bool enabled;
  final Function() onTap;
  final AnimationController animationController;

  const FCustomCascaderWidget({
    Key key,
    this.controller,
    this.hintText,
    this.onTap,
    this.readOnly = false,
    this.focusNode,
    this.enabled = true,
    this.animationController,
  }) : super(key: key);

  @override
  _FCustomCascaderWidgetState createState() => _FCustomCascaderWidgetState();
}

class _FCustomCascaderWidgetState extends State<FCustomCascaderWidget> {

  @override
  Widget build(BuildContext context) {
    return FBorderSideFieldWidget(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.next,
      hintText: widget.hintText,
      unselectedBorderColor: Colors.black26,
      isBoxShadow: false,
      enabled: widget.enabled,
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
