import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectnan/model/image.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  Animation delayedAnimation;
  AnimationController animationController;
  List<MyImage> imageList = [
    MyImage('กิจกรรมไหว้ครู', 'assets/t.jpg'),
    MyImage('กิจกรรมงานกีฬาสี', 'assets/gg.jpg'),
    MyImage('กิจกรรมปฐมนิเทศ', 'assets/bo.jpg'),
    MyImage('กิจกรรมประกวดดาวเดือน', 'assets/ff.jpg'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            title: Text('การเข้าร่วมกิจกรรมของนักศึกษา'),
            centerTitle: true,
            backgroundColor: Color(0xFFFFEA18),
          ),
        ],
        body: ListView(
          children: [
            CarouselSlider(
              //Slider Container properties
              options: CarouselOptions(
                height: 260.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: imageList.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        //กรอบรูป
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        child: Image.asset(
                          item.pathImage,
                          // width: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Expanded(
                        child: Text(
                          item.nameImage,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.5,
                              fontStyle: FontStyle.italic), //ตัวหนังสือเอียง
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.yellow[300],
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "ประชาสัมพันธ์",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8.5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: Colors.green,
                              size: 25,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "< กิจกรรมปฐมนิเทศ >",
                                    style: (TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "วันที่ 11 ก.พ. 2565 ถึง 13 ก.พ. 2565" +
                                        "              ณ ห้องประชุมมหาวิทยาลัยราชภัฏธนบุรี สมุทรปราการ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.check_mark_circled_solid,
                              color: Colors.green,
                              size: 25,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "< กิจกรรมไหว้ครู >",
                                    style: (TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "วันที่ 15 ก.พ. 2565 ถึง 16 ก.พ. 2565" +
                                        "              ณ ห้องประชุมมหาวิทยาลัยราชภัฏธนบุรี สมุทรปราการ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //ทำต่อตรงนี้
          ],
        ),
      ),
    );
  }
}
