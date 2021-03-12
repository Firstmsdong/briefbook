// 入口文件

import 'dart:async';

import 'package:briefbook/base/base_page.dart';
import 'package:briefbook/guide_page.dart';
import 'package:briefbook/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

////应用程序的启动页面
class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

// 启动页面
// 本地数据缓存
class _IndexPageState extends BasePage<IndexPage> {
  // 是否是第一次使用
  bool misFirst;
  // 是否显示背景图
  bool mIsShowBg = false;
  // 倒计时工具类
  Timer timerCountDown;
  int countdownNum = 5;
  String codeCountdownStr = "5s";

  get navigator => null;
  @override
  void initState() {
    super.initState();
    // 加载缓存数据
    readCacheDate();
  }

  @override
  void dispose() {
    timerCountDown?.cancel();
    timerCountDown = null;
    super.dispose();
  }

  // 异步读取数据
  void readCacheDate() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    // 是否是第一次使用
    bool isFirst = prefs.getBool("flutter_x_is_first");
    print("读取缓存数据 " + "$isFirst");
    if (isFirst == null || isFirst == false) {
      // 第一次使用，
      // 去引导页
      // 保存使用标识
      prefs.setBool("flutter_x_is_first", true);
      pushRePage(GuidePage());
    } else {
      // 非第一次使用
      // 显示倒计时
      print("寄哪里了");
      reGetCountdown();
    }
    misFirst = isFirst;
    mIsShowBg = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // 构建背景图片
        buidWelcomeBg(),
        buildTimerProgress(),
        // buildLoading(),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  "images/2.0/logo.png",
                  width: 50,
                  height: 50,
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Text("欢迎您进入-app")
            ],
          ),
        )
      ],
    ));
  }

  // 设计倒计时
  void reGetCountdown() {
    setState(() {
      // 倒计时功能能设计
      if (timerCountDown != null) {
        return;
      }
      codeCountdownStr = '${countdownNum--}s';
      timerCountDown = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (countdownNum > 0) {
            codeCountdownStr = '${countdownNum--}s';
          } else {
            codeCountdownStr = '0s';
            countdownNum = 5;
            timerCountDown.cancel();
            timerCountDown = null;
            // 跳转首页面 并隐藏上个界面
            // pushPage(HomePage());
            pushHomePage();
            // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));

          }
        });
      });
    });
  }

  // 构建加载调
  buildLoading() {
    if (mIsShowBg == true) {
      return Container();
    } else {
      return Positioned(
        child: Center(
          child: SizedBox(
            width: 55,
            height: 55,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }

  // 构建背景图片
  buidWelcomeBg() {
    if (mIsShowBg == true) {
      return Image.asset("images/2.0/bg.jpeg");
    } else {
      return Container();
    }
  }

  // 构建倒计时显示
  buildTimerProgress() {
    return Positioned(
      right: 20,
      bottom: 20,
      child: InkWell(
        onTap: () {
          print('点击跳过');
          pushHomePage();
          if (timerCountDown.isActive) {
            timerCountDown.cancel();
            timerCountDown = null;
          }
        },
        child: SizedBox(
          width: 55,
          height: 55,
          child: Stack(children: [
            Center(
              child: CircularProgressIndicator(
                value: (5.0 - countdownNum) / 5.0,
              ),
            ),
            Center(
                child: Text(
              '$codeCountdownStr',
              style: TextStyle(color: Colors.black),
            ))
          ]),
        ),
      ),
    );
  }
}

class TimerUtil {
  void setOnTimerTickCallback(Null Function(int value) param0) {}

  void setInterval(int i) {}

  void setTotalTime(int i) {}

  void startTimer() {}
}
