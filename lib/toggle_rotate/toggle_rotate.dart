import 'package:flutter/material.dart';
import 'dart:math';

/// @description: 组件旋转
///@date: 2020/11/25 20'

class FToggleRotate extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double rad;
  final int durationMs;
  final bool clockwise;
  final Curve curve;
  final AnimationController animationController;

  FToggleRotate({
    this.child,
    @required this.onTap,
    this.rad = pi / 2,
    this.clockwise = true,
    this.durationMs = 200,
    this.curve = Curves.fastOutSlowIn,
    this.animationController,
  }) : assert(onTap != null);

  @override
  _FToggleRotateState createState() => _FToggleRotateState();
}

class _FToggleRotateState extends State<FToggleRotate>
    with SingleTickerProviderStateMixin {
  double _rad = 0;
  AnimationController _controller;
  Animation _rotate;

  @override
  void initState() {
    _controller = widget.animationController ??
        AnimationController(
            duration: Duration(milliseconds: widget.durationMs), vsync: this);
    _controller.addListener(() =>
        setState(() =>
        _rad = _rotate.value * widget.rad));
    _rotate = CurvedAnimation(parent: _controller, curve: widget.curve);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Transform(
        transform: Matrix4.rotationZ(widget.clockwise ? _rad : -_rad),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
