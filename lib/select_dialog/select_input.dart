import 'package:f_ui/f_ui_app.dart';
import 'package:f_ui/provider/f_ui_theme.dart';
import 'package:f_ui/select_dialog/select_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'select_chip.dart';

/// @description: 选择框
///@date: 2020/12/7 16

class FSelectInput extends StatefulWidget {
  final Color colorBorder;
  final VoidCallback onTap;
  final List<Map<String, dynamic>> data;
  final double width;
  final double height;
  final double minWidth = 250;
  final double minHeight = 45;
  final double maxWidth;
  final double maxHeight;
  final EdgeInsets contentPadding;
  final String hintText;
  final double radius;
  final FSelectChip Function(int index, Map<String, dynamic> item) builder;
  final VoidCallback delAll;

  const FSelectInput({
    Key key,
    this.colorBorder,
    this.onTap,
    this.data = const <Map<String, dynamic>>[],
    this.width = 250,
    this.height,
    this.maxWidth,
    this.maxHeight,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    this.hintText,
    this.radius = 5,
    this.delAll,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  _FSelectInputState createState() => _FSelectInputState();
}

class _FSelectInputState extends State<FSelectInput> {
  bool isOnTap = false;

  Color borderColor;
  Border defaultBorder;

  @override
  Widget build(BuildContext context) {
    context ??= contextMap.values.first;
    final theme = FUiThemeData.of(context);
    borderColor = widget.colorBorder ?? theme.primaryColor;
    defaultBorder = isOnTap
        ? Border.all(width: 2, color: borderColor)
        : Border.all(width: 1.2, color: Colors.black.withOpacity(0.35));

    ///当选中数据为空显示
    _getHintTextWidget() {
      return Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.hintText,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.35),
                ),
              ),
            ),
          ),
          Container(
            width: 20,
            child: Icon(
              Icons.expand_more,
              color: Colors.black26,
            ),
          )
        ],
      );
    }

    ///当选中数据
    _getSelectDataWidget() {
      return Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(
                widget.data.length,
                (index) => widget.builder(index, widget.data[index]),
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.delAll,
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 5),
              child: Icon(
                Icons.highlight_remove,
                color: Colors.black26,
                size: 18,
              ),
            ),
          )
        ],
      );
    }

    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOnTap = !isOnTap;
          });
          if (widget.onTap != null) widget.onTap();
        },
        child: Container(
          padding: widget.contentPadding,
          width: widget.width,
          constraints: BoxConstraints(
            minWidth: widget.minWidth,
            minHeight: widget.minHeight,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            border: defaultBorder,
          ),
          child: widget.data == null || widget.data.length == 0
              ? _getHintTextWidget()
              : _getSelectDataWidget(),
        ),
      ),
    );
  }
}
