import 'package:f_ui/provider/loading_context.dart';
import 'package:flutter/material.dart';

import 'model/loading_data.dart';
import 'model/shape.dart';
import 'shape_painter.dart';

/// @description: 基础形状包装类
///@date: 2020/11/27 14

const double _kMinIndicatorSize = 36.0;
class IndicatorShapeWidget extends StatelessWidget {
  final Shape shape;
  final double data;
  final int colorIndex;

  IndicatorShapeWidget({
    Key key,
    @required this.shape,
    this.data,
    this.colorIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoadingData loadingData = LoadingContext.of(context).loadingData;
    final bool shouldUseColors = loadingData.colors != null &&
        colorIndex != null &&
        colorIndex < loadingData.colors.length;
    final color = shouldUseColors
        ? loadingData.colors[colorIndex]
        : LoadingContext.of(context).loadingData.color;


    return Container(
      constraints: const BoxConstraints(
        minWidth: _kMinIndicatorSize,
        minHeight: _kMinIndicatorSize,
      ),
      child: CustomPaint(
        painter: ShapePainter(color, shape, data: data),
      ),
    );
  }
}
