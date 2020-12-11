import 'package:f_ui/expansion_tltle/custom_expansion_title.dart';
import 'package:flutter/material.dart';

/// @description: 导航菜单
/// @date: 2020-11-15 12:53:09

class FNavMenu extends StatefulWidget {
  final Widget child;
  final double width;
  final List<FExpansionTitle> fExpansionTitles;

  const FNavMenu({
    Key key,
    this.fExpansionTitles = const <FExpansionTitle>[],
    this.width,
    this.child,
  }) : super(key: key);

  @override
  _FNavMenuState createState() => _FNavMenuState();
}

class _FNavMenuState extends State<FNavMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: widget.child ??
          Column(
            children: widget.fExpansionTitles,
          ),
    );
  }
}


