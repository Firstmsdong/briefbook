import 'package:briefbook/bean/bean_video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FindVieoItemPage extends StatefulWidget {
  String tabValue;
  VideoModel videoModel;
  FindVieoItemPage(this.tabValue, this.videoModel);
  @override
  _FindVieoItemPageState createState() => _FindVieoItemPageState();
}

class _FindVieoItemPageState extends State<FindVieoItemPage> {
  //创建视频播放控制器
  VideoPlayerController videoPlayController;
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
            Container(
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
                        child: Image.asset(""),
                      ),
                    ),
                  )
                ],
              ),
            )
            // 评论
            // 喜欢
            // 转发
          ],
        ),
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
}
