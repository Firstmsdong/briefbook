import 'package:briefbook/home_page.dart';
import 'package:briefbook/utils/route_utils.dart';
import 'package:flutter/material.dart';

// 基类
abstract class BasePage<T extends StatefulWidget> extends State<T> {
  // 打开页面
  void pushPage(Widget page) {
    RouteUtils.pushPage(context, page);
  }

  // 打开页面 并替换当前页面
  void pushRePage(Widget page) {
    RouteUtils.pushRePage(context, page);
  }

//  返回页面
  void popPage() {
    RouteUtils.popPage(context);
  }

  // 进入首页面
  void pushHomePage() {
    pushRePage(HomePage());
  }
}
