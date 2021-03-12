import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
         padding: EdgeInsets.all(0.0),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              height: 150.0,
              child: Swiper(

                itemHeight: 150.0,
                itemCount: swiperUrlList.length,
                itemBuilder: (BuildContext context, int swiperIndex) {
                  return Image.network(swiperUrlList[swiperIndex],fit: BoxFit.cover,);
                },
              ),
            );
          }

          return Container(
            height: 100,
            margin: EdgeInsets.only(top: 20),
            color: Colors.green,
          );
        });
  }
}
