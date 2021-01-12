import 'dart:ui';
import 'package:flutter/material.dart' hide ExpansionTile;
import 'package:flutter/widgets.dart';

/// A material widget that is meant to be displayed at the left or right of an
/// app to navigate between a small number of views, typically between three and
/// five.
///
/// The navigation rail is meant for layouts with wide viewports, such as a
/// desktop web or tablet landscape layout. For smaller layouts, like mobile
/// portrait, a [BottomNavigationBar] should be used instead.
///
/// A navigation rail is usually used as the first or last element of a [Row]
/// which defines the app's [Scaffold] body.
///
/// The appearance of all of the [NavigationRail]s within an app can be
/// specified with [NavigationRailTheme]. The default values for null theme
/// properties are based on the [Theme]'s [ThemeData.textTheme],
/// [ThemeData.iconTheme], and [ThemeData.colorScheme].
///
/// Adaptive layouts can build different instances of the [Scaffold] in order to
/// have a navigation rail for more horizontal layouts and a bottom navigation
/// bar for more vertical layouts. See
/// [https://github.com/flutter/samples/blob/master/experimental/web_dashboard/lib/src/widgets/third_party/adaptive_scaffold.dart]
/// for an example.
///
/// {@tool dartpad --template=stateful_widget_material_no_null_safety}
///
/// This example shows a [NavigationRail] used within a Scaffold with 3
/// [NavigationRailDestination]s. The main content is separated by a divider
/// (although elevation on the navigation rail can be used instead). The
/// `_selectedIndex` is updated by the `onDestinationSelected` callback.
///
/// ```dart
/// int _selectedIndex = 0;
///
///  @override
///  Widget build(BuildContext context) {
///    return Scaffold(
///      body: Row(
///        children: <Widget>[
///          NavigationRail(
///            selectedIndex: _selectedIndex,
///            onDestinationSelected: (int index) {
///              setState(() {
///                _selectedIndex = index;
///              });
///            },
///            labelType: NavigationRailLabelType.selected,
///            destinations: [
///              NavigationRailDestination(
///                icon: Icon(Icons.favorite_border),
///                selectedIcon: Icon(Icons.favorite),
///                label: Text('First'),
///              ),
///              NavigationRailDestination(
///                icon: Icon(Icons.bookmark_border),
///                selectedIcon: Icon(Icons.book),
///                label: Text('Second'),
///              ),
///              NavigationRailDestination(
///                icon: Icon(Icons.star_border),
///                selectedIcon: Icon(Icons.star),
///                label: Text('Third'),
///              ),
///            ],
///          ),
///          VerticalDivider(thickness: 1, width: 1),
///          // This is the main content.
///          Expanded(
///            child: Center(
///              child: Text('selectedIndex: $_selectedIndex'),
///            ),
///          )
///        ],
///      ),
///    );
///  }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Scaffold], which can display the navigation rail within a [Row] of the
///    [Scaffold.body] slot.
///  * [NavigationRailDestination], which is used as a model to create tappable
///    destinations in the navigation rail.
///  * [BottomNavigationBar], which is a similar navigation widget that's laid
///     out horizontally.
///  * [https://material.io/components/navigation-rail/]
class FNavigationRail extends StatefulWidget {
  /// Creates a material design navigation rail.
  ///
  /// The value of [destinations] must be a list of one or more
  /// [NavigationRailDestination] values.
  ///
  /// If [elevation] is specified, it must be non-negative.
  ///
  /// If [minWidth] is specified, it must be non-negative, and if
  /// [minExtendedWidth] is specified, it must be non-negative and greater than
  /// [minWidth].
  ///
  /// The argument [extended] must not be null. [extended] can only be set to
  /// true when when the [labelType] is null or [NavigationRailLabelType.none].
  ///
  /// If [backgroundColor], [elevation], [groupAlignment], [labelType],
  /// [unselectedLabelTextStyle], [selectedLabelTextStyle],
  /// [unselectedIconTheme], or [selectedIconTheme] are null, then their
  /// [NavigationRailThemeData] values will be used. If the corresponding
  /// [NavigationRailThemeData] property is null, then the navigation rail
  /// defaults are used. See the individual properties for more information.
  ///
  /// Typically used within a [Row] that defines the [Scaffold.body] property.
  const FNavigationRail({
    this.backgroundColor,
    this.extended = false,
    this.leading,
    this.trailing,
    @required this.destinations,
    @required this.selectedIndex,
    this.onDestinationSelected,
    this.elevation,
    this.groupAlignment,
    this.labelType,
    this.unselectedLabelTextStyle,
    this.selectedLabelTextStyle,
    this.unselectedIconTheme,
    this.selectedIconTheme,
    this.minWidth,
    this.minExtendedWidth,
    this.direction = Axis.vertical,
    this.padding = const EdgeInsets.all(0),
    this.hoverColor,
    this.splashColor,
  })  : assert(destinations != null),
        assert(selectedIndex != null),
        assert(selectedIndex != null),
        assert(elevation == null || elevation > 0),
        assert(minWidth == null || minWidth > 0),
        assert(minExtendedWidth == null || minExtendedWidth > 0),
        assert((minWidth == null || minExtendedWidth == null) ||
            minExtendedWidth >= minWidth),
        assert(extended != null),
        assert(!extended ||
            (labelType == null || labelType == NavigationRailLabelType.none));

  /// Sets the color of the Container that holds all of the [NavigationRail]'s
  /// contents.
  ///
  /// The default value is [NavigationRailThemeData.backgroundColor]. If
  /// [NavigationRailThemeData.backgroundColor] is null, then the default value
  /// is based on [ColorScheme.surface] of [ThemeData.colorScheme].
  final Color backgroundColor;

  /// Indicates that the [NavigationRail] should be in the extended state.
  ///
  /// The extended state has a wider rail container, and the labels are
  /// positioned next to the icons. [minExtendedWidth] can be used to set the
  /// minimum width of the rail when it is in this state.
  ///
  /// The rail will implicitly animate between the extended and normal state.
  ///
  /// If the rail is going to be in the extended state, then the [labelType]
  /// must be set to [NavigationRailLabelType.none].
  ///
  /// The default value is false.
  final bool extended;

  /// The leading widget in the rail that is placed above the destinations.
  ///
  /// It is placed at the top of the rail, above the [destinations]. Its
  /// location is not affected by [groupAlignment].
  ///
  /// This is commonly a [FloatingActionButton], but may also be a non-button,
  /// such as a logo.
  ///
  /// The default value is null.
  final Widget leading;

  /// The trailing widget in the rail that is placed below the destinations.
  ///
  /// The trailing widget is placed below the last [NavigationRailDestination].
  /// It's location is affected by [groupAlignment].
  ///
  /// This is commonly a list of additional options or destinations that is
  /// usually only rendered when [extended] is true.
  ///
  /// The default value is null.
  final Widget trailing;

  /// Defines the appearance of the button items that are arrayed within the
  /// navigation rail.
  ///
  /// The value must be a list of two or more [NavigationRailDestination]
  /// values.
  final List<NavigationRailDestinationItem> destinations;

  /// The index into [destinations] for the current selected
  /// [NavigationRailDestination].
  final String selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the navigation rail needs to keep
  /// track of the index of the selected [NavigationRailDestination] and call
  /// `setState` to rebuild the navigation rail with the new [selectedIndex].
  final ValueChanged<String> onDestinationSelected;

  /// The rail's elevation or z-coordinate.
  ///
  /// If [Directionality] is [TextDirection.LTR], the inner side is the right
  /// side, and if [Directionality] is [TextDirection.RTL], it is the left side.
  ///
  /// The default value is 0.
  final double elevation;

  /// The vertical alignment for the group of [destinations] within the rail.
  ///
  /// The [NavigationRailDestination]s are grouped together with the [trailing]
  /// widget, between the [leading] widget and the bottom of the rail.
  ///
  /// The value must be between -1.0 and 1.0.
  ///
  /// If [groupAlignment] is -1.0, then the items are aligned to the top. If
  /// [groupAlignment] is 0.0, then the items are aligned to the center. If
  /// [groupAlignment] is 1.0, then the items are aligned to the bottom.
  ///
  /// The default is -1.0.
  ///
  /// See also:
  ///   * [Alignment.y]
  ///
  final double groupAlignment;

  /// Defines the layout and behavior of the labels for the default, unextended
  /// [NavigationRail].
  ///
  /// When a navigation rail is [extended], the labels are always shown.
  ///
  /// The default value is [NavigationRailThemeData.labelType]. If
  /// [NavigationRailThemeData.labelType] is null, then the default value is
  /// [NavigationRailLabelType.none].
  ///
  /// See also:
  ///
  ///   * [NavigationRailLabelType] for information on the meaning of different
  ///   types.
  final NavigationRailLabelType labelType;

  /// The [TextStyle] of a destination's label when it is unselected.
  ///
  /// When one of the [destinations] is selected the [selectedLabelTextStyle]
  /// will be used instead.
  ///
  /// The default value is based on the [Theme]'s [TextTheme.bodyText1]. The
  /// default color is based on the [Theme]'s [ColorScheme.onSurface].
  ///
  /// Properties from this text style, or
  /// [NavigationRailThemeData.unselectedLabelTextStyle] if this is null, are
  /// merged into the defaults.
  final TextStyle unselectedLabelTextStyle;

  /// The [TextStyle] of a destination's label when it is selected.
  ///
  /// When a [NavigationRailDestination] is not selected,
  /// [unselectedLabelTextStyle] will be used.
  ///
  /// The default value is based on the [TextTheme.bodyText1] of
  /// [ThemeData.textTheme]. The default color is based on the [Theme]'s
  /// [ColorScheme.primary].
  ///
  /// Properties from this text style,
  /// or [NavigationRailThemeData.selectedLabelTextStyle] if this is null, are
  /// merged into the defaults.
  final TextStyle selectedLabelTextStyle;

  /// The visual properties of the icon in the unselected destination.
  ///
  /// If this field is not provided, or provided with any null properties, then
  /// a copy of the [IconThemeData.fallback] with a custom [NavigationRail]
  /// specific color will be used.
  ///
  /// The default value is Is the [Theme]'s [ThemeData.iconTheme] with a color
  /// of the [Theme]'s [ColorScheme.onSurface] with an opacity of 0.64.
  /// Properties from this icon theme, or
  /// [NavigationRailThemeData.unselectedIconTheme] if this is null, are
  /// merged into the defaults.
  final IconThemeData unselectedIconTheme;

  /// The visual properties of the icon in the selected destination.
  ///
  /// When a [NavigationRailDestination] is not selected,
  /// [unselectedIconTheme] will be used.
  ///
  /// The default value is Is the [Theme]'s [ThemeData.iconTheme] with a color
  /// of the [Theme]'s [ColorScheme.primary]. Properties from this icon theme,
  /// or [NavigationRailThemeData.selectedIconTheme] if this is null, are
  /// merged into the defaults.
  final IconThemeData selectedIconTheme;

  /// The smallest possible width for the rail regardless of the destination's
  /// icon or label size.
  ///
  /// The default is 72.
  ///
  /// This value also defines the min width and min height of the destinations.
  ///
  /// To make a compact rail, set this to 56 and use
  /// [NavigationRailLabelType.none].
  final double minWidth;

  /// The final width when the animation is complete for setting [extended] to
  /// true.
  ///
  /// This is only used when [extended] is set to true.
  ///
  /// The default value is 256.
  final double minExtendedWidth;

  final Axis direction;

  final EdgeInsets padding;

  final Color hoverColor;

  final Color splashColor;

  static Animation<double> extendedAnimation(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ExtendedNavigationRailAnimation>()
        .animation;
  }

  @override
  _FNavigationRailState createState() => _FNavigationRailState();
}

class AnimationControllerRest {
  final String selected;
  final AnimationController animationController;

  AnimationControllerRest({this.selected, this.animationController});
}

class _FNavigationRailState extends State<FNavigationRail>
    with TickerProviderStateMixin {
  List<String> listIndex = [];
  bool initiallyExpanded;

  @override
  void didUpdateWidget(covariant FNavigationRail oldWidget) {
    // TODO: implement didUpdateWidget
    listIndex.clear();
    List li = widget.selectedIndex.split('-');
    for (int i = 0; i < li.length; i++) {
      if (i > 0) {
        listIndex.add('${listIndex[i - 1]}-${li[i]}');
      } else {
        listIndex.add('${li[i]}');
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NavigationRailThemeData navigationRailTheme =
        NavigationRailTheme.of(context);
    final Color backgroundColor = widget.backgroundColor ??
        navigationRailTheme.backgroundColor ??
        theme.colorScheme.surface;
    final double elevation =
        widget.elevation ?? navigationRailTheme.elevation ?? 0;
    final double minWidth = widget.minWidth ?? _minRailWidth;
    final double minExtendedWidth =
        widget.minExtendedWidth ?? _minExtendedRailWidth;
    final Color baseSelectedColor = theme.colorScheme.primary;
    final Color baseUnselectedColor =
        theme.colorScheme.onSurface.withOpacity(0.64);
    final IconThemeData defaultUnselectedIconTheme =
        widget.unselectedIconTheme ?? navigationRailTheme.unselectedIconTheme;
    final IconThemeData unselectedIconTheme = IconThemeData(
      size: defaultUnselectedIconTheme?.size ?? 24.0,
      color: defaultUnselectedIconTheme?.color ?? theme.colorScheme.onSurface,
      opacity: defaultUnselectedIconTheme?.opacity ?? 0.64,
    );
    final IconThemeData defaultSelectedIconTheme =
        widget.selectedIconTheme ?? navigationRailTheme.selectedIconTheme;
    final IconThemeData selectedIconTheme = IconThemeData(
      size: defaultSelectedIconTheme?.size ?? 24.0,
      color: defaultSelectedIconTheme?.color ?? theme.colorScheme.primary,
      opacity: defaultSelectedIconTheme?.opacity ?? 1.0,
    );
    final TextStyle unselectedLabelTextStyle = theme.textTheme.bodyText1
        .copyWith(color: baseUnselectedColor)
        .merge(widget.unselectedLabelTextStyle ??
            navigationRailTheme.unselectedLabelTextStyle);
    final TextStyle selectedLabelTextStyle = theme.textTheme.bodyText1
        .copyWith(color: baseSelectedColor)
        .merge(widget.selectedLabelTextStyle ??
            navigationRailTheme.selectedLabelTextStyle);
    final double groupAlignment =
        widget.groupAlignment ?? navigationRailTheme.groupAlignment ?? -1.0;
    final NavigationRailLabelType labelType = widget.labelType ??
        navigationRailTheme.labelType ??
        NavigationRailLabelType.none;

    final EdgeInsets itemPadding =
        widget.labelType == NavigationRailLabelType.selected ||
                widget.labelType == NavigationRailLabelType.none
            ? const EdgeInsets.all(0)
            : widget.padding;

    final ColorScheme colors = Theme.of(context).colorScheme;

    ExpansionTile setExpansionTile(NavigationRailDestinationItem item) {
      ///判斷是否有子集
      bool isChildren =
          item.children != null && item.children.length > 0 ? true : false;
      initiallyExpanded =
          listIndex.indexOf(item.index) > 0 && isChildren ? true : false;

      final splashColor =
          widget.splashColor ?? colors.primary.withOpacity(0.12);

      final hoverColor = widget.hoverColor ?? colors.primary.withOpacity(0.14);

      ///判断
      return ExpansionTile(
        padding: itemPadding,
        initiallyExpanded: initiallyExpanded,
        splashColor: splashColor,
        backgroundColor: widget.selectedIndex == item.index && !isChildren
            ? hoverColor
            : null,
        hoverColor: hoverColor,
        onExpansionChanged: (flag) {
          widget.onDestinationSelected(item.index);
        },
        title: _RailDestination(
          minWidth: minWidth,
          minExtendedWidth: minExtendedWidth,
          direction: widget.direction,
          selected: widget.selectedIndex == item.index,
          icon: widget.selectedIndex == item.index && !isChildren
              ? item.item.selectedIcon
              : item.item.icon,
          label: item.item.label,
          labelType: labelType,
          iconTheme: widget.selectedIndex == item.index && !isChildren
              ? selectedIconTheme
              : unselectedIconTheme,
          labelTextStyle: widget.selectedIndex == item.index && !isChildren
              ? selectedLabelTextStyle
              : unselectedLabelTextStyle,
        ),
        children: [],
      );
    }

    void expansionTiles(
        List<NavigationRailDestinationItem> ls, List<ExpansionTile> lt) {
      ls.forEach((e) {
        var d = setExpansionTile(e);

        if (e.children != null && e.children.length > 0) {
          expansionTiles(e.children, d.children);
        }
        lt?.add(d);
      });
    }

    List<ExpansionTile> expansionTileItem() {
      List<ExpansionTile> listTiles = [];
      expansionTiles(widget.destinations, listTiles);
      return listTiles;
    }

    return Semantics(
      explicitChildNodes: true,
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        child: Column(
          children: [
            if (widget.leading != null) ...<Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: minExtendedWidth,
                ),
                child: widget.leading,
              ),
            ],
            Expanded(
              child: Align(
                alignment: Alignment(0, groupAlignment),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ...expansionTileItem(),
                  ],
                ),
              ),
            ),
            if (widget.trailing != null)
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: minExtendedWidth,
                ),
                child: widget.trailing,
              ),
          ],
        ),
      ),
    );
  }

  List<NavigationRailDestinationItem> getDestinations(
      List<NavigationRailDestinationItem> list) {
    List<NavigationRailDestinationItem> ls = [];
    setDestinations(list, ls);
    return ls;
  }

  void setDestinations(List<NavigationRailDestinationItem> list,
      List<NavigationRailDestinationItem> ls) {
    list.forEach((e) {
      ls.add(e);
      if (e.children != null && e.children.length > 0) {
        setDestinations(e.children, ls);
      }
    });
  }
}

class _RailDestination extends StatelessWidget {
  _RailDestination({
    @required this.minWidth,
    @required this.minExtendedWidth,
    @required this.icon,
    @required this.label,
    @required this.labelType,
    @required this.selected,
    @required this.iconTheme,
    @required this.labelTextStyle,
    @required this.onTap,
    @required this.direction,
  })  : assert(minWidth != null),
        assert(minExtendedWidth != null),
        assert(icon != null),
        assert(label != null),
        assert(labelType != null),
        assert(selected != null),
        assert(iconTheme != null),
        assert(labelTextStyle != null);

  final double minWidth;
  final double minExtendedWidth;
  final Widget icon;
  final Widget label;
  final NavigationRailLabelType labelType;
  final bool selected;
  final IconThemeData iconTheme;
  final TextStyle labelTextStyle;
  final VoidCallback onTap;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final Widget themedIcon = IconTheme(
      data: iconTheme,
      child: icon,
    );
    final Widget styledLabel = DefaultTextStyle(
      style: labelTextStyle,
      child: label,
    );

    Widget content;
    switch (labelType) {
      case NavigationRailLabelType.all:
        BoxConstraints constraints = direction == Axis.vertical
            ? BoxConstraints(
                minWidth: minWidth,
                minHeight: minWidth,
              )
            : null;

        Widget conLabel = direction == Axis.vertical
            ? styledLabel
            : Expanded(child: styledLabel);

        content = Container(
          constraints: constraints,
          child: Flex(
            direction: direction,
            children: <Widget>[
              const SizedBox(height: _verticalDestinationPaddingWithLabel),
              themedIcon,
              const SizedBox(width: 5),
              conLabel,
              const SizedBox(height: _verticalDestinationPaddingWithLabel),
            ],
          ),
        );
        break;
    }

    return Semantics(
      container: true,
      selected: selected,
      child: Stack(children: <Widget>[
        Material(
          type: MaterialType.transparency,
          clipBehavior: Clip.none,
          child: content,
        ),
      ]),
    );
  }
}

/// Defines the behavior of the labels of a [NavigationRail].
///
/// See also:
///
///   * [NavigationRail]
enum NavigationRailLabelType {
  /// Only the [NavigationRailDestination]s are shown.
  none,

  /// Only the selected [NavigationRailDestination] will show its label.
  ///
  /// The label will animate in and out as new [NavigationRailDestination]s are
  /// selected.
  selected,

  /// All [NavigationRailDestination]s will show their label.
  all,
}

/// Defines a [NavigationRail] button that represents one "destination" view.
///
/// See also:
///
///  * [NavigationRail]

class NavigationRailDestinationItem {
  final String index;
  final NavigationRailDestination item;
  final List<NavigationRailDestinationItem> children;

  NavigationRailDestinationItem({this.index, this.item, this.children});
}

class NavigationRailDestination {
  /// Creates a destination that is used with [NavigationRail.destinations].
  ///
  /// [icon] and [label] must be non-null. When the [NavigationRail.labelType]
  /// is [NavigationRailLabelType.none], the label is still used for semantics,
  /// and may still be used if [NavigationRail.extended] is true.
  const NavigationRailDestination({
    @required this.icon,
    Widget selectedIcon,
    this.label,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  })  : selectedIcon = selectedIcon ?? icon,
        assert(icon != null);

  /// The icon of the destination.
  ///
  /// Typically the icon is an [Icon] or an [ImageIcon] widget. If another type
  /// of widget is provided then it should configure itself to match the current
  /// [IconTheme] size and color.
  ///
  /// If [selectedIcon] is provided, this will only be displayed when the
  /// destination is not selected.
  ///
  /// To make the [NavigationRail] more accessible, consider choosing an
  /// icon with a stroked and filled version, such as [Icons.cloud] and
  /// [Icons.cloud_queue]. The [icon] should be set to the stroked version and
  /// [selectedIcon] to the filled version.
  final Widget icon;

  /// An alternative icon displayed when this destination is selected.
  ///
  /// If this icon is not provided, the [NavigationRail] will display [icon] in
  /// either state. The size, color, and opacity of the
  /// [NavigationRail.selectedIconTheme] will still apply.
  ///
  /// See also:
  ///
  ///  * [NavigationRailDestination.icon], for a description of how to pair
  ///    icons.
  final Widget selectedIcon;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  /// The label for the destination.
  ///
  /// The label must be provided when used with the [NavigationRail]. When the
  /// [NavigationRail.labelType] is [NavigationRailLabelType.none], the label is
  /// still used for semantics, and may still be used if
  /// [NavigationRail.extended] is true.
  final Widget label;
}

class _ExtendedNavigationRailAnimation extends InheritedWidget {
  const _ExtendedNavigationRailAnimation({
    Key key,
    @required this.animation,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Animation<double> animation;

  @override
  bool updateShouldNotify(_ExtendedNavigationRailAnimation old) =>
      animation != old.animation;
}

class ExpansionTile extends StatefulWidget {
  ExpansionTile({
    Key key,
    this.headerBackgroundColor = Colors.white,
    this.leading,
    @required this.title,
    this.backgroundColor,
    this.iconColor = Colors.grey,
    this.onExpansionChanged,
    this.children = const <ExpansionTile>[],
    this.icon = Icons.expand_more,
    this.initiallyExpanded = false,
    this.iconMargin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(15),
    this.splashColor,
    this.hoverColor,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget leading;

  final Widget title;

  final ValueChanged<bool> onExpansionChanged;

  List<ExpansionTile> children;

  /// The color to display behind the sublist when expanded.
  final Color backgroundColor;

  /// The color to display the background of the header.
  final Color headerBackgroundColor;

  /// The color to display the icon of the header.
  final Color iconColor;

  /// A widget to display instead of a rotating arrow icon.
  final IconData icon;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  final EdgeInsets padding;

  ///icon margin
  final EdgeInsetsGeometry iconMargin;

  final Color splashColor;

  final Color hoverColor;

  @override
  _ExpansionTileState createState() => _ExpansionTileState();
}

class _ExpansionTileState extends State<ExpansionTile>
    with SingleTickerProviderStateMixin {
  bool isType = false;
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _iconColor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
  }

  @override
  void didUpdateWidget(covariant ExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _isExpanded = !_isExpanded;
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse().then<void>((void value) {
        if (!mounted) return;
        updateUI();
      });
    }
    PageStorage.of(context)?.writeState(context, _isExpanded);
    updateUI();
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  void updateUI() {
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor.value),
            child: InkResponse(
              onTap: widget.hoverColor == widget.backgroundColor
                  ? null
                  : _handleTap,
              highlightShape: BoxShape.rectangle,
              containedInkWell: true,
              splashColor: widget.splashColor,
              hoverColor: widget.hoverColor == widget.backgroundColor
                  ? null
                  : widget.hoverColor,
              child: Container(
                padding: widget.padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: widget.title),
                    //尾部按钮
                    widget.children != null && widget.children.length > 0
                        ? Container(
                            margin: widget.iconMargin,
                            child: RotationTransition(
                              turns: _iconTurns,
                              child: Icon(
                                widget.icon,
                                color: widget.iconColor,
                                size: 16,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
    final ThemeData theme = Theme.of(context);
    _borderColorTween..end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subhead.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColorTween..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool isType = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: isType ? null : Column(children: widget.children),
    );
  }
}

const double _minRailWidth = 72.0;
const double _minExtendedRailWidth = 256.0;
const double _horizontalDestinationPadding = 8.0;
const double _verticalDestinationPaddingNoLabel = 24.0;
const double _verticalDestinationPaddingWithLabel = 16.0;
const Widget _verticalSpacer = SizedBox(height: 8.0);
const Duration _kExpand = Duration(milliseconds: 200);
