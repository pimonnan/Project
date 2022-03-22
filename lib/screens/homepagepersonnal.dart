import 'package:flutter/material.dart';
import 'package:projectnan/untils/bouncingbutton.dart';
import 'package:projectnan/untils/dashboardcards.dart';

class Homepagepersonnel extends StatefulWidget {
  const Homepagepersonnel({Key key}) : super(key: key);

  @override
  _HomepagepersonnelState createState() => _HomepagepersonnelState();
}

class _HomepagepersonnelState extends State<Homepagepersonnel>
    with SingleTickerProviderStateMixin {
  Animation delayedAnimation;
  AnimationController animationController;

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
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            new GlobalKey<ScaffoldState>();
        return Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                title: Text('หน้าแรก'),
                centerTitle: true,
                actions: [
                  IconButton(icon: Icon(Icons.add), onPressed: () {}),
                ],
                backgroundColor: Color(0xFF478DE0),
              ),
            ],
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                  child: Container(
                    alignment: Alignment(1.0, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: Bouncing(
                                onPress: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Activity()),
                                  // );
                                },
                                child: DashboardCard(
                                  name: "ข้อมูลส่วนตัว",
                                  imgpath: "profile.png",
                                )),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: Bouncing(
                                onPress: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Activity()),
                                  // );
                                },
                                child: DashboardCard(
                                  name: "งานกิจกรรม",
                                  imgpath: "activity.png",
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                  child: Container(
                    alignment: Alignment(1.0, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: Bouncing(
                                onPress: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Activity()),
                                  // );
                                },
                                child: DashboardCard(
                                  name: "ประวัติเข้ากิจกรรม",
                                  imgpath: "profile.png",
                                )),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: Bouncing(
                                onPress: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Activity()),
                                  // );
                                },
                                child: DashboardCard(
                                  name: "ตั้งค่า",
                                  imgpath: "profile.png",
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
