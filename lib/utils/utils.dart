import 'package:flutter/material.dart';

/// @description: 工具类
///@date: 2020/12/1 17

class Utils {
  static bool isInt(String t){
    try{
      int.parse(t);
      return true;
    }
    catch(e){
      return false;
    }
  }
}