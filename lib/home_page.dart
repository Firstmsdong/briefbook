import 'package:briefbook/main/main_find_page.dart';
import 'package:briefbook/main/main_home_page.dart';
import 'package:briefbook/main/main_message.page.dart';
import 'package:briefbook/main/main_my_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 底部导航栏图标
  List<String> tabBarTitle = ["首页", "论坛", "发现", "我的"];
  // 底部栏导航栏图标
  List<String> normalIconUrl = [
    "images/2.0/tabbar_icon01.png",
    "images/2.0/tabbar_icon02.png",
    "images/2.0/tabbar_icon03.png",
    "images/2.0/tabbar_icon01.png"
  ];
  List<String> selectIconUrl = [
    "images/2.0/tabbar_icon01_fill.png",
    "images/2.0/tabbar_icon02_fill.png",
    "images/2.0/tabbar_icon03_fill.png",
    "images/2.0/tabbar_icon01_fill.png"
  ];
  // 对应的页面
  List<Widget> pageList = [MainHomePage(), MainMessagePage(), MainFindPage(), MainMyPage()];
  // 记录当前选中的页面
  num selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 当前选中的页面
      body: pageList[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 构建菜单
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "${selectIndex == 0 ? selectIconUrl[0] : normalIconUrl[0]}",
                width: 26.0,
                height: 26.0,
              ),
              title: Text(tabBarTitle[0], style: TextStyle(color: selectIndex == 0 ? Colors.black : Colors.grey))),
          BottomNavigationBarItem(
            icon: Image.asset(
              "${selectIndex == 1 ? selectIconUrl[1] : normalIconUrl[1]}",
              width: 26.0,
              height: 26.0,
            ),
            title: Text(
              tabBarTitle[1],
              style: TextStyle(color: selectIndex == 1 ? Colors.black : Colors.grey),
            ),
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                "${selectIndex == 2 ? selectIconUrl[2] : normalIconUrl[2]}",
                width: 26.0,
                height: 26.0,
              ),
              title: Text(
                tabBarTitle[2],
                style: TextStyle(color: selectIndex == 2 ? Colors.black : Colors.grey),
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                "${selectIndex == 3 ? selectIconUrl[3] : normalIconUrl[3]}",
                width: 26.0,
                height: 26.0,
              ),
              title: Text(
                tabBarTitle[3],
                style: TextStyle(color: selectIndex == 3 ? Colors.black : Colors.grey),
              )),
        ],
        onTap: (value) {
          setState(() {
            selectIndex = value;
          });
        },
        // 当前选中的页面
        currentIndex: selectIndex,
      ),
    );
  }
}

class $ {}
