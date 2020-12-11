import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'field.dart';

/// @description: 密码输入框
/// @date: 2020-11-09 16:37:04 BorderSide
class FBorderSideFieldWidget extends StatefulWidget {
  final TextStyle hintStyle;
  final Widget prefixIcon;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final double width;
  final double height;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final double radius;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final bool isBoxShadow;
  final Color cursorColor;
  final EdgeInsets contentPadding;
  final EdgeInsets padding;
  final Widget suffixIcon;
  final Function() onTap;
  final bool readOnly;
  final Color inputBackground;
  final bool enabled;

  FBorderSideFieldWidget({
    Key key,
    this.hintText,
    this.icon,
    this.obscureText = false,
    this.width,
    this.height,
    this.textInputAction,
    this.controller,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.hintStyle,
    this.prefixIcon,
    this.inputFormatters,
    this.radius = 5.0,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.isBoxShadow = true,
    this.cursorColor,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.padding,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.inputBackground,
    this.enabled = true,
  }) : super(key: key);

  @override
  _FBorderSideFieldWidgetState createState() => _FBorderSideFieldWidgetState();
}

class _FBorderSideFieldWidgetState extends State<FBorderSideFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.inputBackground,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      ),
      child: FTextField(
        hintText: widget.hintText,
        icon: widget.icon,
        cursorColor: widget.cursorColor,
        obscureText: widget.obscureText,
        controller: widget.controller,
        validator: widget.validator,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        contentPadding: widget.contentPadding,
        onFieldSubmitted: widget.onFieldSubmitted,
        readOnly: widget.readOnly ,
        onTap: widget.onTap,
        enabled: widget.enabled,
        hintStyle: widget.hintStyle ??
            TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
