import 'package:flutter/material.dart';

/// @description: 鼠标经过添加边框
///@date: 2020/11/20 13
class FHoverBorder extends StatefulWidget {
  final double height;
  final double width;
  final EdgeInsets margin;
  final bool isActive;
  final Function onTap;
  final Widget child;

  const FHoverBorder({Key key, this.height, this.width, this.margin, this.isActive = false, this.onTap, this.child}) : super(key: key);
  @override
  _FHoverBorderState createState() => _FHoverBorderState();
}

class _FHoverBorderState extends State<FHoverBorder> with TickerProviderStateMixin {
  Border hoverBorder=Border.all(color: Colors.blue);
  Border normalBorder=Border.all(color: Colors.grey.withOpacity(0.3));
  Border border;

  @override
  void initState() {
    super.initState();
    _getBorder();
  }

  void _getBorder(){
    if(widget.isActive)border=hoverBorder;
    else border=normalBorder;
  }

  @override
  void didUpdateWidget(FHoverBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isActive!=widget.isActive){
      _getBorder();
      updateUI();
    }
  }

  void updateUI(){
    if(mounted)setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_){
          if(!widget.isActive){
            border=Border.all(color: Colors.blue);
            updateUI();
          }
        },
        onExit: (_){
          if(!widget.isActive){
            border=Border.all(color: Colors.grey.withOpacity(0.3));
            updateUI();
          }
        },
        onHover: (_){},
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
              width: widget.width,
              height: widget.height??widget.width,
              margin: widget.margin,
              alignment: Alignment.center,
              //margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: border
              ),
              child: widget.child
          ),
        )
    );
  }
}
