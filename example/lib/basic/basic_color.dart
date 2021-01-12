import 'package:example/res/size.dart';
import 'package:f_ui/config/res/resources.dart';
import 'package:flutter/material.dart';

/// @description: 颜色
///@date: 2021/1/11 19
class BasicColor extends StatefulWidget {
  @override
  _BasicColorState createState() => _BasicColorState();
}

class _BasicColorState extends State<BasicColor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Color 色彩',
            style: FuiSizeOrColor.firstSize,
          ),
          Text('Fui主要的主题颜色', style: FuiSizeOrColor.normalSize),
          SizedBox(height: 20),
          Text('主色', style: FuiSizeOrColor.secSize),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: FColours.light_primaryColor,
              child: Text(
                'Color(0xFF345B9A)',
                style: FuiSizeOrColor.normalSizeWhite,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: FColours.light_accentColor,
              child: Text(
                'Color(0xFF305da6)',
                style: FuiSizeOrColor.normalSizeWhite,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('后续自行扩展', style: FuiSizeOrColor.normalSize)
        ],
      ),
    );
  }
}
