// 路由工具类

import 'dart:ffi';

import 'package:flutter/material.dart';

class RouteUtils {
  //  跳转页面
  static void pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  // 替换跳转页面
  static void pushRePage(BuildContext context, Widget page) {
    if (page == null) {
      return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  // 关闭当前页面
  static void popPage(BuildContext context) {
    Navigator.pop(context);
  }
}
