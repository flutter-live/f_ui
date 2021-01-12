import 'package:f_ui/utils/reg_exp_utils.dart';
import 'package:flutter/services.dart';

/// @description: 输入框输入规则
/// @date: 2020-11-09 14:44:12

/*
 * @description 禁止输入空格
 * @date: 2020-11-09 14:45:16
*/

class NoSpacesTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (newValue.text.contains(' ')) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/*
 * @description 不能超过传递值的大小
 * @date: 2020-11-09 16:27:50
*/
class NoMaxLengthTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  NoMaxLengthTextInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (newValue.text.length > maxLength) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/*
 * @description 不能小于传递值的大小
 * @date: 2020-11-09 16:27:50
*/
class NoMinLengthTextInputFormatter extends TextInputFormatter {
  final int minLength;

  NoMinLengthTextInputFormatter(this.minLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (value.isNotEmpty) {
      if (int.parse(newValue.text) < minLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }

    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/*
 * @description 不能大于传递值的大小
 * @date: 2020-11-09 16:27:50
*/
class NoMaxTextInputFormatter extends TextInputFormatter {
  final num maxValue;

  NoMaxTextInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (value.isNotEmpty) {
      if (num.parse(newValue.text) > maxValue) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }

    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/*
 * @description 只允许输入正整数
 * @date: 2020-11-09 16:27:50
*/
class IntegerTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (value.isNotEmpty) {
      if (!FRegExpUtils.isInteger(value)) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }

    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/*
 * @description 只能输入合法小数
 * @date: 2020-11-09 16:27:50
*/
class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
        value != defaultDouble.toString() &&
        strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/*
 * @description 仅允许输入字母
 * @date: 2020-11-09 14:45:16
*/

class OnlyLetterTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    if (!FRegExpUtils.isOnlyLetter(newValue.text)) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
