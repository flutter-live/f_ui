import 'package:f_ui/provider/loading_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/loading_data.dart';
import 'model/loading_model.dart';
import 'shape/line_spin_fade_foader.dart';

/// @description: 选择loading显示样式类
///@date: 2020/11/27 14

class LoadingIndicator extends StatelessWidget {
  final Indicator indicatorType;
  final Text textWidget;
  final Color maskColor;
  final Color color;
  final double radius;
  final List<Color> colors;

  const LoadingIndicator({
    Key key,
    @required this.indicatorType,
    this.textWidget,
    @required this.maskColor,
    @required this.color,
    @required this.colors,
    this.radius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Material(
        color: maskColor,
        child: LoadingContext(
            loadingData: LoadingData(
              indicator: indicatorType,
              color: color,
              colors: colors,
            ),
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: radius,
                      height: radius,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: _buildIndicator(),
                      ),
                    ),
                    SizedBox(height: 10),
                    textWidget ?? Container(),
                  ],
                ),
              ),
            )),
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }

  Widget _buildIndicator() {
    switch (indicatorType) {
      case Indicator.lineSpinFadeLoader:
        return LineSpinFadeLoader();
      default:
        throw Exception("no related indicator type:$indicatorType");
    }
  }
}
