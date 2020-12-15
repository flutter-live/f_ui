import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 页面表单字段框封装类
typedef GestureTapCallback = void Function();

class FTextField extends StatefulWidget {
  final String hintText;
  final TextStyle hintStyle;
  final int maxLength;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChange;
  final List<TextInputFormatter> inputFormatters;
  final InputBorder border;
  final EdgeInsetsGeometry contentPadding;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final int maxLines;
  final Color cursorColor;
  final GestureTapCallback onTap;
  final bool readOnly;
  final bool enabled;

  FTextField({
    this.hintText,
    this.hintStyle,
    this.icon,
    this.controller,
    this.obscureText: false,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChange,
    this.maxLength,
    this.inputFormatters,
    this.textInputAction,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.suffixIcon,
    this.prefixIcon,
    this.border = InputBorder.none,
    this.maxLines = 1,
    this.cursorColor,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
  });

  @override
  _FTextFieldState createState() => _FTextFieldState();
}

class _FTextFieldState extends State<FTextField> {
  TextEditingController controller;

  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);

    ///禁止密码选择，复制
    controller.addListener(() {
      var selection = controller.selection;
      if(widget.obscureText){
        if(selection.baseOffset != selection.extentOffset){
          controller.selection=TextSelection.collapsed(offset: controller.text.length);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    // 默认没有传入controller,需要内部释放
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color cursorColorFinal = widget.cursorColor ?? theme.accentColor;
    return ValueListenableBuilder(
      valueListenable: obscureNotifier,
      builder: (context, value, child) => Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            obscureText: value,
            cursorColor: cursorColorFinal,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChange,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            textInputAction: widget.textInputAction,
            enabled: widget.enabled,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              contentPadding: widget.contentPadding,
              border: OutlineInputBorder(),
            ),
          ),
          if (widget.enabled)
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: TextFieldSuffixIcon(
                controller: controller,
                obscureText: widget.obscureText,
                obscureNotifier: obscureNotifier,
                suffixIcon: widget.suffixIcon,
              ),
            )
        ],
      ),
    );
  }
}

///默认的显示密码小部件
class TextFieldSuffixIcon extends StatelessWidget {
  final TextEditingController controller;
  final Widget suffixIcon;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;

  TextFieldSuffixIcon({
    this.controller,
    this.obscureNotifier,
    this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: !obscureText,
          child: InkWell(
            onTap: () {
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: obscureNotifier,
              builder: (context, value, child) => Icon(
                value ? Icons.visibility_off : Icons.visibility,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        TextFieldClearIcon(controller),
        suffixIcon ?? Container(),
      ],
    );
  }
}

///默认的清空文字小部件
class TextFieldClearIcon extends StatefulWidget {
  final TextEditingController controller;

  TextFieldClearIcon(this.controller);

  @override
  _TextFieldClearIconState createState() => _TextFieldClearIconState();
}

class _TextFieldClearIconState extends State<TextFieldClearIcon> {
  ValueNotifier<bool> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      if (mounted) notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              widget.controller.clear();
            },
          );
        },
        child: Icon(Icons.close, size: 20, color: Colors.grey),
      ),
    );
  }
}
