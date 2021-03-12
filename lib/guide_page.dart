import 'package:briefbook/base/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key key}) : super(key: key);
  
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends BasePage<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (index == 2) {
            return Stack(
              children: [
                Positioned(
                  top: 0.0,
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Image.asset(
                    "images/2.0/guide${index + 1}.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 80.0,
                  child: Center(
                    child: InkWell(
                      radius: 5.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular((5.0)),
                          border: new Border.all(color: Colors.white, width: 0.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "进入首页",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ),
                      ),
                      onTap: () {
                        pushHomePage();
                      },
                    ),
                  ),
                )
              ],
            );
          }

          return new Image.asset(
            "images/2.0/guide${index + 1}.jpeg",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        // 原点指示器
        pagination: new SwiperPagination(),
        // 控制器
        control: new SwiperControl(),
      ),
    );
  }
}
