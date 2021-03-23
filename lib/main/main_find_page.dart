import 'package:briefbook/bean/bean_video.dart';
import 'package:flutter/material.dart';

import 'item/find_video_page.dart';

class MainFindPage extends StatefulWidget {
  MainFindPage({Key key}) : super(key: key);

  @override
  _MainFindPageState createState() => _MainFindPageState();
}

class _MainFindPageState extends State with SingleTickerProviderStateMixin {
  List<String> tabTextlist = ["关注", "推荐"];
  List<Tab> tabWidgetList = [];
  TabController tabController;
  List<VideoModel> videoList = [];
  List<VideoModel> videoList2 = [];
  @override
  void initState() {
    super.initState();
    for (var value in tabTextlist) {
      tabWidgetList.add(Tab(
        text: "$value",
      ));
    }
    tabController = new TabController(length: tabTextlist.length, vsync: this);

    // 创建模拟数据
    for (var i = 0; i < 10; i++) {
      VideoModel videoModel = new VideoModel();
      //视频名称
      videoModel.videoName = "推荐测试数据 $i";
      //点在的个数
      videoModel.pariseCount = i * 22;
      if (i % 3 == 0) {
        videoModel.isAttention = true;
        videoModel.isLike = true;
      } else {
        videoModel.isAttention = false;
        videoModel.isLike = false;
      }
      videoModel.videoImage = '';
      videoModel.videoUrl = '';
      videoList.add(videoModel);
    }

    for (var i = 0; i < 10; i++) {
      VideoModel videoModel = new VideoModel();
      //视频名称
      videoModel.videoName = "关注测试数据 $i";
      //点在的个数
      videoModel.pariseCount = i * 22;
      // 是否关注
      videoModel.isAttention = true;
      if (i % 3 == 0) {
        videoModel.isLike = true;
      } else {
        videoModel.isLike = false;
      }
      videoModel.videoImage = '';
      videoModel.videoUrl = 'https://zhonghuio2ocommon.oss-cn-beijing.aliyuncs.com/video/video1.mp4';
      videoList2.add(videoModel);
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
    List<VideoModel> list = [];
    if (value == "推荐") {
      list = videoList;
    } else {
      list = videoList2;
    }

    return PageView.builder(
        // pageview子条目数
        itemCount: list.length,
        // 上下滑动
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          VideoModel videoModel = list[index];
          return buildPageViewItemWidget(value, videoModel);
        });
  }

    buildPageViewItemWidget(String value, VideoModel videoModel) {
    return FindVieoItemPage(value, videoModel);
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
