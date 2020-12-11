/// @description: 路由工具类
/// @date: 2020/11/7

class RouterUtils{
  ///截取路径
  static String subStr(String path){
    if(path == null) return null;
    var isSay = path.indexOf('?');
    if(isSay > -1){
      return path.substring(0, isSay);
    }else{
      return path;
    }
  }

  //序列化对象，回去传值参数
  static Map<String, dynamic> serialize(String path){
    if(path == null) return null;
    Map<String, dynamic> map = Map<String, dynamic>();
    var isSay = path.indexOf('?');
    if(isSay > -1){
      String value = path.substring(isSay + 1, path.length);
      var sp = value.split('&');
      if(sp != null){
        sp.forEach((e) {
          var m = e.split('=');
          if(m != null) map[m[0]] = m[1];
        });
      }
      return map;
    }else{
      return null;
    }
  }




}