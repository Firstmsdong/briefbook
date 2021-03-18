import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeItmePage extends StatefulWidget {
  num pageIndex;
  String pageTitle;

  HomeItmePage(this.pageIndex, this.pageTitle);
  // HomeItmePage({Key key}) : super(key: key);

  @override
  _HomeItmePageState createState() => _HomeItmePageState();
}
class _HomeItmePageState extends State<HomeItmePage> {
  List<String> swiperUrlList = [
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3404221704,526751635&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1672899580,3363459780&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2077625409,245021064&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=229065980,2895464780&fm=26&gp=0.jpg",
    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2204992619,610693671&fm=26&gp=0.jpg"
  ];

  get icon => null;
  RefreshController _refreshController = new RefreshController();
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 3000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: buildListView(),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
        padding: EdgeInsets.all(0.0),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              height: 150.0,
              child: Swiper(
                itemHeight: 150.0,
                itemCount: swiperUrlList.length,
                itemBuilder: (BuildContext context, int swiperIndex) {
                  return Image.network(
                    swiperUrlList[swiperIndex],
                    fit: BoxFit.cover,
                  );
                },
              ),
            );
          }

          return Container(
            // height: 140,
            margin: EdgeInsets.only(top: 2),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "一个男生追了我三年",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Text(
                    "一个男生追了我三年，我一直没同意，他放弃了，然后我才发现生活中处处是他的影子。老话说得好：“习惯成自然。”再不喜欢的事物，天天相处，时间长了也会有着别样的情愫。“习惯成自然。”再不喜欢的事物，天天相处，时间长了也会有着别样的情愫",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  child: Row(
                    children: [
                      Text("华髂骨"),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.blue,
                            size: 18,
                          ),
                          Text("3"),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.blue,
                            size: 18,
                          ),
                          Text("3"),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
