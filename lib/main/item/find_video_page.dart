import 'dart:ui';

import 'package:briefbook/bean/bean_video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../bean/bean_video.dart';

class FindVieoItemPage extends StatefulWidget {
  String tabValue;
  VideoModel videoModel;
  FindVieoItemPage(this.tabValue, this.videoModel);
  @override
  _FindVieoItemPageState createState() => _FindVieoItemPageState();
}

class _FindVieoItemPageState extends State<FindVieoItemPage> {
  //创建视频播放控制器
  late VideoPlayerController videoPlayController;
  // 控制更新视频加载初始化完成状态更新
  Future videoPlayFuture;
  @override
  void initState() {
    super.initState();
    videoPlayController = VideoPlayerController.network(widget.videoModel.videoUrl);
    videoPlayFuture = videoPlayController.initialize().then((_) {
      // 视频初始化完成
      // 调用播放
      videoPlayController.play();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 播放视频
        buidlVideoWidget(),
        // 控制播放视屏按钮
        buildControllWidget(),
        // 底部区域视频介绍
        buildBttomFlagWidget(),
        // 右侧的用户信息按钮区域
        buildRightUserWidget(),
      ],
    );
  }

  // 右侧的用户信息按钮区域
  Align buildRightUserWidget() {
    return Align(
      alignment: Alignment(1, 0.4),
      child: Container(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 用户信息
            buildUserMsg(),
            // 喜欢
            buildLikeWidget(
                assetImage: widget.videoModel.isLike ? "images/2.0/hongxin.png" : "images/2.0/hongxin_sel.png",
                msgCount: 233,
                callback: () {}),
            // 评论
            buildLikeWidget(
                assetImage: "images/2.0/pinglun.png",
                msgCount: 10,
                callback: () {
                  showBttomFoncton(1);
                }),
            // 转发
            buildLikeWidget(
                assetImage: "images/2.0/zhuanfa.png",
                msgCount: 10,
                callback: () {
                  showBttomFoncton(2);
                }),
          ],
        ),
      ),
    );
  }

  // 用户信息
  Container buildUserMsg() {
    return Container(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: ClipOval(
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey,
                child: Image.network(
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic4.zhimg.com%2F50%2Fv2-cde006d8fb2711dcf86a373018c42c5d_hd.jpg&refer=http%3A%2F%2Fpic4.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619141862&t=39b2b0a91d20de70698fcd2c9061d1a4"),
              ),
            ),
          ),
          widget.videoModel.isAttention
              ? Container()
              : Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Positioned buildBttomFlagWidget() {
    return Positioned(
      left: 0,
      right: 64,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
        color: Color(0x60ffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "@早起的年轻人",
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 14,
            ),
            Text("三十年合同，三十年河西，请看我的哈哈？？？？？？？？",
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  //控制播放视屏按钮
  buildControllWidget() {
    Widget itemWidget = Container();
    if (videoPlayController.value.isInitialized && !videoPlayController.value.isPlaying) {
      itemWidget = InkWell(
        onTap: () {
          if (videoPlayController.value.isInitialized && !videoPlayController.value.isPlaying) {
            videoPlayController.play();
            setState(() {});
          }
        },
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          child: Icon(Icons.play_arrow),
        ),
      );
    }
    return Align(
      alignment: Alignment(0, 0),
      child: itemWidget,
    );
  }

  // 播放视频
  buidlVideoWidget() {
    return FutureBuilder(
      future: videoPlayFuture,
      builder: (BuildContext context, value) {
        if (value.connectionState == ConnectionState.done) {
          return InkWell(
            onTap: () {
              if (videoPlayController.value.isInitialized) {
                // 已经初始化
                if (videoPlayController.value.isPlaying) {
                  // 播放变成暂停
                  videoPlayController.pause();
                } else {
                  // 暂停变成播放
                  videoPlayController.play();
                }
                setState(() {});
              } else {
                // 未初始化
                videoPlayController.initialize().then((_) {
                  videoPlayController.play();
                  setState(() {});
                });
              }
            },
            child: Center(
              child: AspectRatio(
                // 设置视频的大小
                aspectRatio: videoPlayController.value.aspectRatio,
                // 播放视频的插件
                child: VideoPlayer(videoPlayController),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayController.dispose();
  }

  buildLikeWidget({String assetImage, int msgCount, Null Function() callback}) {
    return InkWell(
      onTap: () {
        print("点击了");
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          child: Column(
            children: [
              Container(width: 35, height: 35, child: Image.asset(assetImage)),
              Text("$msgCount",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // 创建底部弹框
  void showBttomFoncton(int i) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          if (i == 1) {
            // 评论
            return commentItemFunction();
          } else {
            // 分享
            return shareItemFunction();
          }
        });
  }

  // 评论
  Widget commentItemFunction() {
    return Container(
      color: Colors.white,
      height: 399,
      child: Column(
        children: [
          // alignment: Alignment(0, 0),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.only(top: 5, right: 10),
            child: Stack(children: [
              Align(
                alignment: Alignment(0, 0),
                child: Text(
                  "评论区",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Align(
                  alignment: Alignment(1, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
              child: Container(
                  child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCommentItem();
                      })))
        ],
      ),
    );
  }

  List<String> nameItem = ["微信", "朋友圈", "QQ", "QQ空间", "微博", "链接"];
  List<String> urlItem = [
    "images/2.0/weixin.png",
    "images/2.0/pengyouquan.png",
    "images/2.0/qq.png",
    "images/2.0/QQkongjian.png",
    "images/2.0/weibo.png",
    "images/2.0/lianjie.png"
  ];
  // 分享
  shareItemFunction() {
    return Container(
      color: Colors.white,
      height: 270,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            height: 200,
            child: GridView.builder(
                itemCount: nameItem.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisSpacing: 5.0, childAspectRatio: 1.0),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Image.asset(
                        urlItem[index],
                        width: 40,
                        height: 40,
                      ),
                      Text(nameItem[index])
                    ],
                  );
                }),
          ),
          Container(height: 1, color: Colors.grey),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("取消"),
            ),
          ),
        ],
      ),
    );
  }

  // 评论列表
  buildCommentItem() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 25, height: 25, child: Image.asset("images/2.0/hongxin.png")),
          Expanded(
            child: Column(
              // ?
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "小二的前任",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "上辈子的1000次回眸，才换来今日的擦肩而过，且行且珍惜，兄弟回去吧，小三在等你了",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  padding: EdgeInsets.all(3),
                  decoration:
                      BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    "6小时之前",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VideoPlayerController {
  initialize() {}
}

class State {
}

class BoxDecoration {
}

class Container {
}
