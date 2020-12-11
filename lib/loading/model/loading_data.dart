import 'package:flutter/material.dart';

import 'loading_model.dart';

/// @description: 
///@date: 2020/11/27 14

@immutable
class LoadingData {
  final Color color;
  final Indicator indicator;
  final List<Color> colors;

  const LoadingData(
      {@required this.indicator, this.color = Colors.white, this.colors});

  @override
  bool operator ==(other) {
    if (other.runtimeType != runtimeType) return false;
    final LoadingData typedOther = other;
    return this.color == typedOther.color &&
        this.colors == typedOther.colors &&
        this.indicator == typedOther.indicator;
  }

  @override
  int get hashCode => hashValues(color, indicator);

  @override
  String toString() {
    return 'DecorateData{color: $color, indicator: $indicator}';
  }
}