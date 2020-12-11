import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_context/responsive_context.dart';
import 'DatatableHeader.dart';

class FResponsiveDatatable extends StatefulWidget {
  final bool showSelect;
  final List<FDatatableHeader> headers;
  final List<Map<String, dynamic>> source;
  final List<int> selecteds;
  final int totalCnt;
  final Widget title;
  final List<Widget> actions;
  final List<Widget> footers;
  final Function(bool value) onSelectAll;
  final Function(bool value, Map<String, dynamic> data) onSelect;
  final Function(dynamic value) onTabRow;
  final Function(dynamic value) onSort;
  final String sortColumn;
  final bool sortAscending;
  final bool isLoading;
  final bool autoHeight;
  final bool hideUnderline;
  final int maxSelect;

  const FResponsiveDatatable({
    Key key,
    this.showSelect: false,
    this.onSelectAll,
    this.onSelect,
    this.onTabRow,
    this.onSort,
    this.headers,
    this.source,
    this.selecteds,
    this.totalCnt,
    this.title,
    this.actions,
    this.footers,
    this.sortColumn,
    this.sortAscending,
    this.isLoading: false,
    this.autoHeight: true,
    this.hideUnderline: true,
    this.maxSelect,
  }) : super(key: key);

  @override
  _FResponsiveDatatableState createState() => _FResponsiveDatatableState();
}

class _FResponsiveDatatableState extends State<FResponsiveDatatable> {
  ScrollController scrollController = ScrollController();
  // @override
  // void initState() {
  //   super.initState();
  //   //print('init, table selecteds length: ${widget.selecteds.length}');
  //   scrollController.addListener(() {
  //     //print('offset: ${scrollController.offset}');
  //   });
  // }

  // @override
  // void didUpdateWidget(ResponsiveDatatable oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   if (oldWidget.selecteds != widget.selecteds) {
  //     var status = widget.selecteds.length == widget.totalCnt &&
  //         widget.totalCnt != null &&
  //         widget.totalCnt > 0;
  //     print(
  //         'update widget, table selecteds length: ${oldWidget.source.length} - ${widget.selecteds.length} - $status');
  //     setState(() {});
  //   }
  // }

  ///单选
  void choiceSelect(bool value, dynamic data) {
    if (!value) {
      if (widget.onSelect != null) widget.onSelect(value, data);
    } else {
      if (widget.maxSelect != null) {
        if (widget.maxSelect > widget.selecteds.length) {
          if (widget.onSelect != null) widget.onSelect(value, data);
        }
      } else {
        if (widget.onSelect != null) widget.onSelect(value, data);
      }
    }
  }

  ///全选
  void choiceAllSelect(bool value) {
    if (!value) {
      widget.onSelectAll(value);
    } else {
      if (widget.onSelectAll != null && widget.maxSelect == null)
        widget.onSelectAll(value);
    }
  }

  Widget mobileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: widget.selecteds.length == widget.source.length &&
              widget.source != null &&
              widget.source.length > 0,
          onChanged: choiceAllSelect,
        ),
        PopupMenuButton(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text("SORT BY"),
            ),
            tooltip: "SORT BY",
            initialValue: widget.sortColumn,
            itemBuilder: (_) => widget.headers
                .where(
                    (header) => header.show == true && header.sortable == true)
                .toList()
                .map((header) => PopupMenuItem(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "${header.text}",
                            textAlign: header.textAlign,
                          ),
                          if (widget.sortColumn != null &&
                              widget.sortColumn == header.value)
                            widget.sortAscending
                                ? Icon(Icons.arrow_downward, size: 15)
                                : Icon(Icons.arrow_upward, size: 15)
                        ],
                      ),
                      value: header.value,
                    ))
                .toList(),
            onSelected: (value) {
              if (widget.onSort != null) widget.onSort(value);
            })
      ],
    );
  }

  List<Widget> mobileList() {
    return widget.source.map((data) {
      return InkWell(
        onTap: widget.onTabRow != null
            ? () {
                widget.onTabRow(data);
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  if (widget.showSelect && widget.selecteds != null)
                    Checkbox(
                      value: widget.selecteds.indexOf(data['id']) >= 0,
                      onChanged: (value) => choiceSelect(value, data),
                    ),
                ],
              ),
              ...widget.headers
                  .where((header) => header.show == true)
                  .toList()
                  .map(
                    (header) => Container(
                      padding: EdgeInsets.all(11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          header.headerBuilder != null
                              ? header.headerBuilder(header.value)
                              : Text(
                                  "${header.text}",
                                  overflow: TextOverflow.clip,
                                ),
                          Spacer(),
                          header.sourceBuilder != null
                              ? header.sourceBuilder(data[header.value], data)
                              : header.editable
                                  ? editAbleWidget(
                                      data: data,
                                      header: header,
                                      textAlign: TextAlign.end,
                                    )
                                  : Text("${data[header.value]}")
                        ],
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      );
    }).toList();
  }

  Alignment headerAlignSwitch(TextAlign textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
        break;
      case TextAlign.left:
        return Alignment.centerLeft;
        break;
      case TextAlign.right:
        return Alignment.centerRight;
        break;
      default:
        return Alignment.center;
    }
  }

  Widget desktopHeader() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[300], width: 1))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showSelect && widget.selecteds != null)
            Checkbox(
              value: widget.selecteds.length == widget.totalCnt &&
                  widget.totalCnt != null &&
                  widget.totalCnt > 0,
              onChanged: choiceAllSelect,
            ),
          ...widget.headers
              .where((header) => header.show == true)
              .map(
                (header) => Expanded(
                    flex: header.flex ?? 1,
                    child: InkWell(
                      onTap: () {
                        if (widget.onSort != null && header.sortable)
                          widget.onSort(header.value);
                      },
                      child: header.headerBuilder != null
                          ? header.headerBuilder(header.value)
                          : Container(
                              padding: EdgeInsets.all(11),
                              alignment: headerAlignSwitch(header.textAlign),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    "${header.text}",
                                    textAlign: header.textAlign,
                                  ),
                                  if (widget.sortColumn != null &&
                                      widget.sortColumn == header.value)
                                    widget.sortAscending
                                        ? Icon(Icons.arrow_downward, size: 15)
                                        : Icon(Icons.arrow_upward, size: 15)
                                ],
                              ),
                            ),
                    )),
              )
              .toList()
        ],
      ),
    );
  }

  List<Widget> desktopList() {
    List<Widget> widgets = [];
    for (var index = 0; index < widget.source.length; index++) {
      final data = widget.source[index];
      widgets.add(InkWell(
        onTap: widget.onTabRow != null
            ? () {
                widget.onTabRow(data);
              }
            : null,
        child: Container(
            padding: EdgeInsets.all(widget.showSelect ? 0 : 11),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showSelect && widget.selecteds != null)
                  Checkbox(
                    value: widget.selecteds.indexOf(data['id']) >= 0,
                    onChanged: (value) => choiceSelect(value, data),
                  ),
                ...widget.headers
                    .where((header) => header.show == true)
                    .map(
                      (header) => Expanded(
                        flex: header.flex ?? 1,
                        child: header.sourceBuilder != null
                            ? header.sourceBuilder(data[header.value], data)
                            : header.editable
                                ? editAbleWidget(
                                    data: data,
                                    header: header,
                                    textAlign: header.textAlign,
                                  )
                                : Container(
                                    child: Text(
                                      "${data[header.value]}",
                                      textAlign: header.textAlign,
                                    ),
                                  ),
                      ),
                    )
                    .toList()
              ],
            )),
      ));
    }
    return widgets;
  }

  Widget editAbleWidget({
    @required Map<String, dynamic> data,
    @required FDatatableHeader header,
    TextAlign textAlign: TextAlign.center,
  }) {
    return Container(
      constraints: BoxConstraints(maxWidth: 150),
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: this.widget.hideUnderline
              ? InputBorder.none
              : UnderlineInputBorder(borderSide: BorderSide(width: 1)),
          alignLabelWithHint: true,
        ),
        textAlign: textAlign,
        controller: TextEditingController.fromValue(
          TextEditingValue(text: "${data[header.value]}"),
        ),
        onChanged: (newValue) => data[header.value] = newValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dList = desktopList();
    var mList = mobileList();
    return context.isExtraSmall || context.isSmall || context.isMedium
        ?
        /**
         * for small screen
         */
        Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //title and actions
                if (widget.title != null || widget.actions != null)
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.title != null) widget.title,
                        if (widget.actions != null) ...widget.actions
                      ],
                    ),
                  ),

                if (widget.autoHeight)
                  Column(
                    children: [
                      if (widget.showSelect && widget.selecteds != null)
                        mobileHeader(),
                      if (widget.isLoading) LinearProgressIndicator(),
                      //mobileList
                      ...mList,
                    ],
                  ),
                if (!widget.autoHeight)
                  Expanded(
                    child: Container(
                      child: ListView(
                        // itemCount: source.length,
                        children: [
                          if (widget.showSelect && widget.selecteds != null)
                            mobileHeader(),
                          if (widget.isLoading) LinearProgressIndicator(),
                          //mobileList
                          ...mList,
                        ],
                      ),
                    ),
                  ),
                //footer
                if (widget.footers != null)
                  Container(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [...widget.footers],
                    ),
                  )
              ],
            ),
          )
        /**
          * for large screen
          */
        : Container(
            child: Column(
              children: [
                //title and actions
                if (widget.title != null || widget.actions != null)
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.title != null) widget.title,
                        if (widget.actions != null) ...widget.actions
                      ],
                    ),
                  ),

                //desktopHeader
                if (widget.headers != null && widget.headers.isNotEmpty)
                  desktopHeader(),

                if (widget.isLoading) LinearProgressIndicator(),

                if (widget.autoHeight) Column(children: dList),
                if (!widget.autoHeight)
                  // desktopList
                  if (widget.source != null && widget.source.isNotEmpty)
                    Expanded(
                        child: Container(
                            child: DraggableScrollbar.semicircle(
                                key: Key(dList.length.toString()),
                                scrollbarAnimationDuration:
                                    Duration(milliseconds: 100),
                                alwaysVisibleScrollThumb: true,
                                controller: scrollController,
                                child: ListView(
                                  controller: scrollController,
                                  children: dList,
                                )))),
                //footer
                if (widget.footers != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [...widget.footers],
                  )
              ],
            ),
          );
  }
}
