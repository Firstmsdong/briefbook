import 'package:flutter/material.dart';

class MainFindPage extends StatefulWidget {
  MainFindPage({Key key}) : super(key: key);

  @override
  _MainFindPageState createState() => _MainFindPageState();
}

class _MainFindPageState extends State with SingleTickerProviderStateMixin {
  List<String> tabTextlist = ["关注", "推荐"];
  List<Tab> tabWidgetList = [];
  TabController tabController;
  List<String> videoList = [];
  @override
  void initState() {
    super.initState();
    for (var value in tabTextlist) {
      tabWidgetList.add(Tab(
        text: "$value",
      ));
    }
    tabController = new TabController(length: tabTextlist.length, vsync: this);

    for (var i = 0; i < 10; i++) {
      videoList.add("测试数据 $i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景
          backGroundView(),
          // Tableview
          buildTableView(),
          buildTabBar()
        ],
      ),
    );
  }

  Positioned buildTabBar() {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      top: 54,
      child: Container(
          // 对其在顶部
          alignment: Alignment.topCenter,
          child: TabBar(
            controller: tabController,
            tabs: tabWidgetList,
            // 指示器的颜色
            indicatorColor: Colors.white,
            // 指示器的高度
            indicatorWeight: 2.0,
            isScrollable: true,
            // 指示器的宽度与文字对齐
            indicatorSize: TabBarIndicatorSize.label,
          )),
    );
  }

  Positioned buildTableView() {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      top: 0,
      child:
          TabBarView(controller: tabController, children: tabTextlist.map((e) => buildTableViewItemWidget(e)).toList()),
    );
  }

  // 用来创建上下滑动的页面
  Widget buildTableViewItemWidget(String value) {
    return PageView.builder(
        // pageview子条目数
        itemCount: videoList.length,
        // 上下滑动
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "$value 页面中 $index",
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  Positioned backGroundView() {
    return Positioned(
      child: Container(
        color: Colors.black,
      ),
      left: 0,
      bottom: 0,
      right: 0,
      top: 0,
    );
  }
}
