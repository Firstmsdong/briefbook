import 'package:briefbook/main/item/home_item.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> with SingleTickerProviderStateMixin {
  TabController tabController;

  List<String> topTabList = ["推荐", "动态", "Java", "程序人生", "移动开发", "数据算法", "程序感言"];
  List<Widget> bodyPageList = [];
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: topTabList.length, vsync: this);
    for (var i = 0; i < topTabList.length; i++) {
      bodyPageList.add(HomeItmePage(i, topTabList[i]));
    }
    print(bodyPageList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool flag) {
          return [
            SliverAppBar(
              pinned: true, //固定到可移动导航栏  SliverAppBar 是否可以固定
              floating: true,
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      print("点击添加");
                    })
              ],
              title: Ink(
                child: InkWell(
                  child: Container(
                    // color: Colors.grey,
                    height: 33.0,
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Color(0xFF9E9E9E), width: 0.5),
                        color: Colors.grey[400],
                        borderRadius: new BorderRadius.circular((20.0))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                          child: Icon(Icons.search),
                        ),
                        Text(
                          '搜索',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print("点击搜索了");
                  },
                ),
              ),
              bottom: TabBar(
                // 设置可以滑动
                isScrollable: true,
                controller: tabController,
                tabs: topTabList
                    .map((String tabTitle) => Tab(
                          text: tabTitle,
                        ))
                    .toList(),
              ),
            )
          ];
        },
        body: TabBarView(
          children: bodyPageList,
          controller: tabController,
        ),
      ),
    );
  }
}
