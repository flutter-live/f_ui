import 'package:flutter/material.dart';

class FDatatableHeader {
  final String text;
  final Widget textWidget;
  final String value;
  final bool sortable;
  final bool editable;
  bool show;
  final TextAlign textAlign;
  final int flex;
  final Widget Function(dynamic value) headerBuilder;
  final Widget Function(dynamic value, Map<String, dynamic> row, int index)
      sourceBuilder;

  FDatatableHeader({
    this.text,
    this.textAlign: TextAlign.center,
    this.sortable,
    this.value,
    this.show: true,
    this.editable: false,
    this.flex = 1,
    this.textWidget,
    this.headerBuilder,
    this.sourceBuilder,
  });

  factory FDatatableHeader.fromMap(Map<String, dynamic> map) =>
      FDatatableHeader(
        text: map['text'],
        textWidget: map['textWidget'],
        value: map['value'],
        sortable: map['sortable'],
        show: map['show'],
        textAlign: map['textAlign'],
        flex: map['flex'],
        headerBuilder: map['headerBuilder'],
        sourceBuilder: map['sourceBuilder'],
      );

  Map<String, dynamic> toMap() => {
        "text": this.text,
        "textWidget": this.textWidget,
        "value": this.value,
        "sortable": this.sortable,
        "show": this.show,
        "textAlign": this.textAlign,
        "flex": this.flex,
        "headerBuilder": this.headerBuilder,
        "sourceBuilder": this.sourceBuilder,
      };
}
