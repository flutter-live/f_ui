import 'package:flutter/material.dart';

/// @description: 面包屑
///@date: 2020/11/19 17
class FBreadCrumb extends StatefulWidget {
  final List<Widget> children;
  final double height;
  final String currentPosition;
  final Color titleColor;

  const FBreadCrumb({
    Key key,
    this.height = 50.0,
    this.currentPosition,
    this.children = const <Widget>[],
    this.titleColor,
  }) : super(key: key);

  @override
  _FBreadCrumbState createState() => _FBreadCrumbState();
}

class _FBreadCrumbState extends State<FBreadCrumb> {

  @override
  Widget build(BuildContext context) {

    return Container(
      height: widget.height,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10, right: 18),
            child: Text(
              widget.currentPosition,
              style: TextStyle(
                color: widget.titleColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ...widget.children
        ],
      ),
    );
  }
}
