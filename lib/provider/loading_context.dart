import 'package:f_ui/loading/model/loading_data.dart';
import 'package:flutter/material.dart';

/// @description: loading context
///
///@date: 2020/11/27 14

class LoadingContext extends InheritedWidget {
  final LoadingData loadingData;

  LoadingContext({
    Key key,
    @required this.loadingData,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(LoadingContext oldWidget) =>
      oldWidget.loadingData == this.loadingData;

  static LoadingContext of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}