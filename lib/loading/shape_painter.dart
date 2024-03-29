import 'package:flutter/material.dart';
import 'dart:math';

import 'model/shape.dart';

/// @description: loading画笔
///@date: 2020/11/27 14

class ShapePainter extends CustomPainter {
  final Color color;
  final Shape shape;
  final Paint _paint;
  final double data;

  static const double _strokeWidth = 2.0;

  ShapePainter(this.color, this.shape, {this.data})
      : _paint = Paint()..isAntiAlias = true,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    switch (shape) {
      case Shape.circle:
        _paint
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          Offset(size.width / 2, size.height / 2),
          size.shortestSide / 2,
          _paint,
        );
        break;
      case Shape.ringThirdFour:
        _paint
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = _strokeWidth;
        canvas.drawArc(
            Rect.fromCircle(
                center: Offset(size.width / 2, size.height / 2),
                radius: size.shortestSide / 2),
            -3 * pi / 4,
            3 * pi / 2,
            false,
            _paint);
        break;
      case Shape.rectangle:
        _paint
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawRect(Offset.zero & size, _paint);
        break;
      case Shape.ringTwoHalfVertical:
        _paint
          ..color = color
          ..strokeWidth = _strokeWidth
          ..style = PaintingStyle.stroke;
        final rect = Rect.fromLTWH(
            size.width / 4, size.height / 4, size.width / 2, size.height / 2);
        canvas.drawArc(rect, -3 * pi / 4, pi / 2, false, _paint);
        canvas.drawArc(rect, 3 * pi / 4, -pi / 2, false, _paint);
        break;
      case Shape.ring:
        _paint
          ..color = color
          ..strokeWidth = _strokeWidth
          ..style = PaintingStyle.stroke;
        canvas.drawCircle(Offset(size.width / 2, size.height / 2),
            size.shortestSide / 2, _paint);
        break;
      case Shape.line:
        _paint
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(0, 0, size.width, size.height),
                Radius.circular(size.shortestSide / 2)),
            _paint);
        break;
      case Shape.triangle:
        final offsetY = size.height / 4;
        _paint
          ..color = color
          ..style = PaintingStyle.fill;
        Path path = Path()
          ..moveTo(0, size.height - offsetY)
          ..lineTo(size.width / 2, size.height / 2 - offsetY)
          ..lineTo(size.width, size.height - offsetY)
          ..close();
        canvas.drawPath(path, _paint);
        break;
      case Shape.arc:
        assert(data != null);
        _paint
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawArc(
            Offset.zero & size, data, pi * 2 - 2 * data, true, _paint);
        break;
      case Shape.circleSemi:
        _paint
          ..color = color
          ..style = PaintingStyle.fill;
        canvas.drawArc(Offset.zero & size, -pi * 6, -2 * pi / 3, false, _paint);
        break;
    }
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) =>
      this.shape != oldDelegate.shape ||
          this.color != oldDelegate.color ||
          this.data != oldDelegate.data;
}