/// @description: 验证
/// @date: 2020-11-13 11:36:54

class FRegExpUtils {
  ///效验密码
  ///
  ///1.不能包含个别特殊字符
  ///2.必须是数字，英文大小写， 个别特殊字符
  static bool isPasswordExact(String input) {
    var mobile = new RegExp(
        r"(?![a-zA-Z]+$)(?![A-Z0-9]+$)(?![A-Z\W_]+$)(?![a-z0-9]+$)(?![a-z\W_]+$)(?![0-9\W_]+$)[a-zA-Z0-9~`!@#$%^,&*\(\)_\-=+\{\}\[\]\|\\:;\'<>.\?/]{9,}$");
    return mobile.hasMatch(input);
  }

  ///过滤url
  static bool isUrl(String src) {
    var url = new RegExp(
        r"^([hH][tT]{2}[pP]://|[hH][tT]{2}[pP][sS]://)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\\/])+$");
    return url.hasMatch(src);
  }

  ///仅允许字母
  static bool isOnlyLetter(String src) {
    var url = new RegExp(r"^[a-zA-Z]+$");
    return url.hasMatch(src);
  }
}
